package cassandra

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.core.exceptions.NoHostAvailableException
import org.eclipse.xtext.xbase.lib.Functions.Function0

class CassandraHome {
	
	 	
        var static cluster = Cluster.builder()
			.addContactPoint("192.168.1.34").withPort(9042).build();
		var static Session session
      	
      	def static getSession(){
      		session = cluster.connect(); 
      	}
      	
      		
        def static <T> T ejecutar(Function0 <T> cmd){
        	
        try {
            getSession()
          	var T resultado= null
          	resultado= cmd.apply()
	        } catch (NoHostAvailableException ex) {
	        	throw ex		
		  }finally{
		  	cluster.close
		  }
		  
	  }
	  
}