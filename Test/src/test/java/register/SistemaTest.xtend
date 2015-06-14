package register

import junit.framework.Assert

import org.junit.Test
import org.junit.Before
import exceptions.UsuarioYaExisteException
import exceptions.ValidacionException
import exceptions.NuevaPasswordInvalidaException
import exceptions.MailNoEnviadoException

import static org.mockito.Mockito.*
import static org.mockito.Mockito.when
import exceptions.UsuarioNoExisteException

class SistemaTest {
	Usuario user
	Usuario user2
	Usuario user3
	Sistema sist
	Sistema sistFail
	String usercode
	String codigoInexistente
	EnviadorDeMails enviador
	EnviadorDeMails enviadorFail
	Mail m
	
	
	@Before
	def void setUp(){
		
		user = new Usuario("pepita", "pistolera", "cotorra01", "cotorra@mail.com", 41, "pass")
		user2 = new Usuario("casey", "wander", "casey", "casey@mail.com", 18, "price")
		user3 = new Usuario("pepe", "alonso", "rompepepe", "pepe@mail.com", 23, "hola")
		usercode = user.username
		m = new Mail("cotorra@mail.com", "noreply@mail.com", "23")
		
		//enviadores de mails mockeados
		enviador = mock(EnviadorDeMails)
		enviadorFail = mock(EnviadorDeMails)
		
		sist = new Sistema(enviador)
		sistFail = new Sistema(enviadorFail)
		
		//mockear la creacion del email, para poder testear
		when(enviador.enviarMail(m)).thenReturn(true)
		when(enviadorFail.enviarMail(any(Mail))).thenThrow(MailNoEnviadoException)
	}
	
	
	
	@Test
	def void eliminarUsuarioExistenteTest(){
		sist.registrarUsuario(user)
		sist.eliminarUsuario(user)
		Assert.assertFalse(sist.tieneUsuarioGuardado(user.username))
	}
	
	@Test
	def void tieneUsuarioGuardadoExistenteTest(){
		sist.registrarUsuario(user)
		Assert.assertTrue(sist.tieneUsuarioGuardado(user.username))
		sist.eliminarUsuario(user)
	}
	//testear excepciones de eliminarUsuario y tieneUsuarioExistente
	
	
	
	// REGISTRAR USUARIO
	@Test
	def void registrarUsuarioYEnviarMailTest (){
		//guarda un usuario en la DB, y envia el mail
		
		sist.registrarUsuario(user)
		verify(enviador).enviarMail(any(Mail))
		Assert.assertTrue(sist.tieneUsuarioGuardado(user.username))
		sist.eliminarUsuario(user)
	}
	
	
	
	@Test(expected = typeof (MailNoEnviadoException))
	def void registrarUsuarioYNoEnviarMailTest (){
		/* verifica que al registrar, si no puede enviarse el mail con el codigo de verificacion, se elimina el usuario y se lanza la excepcion */
		
		sistFail.registrarUsuario(user)
		verify(enviadorFail).enviarMail(any(Mail))
		Assert.assertFalse(sistFail.tieneUsuarioGuardado(user.username)) //esto funciona porque se ejecuta antes del throw
	}
	
	
	@Test(expected = typeof (UsuarioYaExisteException))
	def void registrarUsuarioExistenteTest (){
		/* Se intenta guardar un usuario 2 veces, se debe lanzar una excepción */
		
		sist.registrarUsuario(user2)
		sist.registrarUsuario(user2)
	}
	
	
	
	// VALIDAR CUENTA
	@Test
	def validarCuentaBienTest(){
		/* validar cuenta de un usuario a partir del codigo enviado, cambia el estado de VALIDADO a true*/
		sist.registrarUsuario(user)
		sist.validarCuenta(usercode)
		Assert.assertTrue(sist.tieneCodigoValidado(usercode))
		sist.eliminarUsuario(user)
	}
	
	
	@Test(expected = typeof (ValidacionException))
	/* verifica que no puede validarse una cuenta si el codigo no existe */
	def validarCuentaMalTest(){
		sist.validarCuenta(codigoInexistente)
	}
	
	
	
	// INGRESAR USUARIO
	@Test
	//a los efectos del sistema, 2 usuarios son iguales si el username es el mismo.
	def ingresarUsuarioBienTest(){
		sist.registrarUsuario(user)
		Assert.assertEquals(sist.ingresarUsuario("cotorra01","pass").username , user.username)
		sist.eliminarUsuario(user) 
	}
	
	
	@Test (expected = typeof (UsuarioNoExisteException))
	//falla por no haber un usuario con este username
	def void ingresarUsuarioMalTest(){
		sist.ingresarUsuario("rompepepe", "passDeUsuarioInexistente")
	}
	
	
	
	// CAMBIAR PASSWORD
	@Test
	def cambiarPasswordDeUsuarioExistenteTest(){
		//verificar que la contrasena nueva sea valida (la misma que envie)
		sist.registrarUsuario(user)
		sist.validarCuenta(usercode)
		var username = user.username
		val cont = "eclipse"
		sist.cambiarPassword(username, cont)
		Assert.assertEquals("Contraseña actualizada", cont, sist.obtenerPassDeUsuario(username))
		sist.eliminarUsuario(user)
	}
	
	
	@Test (expected = typeof (NuevaPasswordInvalidaException))
	def cambiarPasswordInvalidaTest(){
		//falla por ser la contrasena de menos de 4 caracteres
		sist.registrarUsuario(user3)
		var username = user3.username
		val cont = "sol"
		sist.cambiarPassword(username, cont)
	}
	
}


