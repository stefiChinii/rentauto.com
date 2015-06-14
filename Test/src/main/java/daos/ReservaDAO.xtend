package daos

import rent.Reserva
import rent.Ubicacion
import java.util.Date
import rent.Auto
import register.Usuario
import java.util.List
import services.ReservaManager

class ReservaDAO {
	 def Reserva get(int id){
		 SessionManager.getSession().get(Reserva,id) as Reserva
	}

	def void save(Reserva a) {
		SessionManager.getSession().saveOrUpdate(a)
		
	}
	
	def reservar(Ubicacion ubicacion, Ubicacion ubicacion2, Date date, Date date2, Auto auto, Usuario usuario) {
		var query= SessionManager.getSession().createQuery("from Reserva where ubicacionInicial = :ubicacion and :date BETWEEN inicio AND fin")
		query.setParameter("ubicacion", ubicacion)
		query.setParameter("ubicacion", ubicacion2)
		query.setParameter("date", date)
		query.setParameter("date", date2)
		query.setParameter("auto", auto)
		query.setParameter("usuario", usuario)
	}
	
	def void hacerReserva(Reserva reserva) {
		
		    var rm = new ReservaManager
		 
		 	 reserva.reservar
		 	 rm.guardarReserva(reserva)
		 	 
		 
		  
		   
	}
	

	
}