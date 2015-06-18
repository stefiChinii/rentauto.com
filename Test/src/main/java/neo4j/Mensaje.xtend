package neo4j

import sistemaRentauto.Usuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Mensaje {
 	var Usuario emisor
	var Usuario receptor
	var String mensaje
	
	new(Usuario emi, Usuario recep, String msj){
		emisor= emi
		receptor= recep
		mensaje= msj
		
	}
	new (){}
	
	override def boolean equals(Object object){
		if (object instanceof Mensaje){
			val otroMsj= object as Mensaje
			otroMsj.mensaje.equals(this.mensaje)
		} else {
			false
		}
	}
	
	
	}
	
	
	