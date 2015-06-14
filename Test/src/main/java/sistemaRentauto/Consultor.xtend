package sistemaRentauto

import java.sql.Connection
import java.sql.DriverManager
import java.sql.PreparedStatement
import java.sql.ResultSet
import org.eclipse.xtext.xbase.lib.Functions.Function1

class Consultor {

	var Connection conn
	var PreparedStatement prepSt

	new() {
		conn = null
		prepSt = null
	}
	
	
	// REGISTRAR USUARIO
	def registrarUsuarioBD(Usuario usuario, String code) {
		ejecutar([conn| 
			prepSt = conn.prepareStatement("INSERT INTO Usuarios (USERNAME, PASSWORD, NOMBRE, APELLIDO, EMAIL, FNAC, CODIGO, VALIDADO) VALUES (?,?,?,?,?,?,?,?)");
			prepSt.setString(1, usuario.username)
			prepSt.setString(2, usuario.password)
			prepSt.setString(3, usuario.nombre)
			prepSt.setString(4, usuario.apellido);
			prepSt.setString(5, usuario.email);
			prepSt.setInt(6, usuario.fnac);
			prepSt.setString(7, code);
			prepSt.setBoolean(8, false);
			prepSt.execute();
			])
	}
	
	
	def existeUsuario(String uname) {
		ejecutar([conn| 
			prepSt = conn.prepareStatement("SELECT EXISTS (SELECT * FROM Usuarios WHERE USERNAME = ?)")
			prepSt.setString(1, uname)
			val ResultSet rs = prepSt.executeQuery()
			rs.next() && rs.getBoolean(1) // first column is 1
		])
	}
	
	
	// VALIDAR CUENTA
	def existeCodigoYNoEstaValidado(String s) {
		existeCodigo(s) && !codigoEstaValidado(s)
	}
	
	
	def existeCodigo(String code) {
		ejecutar([conn| 
			prepSt = conn.prepareStatement("SELECT EXISTS(SELECT * FROM Usuarios WHERE CODIGO = ?)") // devuelva true o false
			prepSt.setString(1, code)

			val ResultSet rs = prepSt.executeQuery()
			rs.next()
			rs.getBoolean(1)
		])
	}
	
	
	def codigoEstaValidado(String code) {
		ejecutar([conn| 
			prepSt = conn.prepareStatement("SELECT VALIDADO FROM Usuarios WHERE CODIGO = ?") // devuelve true o false
			prepSt.setString(1, code)

			val ResultSet rs = prepSt.executeQuery()
			rs.next()
			rs.getBoolean("VALIDADO")
			])
	}
	

	def validarUsuarioBD(String code) {
		ejecutar([conn| 
			prepSt = conn.prepareStatement("UPDATE USUARIOS SET VALIDADO = true WHERE CODIGO = ?")
			prepSt.setString(1, code)
			prepSt.execute()
		])
	}


	// INGRESAR USUARIO
	def ingresarUsuarioBD(String uname, String pass) {
		
		ejecutar([conn|
			prepSt = conn.prepareStatement("SELECT * FROM USUARIOS WHERE USERNAME=? AND PASSWORD=?") // devuelve true o false
			prepSt.setString(1, uname)
			prepSt.setString(2, pass)

			val ResultSet rs = prepSt.executeQuery()
			var Usuario n= new Usuario
			if (rs.next()) {
				n.nombre = rs.getString("NOMBRE")
				n.apellido = rs.getString("APELLIDO")
				n.username = rs.getString("USERNAME")
				n.fnac = rs.getInt("FNAC")
				n.password = rs.getString("PASSWORD")
				n.validado = rs.getBoolean("VALIDADO")
				n.email = rs.getString("EMAIL")
				return n
			}])
		
	}
	
	
	// CAMBIAR PASSWORD
	def String getPasswordFromUser(String uname) {
		ejecutar([conn| 
			prepSt = conn.prepareStatement("SELECT PASSWORD FROM USUARIOS WHERE USERNAME = ?")
			prepSt.setString(1, uname)

			val ResultSet rs = prepSt.executeQuery()
			rs.next()
			rs.getString("PASSWORD")
		])
	}
	
	
	def cambiarPasswordBD(String uname, String newPass) {
		ejecutar([conn| 
			prepSt = conn.prepareStatement("UPDATE USUARIOS SET PASSWORD = ? WHERE USERNAME = ?")
			prepSt.setString(1, newPass)
			prepSt.setString(2, uname)
			prepSt.execute();
		])
	}
	
	//ELIMINAR USUARIO
	def eliminarUsuarioBD(Usuario u){
		
		ejecutar([conn| 
			prepSt = conn.prepareStatement("DELETE FROM USUARIOS  WHERE USERNAME = ?")
			prepSt.setString(1,u.username)
			
			prepSt.execute();
		])
		
	}
	
	
	//EXECUTE
	def <T> T ejecutar(Function1<Connection, T> bloque) {
		try {
			conn = this.getConnection();
			bloque.apply(conn)
		} finally {
			if (conn != null)
				conn.close()
		}
	}
	
	
	// CONNECTION
	def private Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver")
		val credentials = Credentials.loadFromFile("src/main/resources/db.properties")
		val connection = DriverManager.getConnection("jdbc:mysql://localhost/Epers_TP", credentials.user,
			credentials.password)

		connection
	}

}