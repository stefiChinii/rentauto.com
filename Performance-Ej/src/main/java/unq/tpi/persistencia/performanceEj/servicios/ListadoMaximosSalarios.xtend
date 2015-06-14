package unq.tpi.persistencia.performanceEj.servicios

import java.util.List
import unq.tpi.persistencia.performanceEj.daos.EmployeeDAO
import unq.tpi.persistencia.performanceEj.model.Employee

class ListadoMaximosSalarios extends AbstractListado{

	override def getFilename() {
		"./target/MaximosSalarios.csv"
	}

	override def doListado() throws Exception {
		val dao= new EmployeeDAO()
		var List<Employee> empleados= dao.mayoresSalarios()
		
		addColumn("Nombre").addColumn("Sueldo").newLine()
		
	(empleados).forEach[
			addColumn(fullName).addColumn(salary).newLine()
		]
	}
}
