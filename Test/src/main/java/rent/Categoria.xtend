package rent

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors 
abstract class Categoria {
	public String nombre
	public Integer id
	abstract def Double calcularCosto(Auto auto)
}


class Turismo extends Categoria{
	
	new (){
	}
	override calcularCosto(Auto auto) {
		if(auto.anio > 2000){
			return auto.costoBase * 1.10			
		}else{
			return auto.costoBase - 200
		}
	}
}

class Familiar extends Categoria{
	new (){
	}
	override calcularCosto(Auto auto) {
		return auto.costoBase + 200
	}
}

class Deportivo extends Categoria{
	new (){
	}
	override calcularCosto(Auto auto) {
		if(auto.anio > 2000){
			return auto.costoBase * 1.30			
		}else{
			return auto.costoBase * 1.20
		}
	}
}

class TodoTerreno extends Categoria{
	new (){
	}
	override calcularCosto(Auto auto) {
		auto.costoBase * 1.10
	}
}
