package unq.tpi.persistencia.performanceEj.daos

import java.util.List
import unq.tpi.persistencia.performanceEj.model.Employee
import unq.tpi.persistencia.util.SessionManager

class EmployeeDAO {

	def getByName(String name, String lastName) {
		val session = SessionManager.getSession()
		session.createQuery("from Employee where firstName = :name and lastName = :lastName")
				.setParameter("name", name).setParameter("lastName", lastName)
				.uniqueResult() as Employee
	}

	def getAll() {
		val session = SessionManager.getSession()
		session.createCriteria(Employee).list() as List<Employee>
	}

	def getByCode(int id) {
		val session = SessionManager.getSession()
		session.load(Employee, id) as Employee
	}
	
	def mayoresSalarios(){
		val resultado= SessionManager.getSession().createQuery("
			select employee from Employee employee 
				join fetch employee.salaries salary where salary.to = 9999-01-01 order by salary.amount").setMaxResults(10)
		resultado.list as List<Employee>
	}

}
