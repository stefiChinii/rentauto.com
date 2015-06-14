package register

import org.eclipse.xtend.lib.annotations.Accessors
import rent.IUsuario
import rent.Reserva
import java.util.List

@Accessors 
class Usuario implements IUsuario{
	public String nombre //val estatico = valor 
	public String apellido
	public String username
	public String email
	public int fnac
	public String password
	public boolean validado
	public Integer id
	public List<Reserva> reservas = newArrayList()
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
	
	override agregarReserva(Reserva unaReserva) {
		 
		  reservas.add(unaReserva)
	}
	
	
	
}