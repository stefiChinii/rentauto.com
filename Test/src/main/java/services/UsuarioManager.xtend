package services

import daos.SessionManager
import register.Usuario
import daos.UsuarioDAO

class UsuarioManager {
	
	def Usuario consultarUsuario(int id) {
		return SessionManager.runInSession([|
			new UsuarioDAO().get(id)
		]);
	}

	def crearUsuario(Usuario usuario) {
		SessionManager.runInSession([|
			new UsuarioDAO().save(usuario)
			usuario
		]);
	}
}