package HibernateAuto

import org.junit.Assert
import org.junit.Before
import org.junit.Test
import rent.Auto
import rent.Categoria
import rent.Turismo
import rent.Ubicacion
import services.AutoManager

class InsetarAutoTest {
	
	var Categoria categoria
	var Ubicacion ubicacion 
	var Auto auto;
	
	@Before
	def void setup(){
		categoria = new Turismo() 
		ubicacion = new Ubicacion("Retiro")
		auto = new Auto("Onda","Civic",1989,"555",categoria,120.00,ubicacion)
	}
	
	@Test
	def void testApp() throws Exception {
		val autoManager = new AutoManager()
		autoManager.guardarAuto(auto);
		val autoConsultado = autoManager.consultarAuto(auto.id)
		
		Assert.assertEquals(auto.marca, autoConsultado.marca)
	}

}