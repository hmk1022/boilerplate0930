package com.workerman.service;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class EmailService {
	
	@Value("${email.id}") private String send_email_id;
	@Value("${email.pwd}") private String send_email_pwd;

	public void sendEmail(String subject, String text, String email) throws Exception {
		
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");
		props.setProperty("mail.smtp.quitwait", "false");
		
		Authenticator auth = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(send_email_id, send_email_pwd);
				
			}
		};
		
		Session session = Session.getInstance(props, auth);
		
		MimeMessage message = new MimeMessage(session);
		message.setSender(new InternetAddress(send_email_id));
		message.setSubject(subject);
		
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
		
		Multipart mp = new MimeMultipart();
		MimeBodyPart mbp1 = new MimeBodyPart();
		mbp1.setText(text, "UTF-8" , "html");
		
		mp.addBodyPart(mbp1);
		message.setContent(mp);
		
		Transport.send(message);
		
	}

}
