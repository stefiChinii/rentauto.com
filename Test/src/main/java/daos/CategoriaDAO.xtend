package daos

import rent.Categoria

class CategoriaDAO {
def Categoria get(int id){
	    SessionManager.getSession().get(Categoria,id) as Categoria
	}

	def void save(Categoria j) {
		SessionManager.getSession().saveOrUpdate(j);
	}
	
}