package sistemaRentauto

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Usuario {
	String nombre //val estatico = valor 
	String apellido
	String username
	String email
	int fnac
	String password
	boolean validado
	
	new(){
		
	}
	
	new(String name, String surname, String usrn, String mail, int fn, String pass){
		nombre = name
		apellido = surname
		username =usrn
		email = mail
		fnac = fn
		password = pass
		validado=false
	}
	
	override def boolean equals(Object object){
		if(object instanceof Usuario){
			val otroUsuario = object as Usuario
			otroUsuario.nombre.equals(this.nombre) && 
			otroUsuario.apellido.equals(this.apellido) && 
			otroUsuario.username.equals(this.username)			
		}else{
			false
		}
	
	}
	
}