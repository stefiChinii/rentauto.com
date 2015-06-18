package neo4j

import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import sistemaRentauto.Usuario

class UsuarioServiceTest {
	/*TODO
	 * hacer los test, tanto para los casos favorables como para los que no (preguntar)  (tests)
	 */
	 
	 UsuarioService service
	 Usuario stefania
	 Usuario valeria
	 Usuario lucas
	 Usuario emanuel
	 Usuario rodrigo
	 
	 @Test
	def void testAgregarAmigo(){
		service.amigoDe(valeria, lucas)
		var resultado= service.amigosDe(valeria)
		Assert.assertTrue (resultado.contains(lucas))
	}
	
	@Test
	def void testListaAmigos(){
		var resultado= service.amigosDe(stefania)
		Assert.assertEquals(3,resultado.length)
		Assert.assertTrue(resultado.contains(emanuel))
		Assert.assertTrue(resultado.contains(valeria))
		Assert.assertTrue(resultado.contains(lucas))
	}
	 
	 
	 @Test
	 def void todosConLosQueEstoyConectadoTest(){
	 	var resultado= service.todasLasPersonasConLasQueTengoContacto(stefania)
	 	
	 	Assert.assertEquals(4,resultado.length)
	 	Assert.assertTrue(resultado.contains(emanuel))
		Assert.assertTrue(resultado.contains(valeria))
		Assert.assertTrue(resultado.contains(lucas))
		Assert.assertTrue(resultado.contains(rodrigo))
	 }
	 
	 @Test
	 def void enviarMensajeTest(){
	 	var Mensaje mensaje= new Mensaje(stefania, valeria, "hola, cuando nos vemos? :)")
	 	service.enviarMensaje(mensaje)
	 	Assert.assertTrue(service.existeMensaje(mensaje))
	 }
	 
	 
	 @After
	def void after(){
		service.eliminarNodo(stefania)
		service.eliminarNodo(valeria)
		service.eliminarNodo(lucas)
		service.eliminarNodo(emanuel)
		service.eliminarNodo(rodrigo)
	}
	
	
	@Before
	def void setup(){
		stefania = new Usuario => [
			nombre = "Stefania"
			apellido = "Chiniewicz"
			username= "stefi"
		];
		
		valeria = new Usuario => [
			nombre = "Valeria"
			apellido = "PÃ©rez"
			username= "vale"
		];
		
		lucas = new Usuario => [
			nombre = "Lucas"
			apellido = "PÃ©rez"
			username= "lucas"
		];
		
		emanuel = new Usuario => [
			nombre = "Emanuel"
			apellido = "PÃ©rez"
			username= "ema"
		];
		
		rodrigo= new Usuario => [
			nombre = "Rodrigo"
			apellido = "PÃ©rez"
			username= "obiwan"
		]
		
		service = new UsuarioService
		service.crearNodo(stefania)
		service.crearNodo(valeria)
		service.crearNodo(lucas)
		service.crearNodo(emanuel)
		service.crearNodo(rodrigo)
		service.amigoDe(stefania, valeria)
		service.amigoDe(stefania, lucas)
		service.amigoDe(stefania, emanuel)
		service.amigoDe(emanuel, rodrigo)
		}
		
}