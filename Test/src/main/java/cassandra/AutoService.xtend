package cassandra

import java.util.Date
import java.util.List
import rent.Auto
import rent.Ubicacion

class AutoService {
	
	//val CassandraHome home= new CassandraHome()
		
	def autosDisponiblesEn(Ubicacion ubicacion, Date fechaInicio, Date fechaFin){
		return CassandraHome.ejecutar([|
				new AutoHome().autosDisponiblesEn(ubicacion, fechaInicio, fechaFin)
		])
	}
	
}