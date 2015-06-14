package daos

import rent.Ubicacion

class UbicacionDAO {
	
 def Ubicacion get(int id){
		 SessionManager.getSession().get(Ubicacion,id) as Ubicacion
	}

	def void save(Ubicacion u) {
		SessionManager.getSession().saveOrUpdate(u)
	}
	
	}