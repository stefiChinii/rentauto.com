package neo4j

import org.neo4j.graphdb.GraphDatabaseService
import sistemaRentauto.Usuario

class UsuarioService {

	def home(GraphDatabaseService graph) {
		new UsuarioHome(graph)
	}

	def eliminarNodo(Usuario usuario) {
		Neo4JService.run[home(it).eliminarNodo(usuario);null]
	}

	def getNodo(Usuario usuario) {
		Neo4JService.run[home(it).getNodo(usuario)]
	}

	def crearNodo(Usuario usuario) {
		Neo4JService.run[home(it).crearNodo(usuario); null]
	}

	def amigoDe(Usuario usuario, Usuario nuevoAmigo) {
		Neo4JService.run[home(it).amigoDe(usuario, nuevoAmigo)]
	}
	
	def amigosDe(Usuario usuario) {
		Neo4JService.run[home(it).amigosDe(usuario)]
	}
	
	def todasLasPersonasConLasQueTengoContacto(Usuario usuario){
		Neo4JService.run[home(it).todasLasPersonasConLasQueTengoContacto(usuario)]
	}
	
	/** Requerimineto 3 */
	
	def enviarMensaje(Mensaje mensaje){
		Neo4JService.run[home(it).enviarMsj(mensaje)]
	}
	
	def existeMensaje(Mensaje mensaje){
		Neo4JService.run[home(it).existeMensaje(mensaje)]
	}


/*
	def hermanos(Persona hermano1, Persona hermano2) {
//		Neo4JService.run[home(it).hermanos(hermano1, hermano2)]
	}
 
	def pradres(Persona persona) {
		Neo4JService.run[
			val home = home(it)
			home.padres(persona).map[home.crearPersona(it)].toList
		]
	}
	*/
}