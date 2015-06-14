package HibernateAuto

import java.util.Date
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import register.Usuario
import rent.Auto
import rent.Categoria
import rent.Reserva
import rent.Turismo
import rent.Ubicacion
import services.AutoManager
import services.ReservaManager
import rent.ReservaException
import rent.Empresa
import rent.ReservaEmpresarial

class RealizarReservaTest {
	
	var Categoria turistico
	var Ubicacion correoCentral 
	var Ubicacion retiro 
	var Empresa empresa1
	var Ubicacion destino
	var Date inicioReserva
	var Date finReserva
	var Date inicio
	var Date fin
	var Auto auto1;
	var Auto auto2;
	var Auto auto3;
	var Auto auto4;
	var Ubicacion ezeiza 
	var AutoManager autoManager
	var ReservaManager reservaManager
	var Reserva reserva1
	var Reserva reserva2
	var Reserva reserva3
	var ReservaEmpresarial reservaE
	var Usuario usuario
	
	//var Empresa fantasmita
	

	@Before
	
	def void setUp(){
		turistico = new Turismo() 
		correoCentral = new Ubicacion("Correo Central")
		retiro= new Ubicacion ("Retiro")
		auto1 = new Auto("Onda","Civic",1989,"555",turistico,120.00,retiro)
		ezeiza = new Ubicacion("Ezeiza")
		auto3= new Auto("Fiat", "Uno", 2012, "456", turistico, 180.00, retiro)
		
		autoManager = new AutoManager()
		auto4= new Auto( "Ford", "Mustang", 2006, "645", turistico, 150.00, ezeiza)
		
		auto2= new Auto( "Ford", "Fiesta", 2006, "645", turistico, 150.00, ezeiza)
		inicio = new Date(2015, 5, 10)
	    fin = new Date(2015, 5, 15)
		usuario = new Usuario("Roman","Riquelme","Roman32","roman@boca",10,"vamosBoca")
		reserva1 = new Reserva(ezeiza, ezeiza , inicio, fin, auto2, usuario)
		reserva2 = new Reserva(retiro, ezeiza , inicio, fin, auto1, usuario)
		reserva3 = new Reserva(ezeiza, ezeiza , inicio, fin, auto3, usuario)
		empresa1 = new Empresa("158515","hola",5,52.00)
		empresa1.usuarios.add(usuario)
		empresa1.categoriasAdmitidas.add(turistico)
		reservaE = new ReservaEmpresarial()
		reservaE.empresa = empresa1
		reservaE.nombreContacto = "Messi"
		reservaE.cargoContacto = "NOSEQVAACA"
		reservaE.auto = auto4
		reservaE.usuario = usuario
		reservaE.origen = ezeiza
		reservaE.destino = ezeiza
		reservaE.inicio = inicio
		reservaE.fin = fin
		autoManager.guardarAuto(auto1);
		autoManager.guardarAuto(auto2);
		autoManager.guardarAuto(auto3);
		autoManager.guardarAuto(auto4);
		
	}
	
	
	
	@Test
	def void testApp() throws Exception {
		val reservaManager = new ReservaManager()
		reservaManager.guardarReserva(reserva1);
		val reservaConsultado = reservaManager.consultarReserva(reserva1.numeroSolicitud)
		
		Assert.assertEquals(reserva1.numeroSolicitud, reservaConsultado.numeroSolicitud)
		
	}
	
		@Test
	def void testhacerunaReserva() throws Exception {
		val reservaManager = new ReservaManager()
		reservaManager.hacerUnaReserva(reserva2);
		Assert.assertEquals(auto1.reservas.length,1)
		
	}
	
	@Test(expected = typeof (ReservaException))
	def void noSePedeRealizarReservaAutoEnOtraUbicacion(){
		
		
	val reservaManager = new ReservaManager()
		reservaManager.hacerUnaReserva(reserva3);
		Assert.assertEquals(auto3.reservas.length,1)
	}
	
	 	@Test
	def void testHacerUnaReservaEmpresarial() throws Exception {
		val reservaManager = new ReservaManager()
		
		
		reservaManager.hacerUnaReserva(reservaE);
		Assert.assertEquals(empresa1.reservas.length,1)
		
	}
	
}