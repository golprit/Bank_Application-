package JavaGetEmail;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class JavaMail 
{
    public boolean sendEmail(String to, String from, String subject, String text)
    {
        boolean flag = false;
        
        // SMTP properties
        Properties p = new Properties();
        p.put("mail.smtp.auth", true);
        p.put("mail.smtp.starttls.enable", true);
        p.put("mail.smtp.port", "587");
        p.put("mail.smtp.host", "smtp.gmail.com"); // Corrected typo here
        
        String user = "makwanayash705";
        String password = "yuuudvfhvdoisgfy";
        
        // Session
        Session s = Session.getInstance(p, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });
        
        try {
            Message m = new MimeMessage(s);
            
            m.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            m.setFrom(new InternetAddress(from));
            m.setSubject(subject);
            m.setText(text);
            
            Transport.send(m);
            
            flag = true;
        } catch (Exception e) {
            e.printStackTrace(); // Improved exception handling
        }
        return flag;
    }
}
