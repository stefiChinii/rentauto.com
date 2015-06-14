package register

import exceptions.MailNoEnviadoException

interface EnviadorDeMails {
	def boolean enviarMail(Mail m) throws MailNoEnviadoException
}
