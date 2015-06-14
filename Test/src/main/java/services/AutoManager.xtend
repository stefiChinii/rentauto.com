package services

import daos.AutoDAO
import daos.SessionManager
import rent.Auto
import rent.Ubicacion
import java.util.Date
import rent.Categoria

class AutoManager {
	
	
	def Auto consultarAuto(int id) {
		return SessionManager.runInSession([|
			new AutoDAO().get(id)
		]);
	}

	def guardarAuto(Auto auto) {
		SessionManager.runInSession([|
			new AutoDAO().save(auto)
			auto
		]);
	}
	
	def autosDisponiblesEn(Ubicacion ubicacion, Date inicio, Date fin) {
			SessionManager.runInSession([|
			var autos= new AutoDAO().autosDisponibles(ubicacion, inicio, fin)
			autos
		]);
	}
	
	def informacionDeLosautosDisponibles(Ubicacion ubicacion,Ubicacion ubicacion2,Date inicio, Date fin,Categoria categoria){
		
		SessionManager.runInSession([|
			var autos= new AutoDAO().informacionDeLosautosDisponibles(ubicacion,ubicacion2,inicio,fin,categoria)
			autos
		]);
		
	}
}