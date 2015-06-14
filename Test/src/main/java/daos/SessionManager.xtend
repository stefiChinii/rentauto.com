package daos

import org.hibernate.SessionFactory
import org.hibernate.Transaction
import org.hibernate.cfg.Configuration
import org.hibernate.classic.Session


import org.eclipse.xtext.xbase.lib.Functions.Function0

class SessionManager {
	
	var private static SessionFactory sessionFactory;
	var private static ThreadLocal<Session> tlSession = new ThreadLocal<Session>();
	
	def static SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			var Configuration cfg = new Configuration();
			cfg.configure();

			sessionFactory = cfg.buildSessionFactory();
		}

		return sessionFactory;
	}
	
	def static <T> T runInSession(Function0<T> cmd){
		var SessionFactory sessionFactory = SessionManager.getSessionFactory();
		var Transaction transaction = null;
		var T result = null;
		var Session session = null;
		
		try {
			session = sessionFactory.openSession();
			transaction = session.beginTransaction();

			tlSession.set(session)
			
			result = cmd.apply();

			session.flush();
			transaction.commit();
		} catch (Exception e) {
			if (transaction != null)
				transaction.rollback();
			throw new RuntimeException(e);
		} finally {
			if (session != null)
				session.close();
			tlSession.set(null);
		}
		
		return result;
	}

	def public static Session getSession() {
		return tlSession.get();
	}

}