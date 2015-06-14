package unq.tpi.persistencia.performanceEj.daos

import java.util.List
import unq.tpi.persistencia.performanceEj.model.Department
import unq.tpi.persistencia.performanceEj.model.Employee
import unq.tpi.persistencia.util.SessionManager

class DepartmentDAO {

	def getByName(String name) {
		val session = SessionManager.getSession()
		session.createQuery("from Department where name = :name")
				.setParameter("name", name).uniqueResult() as Department
	}

	def getByCode(String num) {
		val session = SessionManager.getSession()
		session.get(Department, num) as Department
	}

	def getAll() {
		val session = SessionManager.getSession()
		session.createCriteria(Department).list() as List<Department>
	}
	
	def getTotalSalaries(String num){
		(SessionManager.getSession().createQuery("select depto, sum (salary.amount)
												from Department depto join fetch depto.employees employee
												join fetch employee.salaries salary
												where depto.number= :num
												group by depto").setString("num", num).uniqueResult() as Object[]).get(1) as Double
	}
	
	
	def getNombreTituloYMontoEmpleadosDepto(String num){
		SessionManager.getSession().createQuery("select depto, employee.firstName||' '||employee.lastName, salary.amount, t  
							from Department depto join fetch
							depto.employees employee join fetch employee.salaries as salary
							join fetch employee.titles as t
							where depto.number = :num and salary.to= '9999-01-01'").setString("num",num).list as List<Object[]>
		
	}
	
}
