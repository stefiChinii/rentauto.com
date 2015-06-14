package unq.tpi.persistencia.performanceEj.servicios

import java.util.List
import unq.tpi.persistencia.performanceEj.daos.DepartmentDAO
import unq.tpi.persistencia.performanceEj.model.Department
import unq.tpi.persistencia.performanceEj.model.Employee

class ListadoPagosPorDepto extends AbstractListado {

	String num

	new(String num) {
		this.num = num
	}

	override def doListado() throws Exception {
		var List<Object[]> empleados= new DepartmentDAO().getNombreTituloYMontoEmpleadosDepto(num)
		var Double totalSalaries= new DepartmentDAO().getTotalSalaries(num)

		newLine()
		addColumn("Total").addColumn(totalSalaries).newLine()
		newLine()
		
		addColumn("Nombre")
		addColumn("Titulo")
		addColumn("Monto")
		newLine()

		empleados.forEach[
			addColumn(it.get(1) as String)
			addColumn(it.get(3) as String)
			addColumn(it.get (2) as Double)
			newLine()
		]
		
	}

	override def getFilename() {
		"./target/PagosPorDepto.csv"
	}
}
