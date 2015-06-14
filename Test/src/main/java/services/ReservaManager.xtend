package services

import daos.ReservaDAO
import daos.SessionManager
import java.util.Date
import register.Usuario
import rent.Auto
import rent.Reserva
import rent.Ubicacion

class ReservaManager {
	
	def Reserva consultarReserva(int id) {
		return SessionManager.runInSession([|
			new ReservaDAO().get(id)
		]);
	}

	def guardarReserva(Reserva res) {
		SessionManager.runInSession([|
			new ReservaDAO().save(res)
			res
		]);
	}
	
	def realizarReserva(Ubicacion partida, Ubicacion destino, Date inicioReserva, Date finReserva, Auto auto, Usuario usuario) {
		SessionManager.runInSession([| 	
							var res= new ReservaDAO().reservar(partida, destino, inicioReserva, finReserva, auto, usuario)
							res
		])
		
	}
	
	def void hacerUnaReserva(Reserva reserva) {
		
		
			new ReservaDAO().hacerReserva(reserva)
			
	}
	
	
	
}