package prime.utility;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
 
public class MailUtil {
	public static void send(String sendAddress, String sendHeader, String sendMessage) {
		//##::Use Local Fake SMTP [Remember to use asynchronous loading when sending email to avoid sequential process]
		 //##1.Sender's email ID needs to be mentioned
		 String from = "primeprogram.bot@gmail.com";
		 String pass = "primeprogram123";
		 
		//##1.Recipient's email ID needs to be mentioned.
		 String host = "localhost";
		 
		//##1.Get system properties
		 Properties properties = System.getProperties();
		 
		//##1.Setup mail server
		 properties.put("mail.smtp.starttls.enable", "true");
		 properties.put("mail.smtp.host", host);
		 properties.put("mail.smtp.user", from);
		 properties.put("mail.smtp.password", pass);
		 properties.put("mail.smtp.port", "2525");
		 properties.put("mail.smtp.auth", "true");
		 
		//##1.Get the default Session object.
		 Session sess = Session.getDefaultInstance(properties);
		 
		 try{
			 //---.Create a default MimeMessage object.
			  MimeMessage message = new MimeMessage(sess);
			 
			  //---.Set From: header field of the header.
			  message.setFrom(new InternetAddress(from));
			 
			  //---.Set To: header field of the header.
			  message.addRecipient(Message.RecipientType.TO,
			                           new InternetAddress(sendAddress));
			 
			  //---.Set Subject: header field
			  message.setSubject(sendHeader);
			 
			  //---.Now set the actual message
			  message.setContent(sendMessage, "text/html");
			 
			  //---.Send message
			  Transport transport = sess.getTransport("smtp");
			  transport.connect(host, from, pass);
			  transport.sendMessage(message, message.getAllRecipients());
			  transport.close();
			  System.out.println("Sent message successfully....");
		 } catch (MessagingException mex) {
			 mex.printStackTrace();
			 
		 }
	}
}



