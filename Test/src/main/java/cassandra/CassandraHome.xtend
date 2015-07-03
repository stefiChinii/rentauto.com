package cassandra

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.ResultSet
import com.datastax.driver.core.Session
import com.datastax.driver.core.exceptions.NoHostAvailableException

class CassandraHome {
	
	 	
        static var cluster = Cluster.builder()
			.addContactPoint("192.168.1.34").withPort(9042).build();
      	
      	def static getCluster(){
      		cluster
      	}
      	
      		
        def static <T> T ejecutar(String query){
        	
        	var Session session;
        try {
        	var T resultado= null
            session = cluster.connect(); 
          	var ResultSet res= session.execute(query);
	        resultado= res as T
	        } catch (NoHostAvailableException ex) {
	        	throw ex		
		  }finally{
		  	cluster.close
		  }
		  
	  }
	  
}