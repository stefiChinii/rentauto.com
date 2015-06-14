package neo4j

import sistemaRentauto.Usuario
import neo4j.TipoDeRelaciones
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.graphdb.Direction
import org.neo4j.graphdb.DynamicLabel
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.RelationshipType
import org.neo4j.graphdb.traversal.Evaluators
import org.neo4j.graphdb.traversal.TraversalDescription
import org.neo4j.graphdb.traversal.Traverser

@Accessors
class UsuarioHome {
	GraphDatabaseService graph

	new(GraphDatabaseService graph) {
		this.graph = graph
	}

	def userLabel() {
		DynamicLabel.label("User")
	}
	
	def msjLabel(){
		DynamicLabel.label("msg")
	}

	def eliminarNodo(Usuario usuario) {
		val nodo = getNodo(usuario)
		nodo.relationships.forEach[delete]
		nodo.delete
	}
	
	def eliminarNodo(Mensaje msj){
		val nodo= getNodo(msj)
		nodo.relationships.forEach[delete]
		nodo.delete
		}

	def getNodo(Usuario usuario) {
		graph.findNodes(userLabel, "userName",usuario.username).head
	}
	
	def getNodo(Mensaje msj){
		graph.findNodes(msjLabel, "msjLabel", msj.mensaje).head
	}

	def crearNodo(Usuario usuario) {
		val node = graph.createNode(userLabel)
		node.setProperty("nombre", usuario.nombre)
		node.setProperty("apellido", usuario.apellido)
		node.setProperty("username", usuario.username)
		node.setProperty("email", usuario.email)
		node.setProperty("fnac", usuario.fnac)
		node.setProperty("password", usuario.password)
	}
	
	def crearNodo(Mensaje msj){
		val node= graph.createNode(msjLabel)
		node.setProperty("emisor", msj.emisor)
		node.setProperty("receptor", msj.receptor)
		node.setProperty("mensaje", msj.mensaje)
	}

	def crearUsuario(Node usuario) {
		new Usuario => [
			nombre = usuario.getProperty("nombre") as String
			apellido = usuario.getProperty("apellido") as String
			username= usuario.getProperty("username") as String
			email= usuario.getProperty("email") as String
			fnac= usuario.getProperty("fnac") as Integer
			password= usuario.getProperty("password") as String
		]
	}
	
	def crearMensaje(Node mensaje){
		new Mensaje => [
			emisor= mensaje.getProperty("emisor") as Usuario
			receptor= mensaje.getProperty("receptor") as Usuario
			mensaje= mensaje.getProperty("mensaje") as String
		]
	}

 	/* requerimiento 1 */	

	def amigoDe(Usuario usuario, Usuario nuevoAmigo) {
		val usuarioNode = getNodo(usuario)
		val nvoAmigoNode = getNodo(nuevoAmigo)
		usuarioNode.createRelationshipTo(nvoAmigoNode, TipoDeRelaciones.ES_AMIGO_DE);
		nvoAmigoNode.createRelationshipTo(usuarioNode, TipoDeRelaciones.ES_AMIGO_DE);
	}
	
	/* requerimiento 2 */
	
	def amigosDe(Usuario usuario){
		amigosDe(getNodo(usuario)).toList
	}
	
	def amigosDe(Node usuario){
		nodosRelacionados(usuario, TipoDeRelaciones.ES_AMIGO_DE, Direction.OUTGOING)
	}
 
 /*requerimiento 3 */
 
 def enviarMsj(Mensaje mensaje) {
		var emisor = getNodo(mensaje.emisor)
		var receptor = getNodo(mensaje.receptor)
		//CREAR NODO MSJ
		var msg= getNodo(mensaje)
		emisor.createRelationshipTo(msg, TipoDeRelaciones.ENVIA_MENSAJE);
		receptor.createRelationshipTo(msg, TipoDeRelaciones.RECIBE_MENSAJE);
	}
 
 /*requerimiento 4 */
 
 	def todasLasPersonasConLasQueTengoContacto(Usuario usuario){
 		todasLasPersonasConLasQueTengoContacto(getNodo(usuario))
 	}
 
 	def  todasLasPersonasConLasQueTengoContacto(Node usuario)
	{
	    var TraversalDescription td = graph.traversalDescription()
	            .breadthFirst()
	            .relationships( TipoDeRelaciones.ES_AMIGO_DE, Direction.OUTGOING )
	            .evaluator( Evaluators.excludeStartPosition() )
	     		
	     		td.traverse( usuario ).toList()
	}
	
	
	/* Extra */
	
	protected def nodosRelacionados(Node nodo, RelationshipType tipo, Direction direccion) {
		nodo.getRelationships(tipo, direccion).map[it.getOtherNode(nodo)]
	}
	
	
	
}