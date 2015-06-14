package register

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mail {
	String to
	String from
	String body
	
	new(String para, String de, String cuerpo){
		to = para
		from = de
		body = cuerpo
	}
}