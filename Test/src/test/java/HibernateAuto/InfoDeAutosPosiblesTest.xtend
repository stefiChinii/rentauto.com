package HibernateAuto

import java.util.Date
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import rent.Auto
import rent.Categoria
import rent.Turismo
import rent.Ubicacion
import services.AutoManager

import rent.Reserva
import register.Usuario
import services.ReservaManager
import services.UsuarioManager

class InfoDeAutosPosiblesTest {
	
	var Categoria categoria
	var Ubicacion ezeiza 
	var Ubicacion correoCentral 
	var Auto auto1;
	var Auto auto2;
	var Auto auto3;
	var Date inicio
	var Date fin
	var AutoManager autoManager
	var ReservaManager RManager
	var Reserva res
	var Usuario usuario
	var UsuarioManager usuarioManager
	@Before
	def void setup(){
		usuario = new Usuario("Roman","Riquelme","Roman32","roman@boca",10,"vamosBoca")
		categoria = new Turismo() 
		ezeiza = new Ubicacion("Ezeiza")
		correoCentral= new Ubicacion ("Correo Central")
		auto1 = new Auto("Onda","Civic",1989,"555",categoria,120.00,ezeiza)
		auto2= new Auto( "Ford", "Fiesta", 2006, "645", categoria, 150.00, ezeiza)
		auto3= new Auto("Fiat", "Uno", 2012, "456", categoria, 180.00, correoCentral)
	    inicio = new Date(2015, 5, 10)
	    fin = new Date(2015, 5, 15)
		res = new Reserva(ezeiza, ezeiza , inicio, fin, auto2, usuario)
		autoManager = new AutoManager()
		RManager= new ReservaManager
		
		usuarioManager= new UsuarioManager
		usuarioManager.crearUsuario(usuario)
		autoManager.guardarAuto(auto1);
		autoManager.guardarAuto(auto2);
		autoManager.guardarAuto(auto3);
	    RManager.guardarReserva(res)
	    
	}
	
	@Test
	def void testApp(){
		 Assert.assertTrue( 
		 	autoManager.autosDisponiblesEn(ezeiza,new Date(2015, 5, 18), new Date(2015, 5, 20)).length == 2
		 )
		
	}
	
}