package rent

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
class Ubicacion {
	public String nombre
	public Integer id;
	
	new(){
	}
	
	new(String nombre){
		this.nombre = nombre
	}
}

@Accessors 
class UbicacionVirtual extends Ubicacion{
	List<Ubicacion> ubicaciones
}
