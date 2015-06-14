package daos

import rent.Auto
import rent.Ubicacion
import java.util.Date
import java.util.List
import rent.Categoria

class AutoDAO {
	
	 def Auto get(int id){
		 SessionManager.getSession().get(Auto,id) as Auto
	}

	def void save(Auto a) {
		SessionManager.getSession().saveOrUpdate(a)
	}
	
	def autosDisponibles(Ubicacion ubicacion, Date inicio, Date fin) {
		var query= SessionManager.getSession().createQuery("
		 from Auto auto left join auto.reservas reserva
         where auto.ubicacionInicial = :ubicacion and 
			(reserva is null or (reserva.fin < :inicio or reserva.inicio > :inicio))")
		query.setParameter("ubicacion", ubicacion)
		query.setParameter("inicio", inicio)
		//query.setParameter("fin", fin)
		query.list as List<Auto>
	}
	
	def informacionDeLosautosDisponibles(Ubicacion ubicacion,Ubicacion ubicacion2,Date inicio, Date fin,Categoria categoria) {
		
		var query= SessionManager.getSession().createQuery("from Auto auto left join auto.reservas reserva
         where auto.categoria = :categoria and auto.ubicacionInicial = :ubicacion and 
		(reserva is null or (reserva.origen = :ubicacion and reserva.destino = :ubicacion2 and  
           reserva.fin < :inicio or reserva.inicio > :fin))
        ")
        query.setParameter("ubicacion", ubicacion)
        query.setParameter("ubicacion2", ubicacion2)
		query.setParameter("inicio", inicio)
		query.setParameter("fin", fin)
		query.setParameter("categoria", categoria)
		query.list as List<Auto>
	}
	
}