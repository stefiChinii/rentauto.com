package HibernateAuto

import org.hibernate.SessionFactory
import junit.framework.TestCase

class AbstractHibernateTest extends TestCase{
	
	var SessionFactory sessionFactory;

	new() {
		super();
	}

	new (String name) {
		super(name);
	}
}