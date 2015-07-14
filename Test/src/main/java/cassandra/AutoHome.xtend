package cassandra

import java.util.Date
import rent.Ubicacion
import services.AutoManager
import rent.Auto
import java.util.List
import com.datastax.driver.core.ResultSet

class AutoHome {
	
	def crearTabla(){
		CassandraHome.getSession.execute("CREATE TABLE cassandra.autosDisponibles ("+ "Ubicacion ubicacion," +"Date inicio," 
			+ "Date fin," + "Auto auto,"+ "PRIMARY KEY ( ubicacion, inicio, fin")")"
	}
	
	def autosDisponiblesEn(Ubicacion ubicacion, Date fechaInicio, Date fechaFin){
		
		var res= CassandraHome.getSession
		var ResultSet query= res.execute("SELECT autos FROM cassandra.autosDisponibles WHERE ubicacion=ubicacion AND inicio= fechaInicio AND fin= fechaFin" )
		if (query.empty) {
			var List<Auto> resultadoHibernate= new AutoManager().autosDisponiblesEn(ubicacion, fechaInicio, fechaFin)
			for (var int i; i> resultadoHibernate.size; i++){
				query= res.execute("INSERT INTO autosDisponibles (ubicacion, inicio, fin, auto)"+"VALUES("+ "ubicacion, fechaInicio, fechaFin, resultadoHibernate.get(i) ")
			}
		}
		
		return query
		
	}
	
	
}