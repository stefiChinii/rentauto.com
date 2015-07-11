package cassandra

import java.util.Date
import rent.Ubicacion
import cassandra.CassandraHome

class AutoService {
	
	//val CassandraHome home= new CassandraHome()
		
	def autosDisponiblesEn(Date fecha, Ubicacion ubicacion){
		return CassandraHome.execute([new AutoHome().autosDisponiblesEn(fecha, ubicacion)])
	}
	
}