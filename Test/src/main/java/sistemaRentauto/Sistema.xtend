package sistemaRentauto

import exceptions.NuevaPasswordInvalidaException
import exceptions.UsuarioYaExisteException
import exceptions.UsuarioNoExisteException;
import exceptions.ValidacionException
import org.eclipse.xtend.lib.annotations.Accessors
import exceptions.MailNoEnviadoException


@Accessors
class Sistema  {
	
	Consultor cons
	EnviadorDeMails mrzip
	
	//CONSTRUCTOR
	new(EnviadorDeMails e){
		cons = new Consultor
		mrzip = e
	}
	
	// REGISTRAR USUARIO
	def registrarUsuario(Usuario usuarioNuevo)throws UsuarioYaExisteException{
		val String name = usuarioNuevo.nombre
		val String code = usuarioNuevo.username	//RANDOM
		var Mail m
		if (!cons.existeUsuario(name)){
			m = crearMail(usuarioNuevo.email, code)
			cons.registrarUsuarioBD(usuarioNuevo, code)
			 
			try {mrzip.enviarMail(m)}
			catch(MailNoEnviadoException e){
				cons.eliminarUsuarioBD(usuarioNuevo)
			 }
		}
		else{
		  	 throw new UsuarioYaExisteException
		}
	}
	
	
	// VALIDAR CUENTA
	def void validarCuenta(String codigoValidacion) throws ValidacionException{
		// El metodo permite validar la cuenta de un usuario con un codigo de validacion
		// y debe retornar exception si el codigo es incorrecto.
	    //Cada código es único
		if (cons.existeCodigoYNoEstaValidado(codigoValidacion)){
			 cons.validarUsuarioBD(codigoValidacion)
		}
		else{
		  	 throw new ValidacionException
		  }
	}
	
	
	// INGRESAR USUARIO
	def ingresarUsuario( String username, String password) throws UsuarioNoExisteException{	//LOGIN ~> ret Usuario
		if (cons.existeUsuario(username)){ //si el usuario existe
			cons.ingresarUsuarioBD(username, password)
		}
		else{
			throw new UsuarioNoExisteException 
		}
	}
	
	
	// CAMBIAR PASSWORD
	def void cambiarPassword(String username, String nuevaPassword) throws NuevaPasswordInvalidaException{
		if(nuevaPassword.length()>= 4){
			cons.cambiarPasswordBD(username,nuevaPassword)
			print ("Contraseña cambiada correctamente")
		}
		else{
			throw new NuevaPasswordInvalidaException
		}
	}
	
	
	//AUX
	def Mail crearMail(String usermail, String code){
		new Mail(usermail, "noreply@mail.com", code)
	}
	
	
	def tieneUsuarioGuardado(String un){
		cons.existeUsuario(un)
	}
	
	def void eliminarUsuario(Usuario u){
		cons.eliminarUsuarioBD(u)
	}
	
	def obtenerPassDeUsuario(String un) {
		cons.getPasswordFromUser(un)
	}
	
	def tieneCodigoValidado(String codigo) {
		cons.codigoEstaValidado(codigo)
	}
	
}
