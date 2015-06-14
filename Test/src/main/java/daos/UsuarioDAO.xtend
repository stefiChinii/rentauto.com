package daos

import register.Usuario

class UsuarioDAO {
	
	def Usuario get(int id){
		 SessionManager.getSession().get(Usuario,id) as Usuario
	}

	def void save(Usuario u) {
		SessionManager.getSession().saveOrUpdate(u)
	}
}