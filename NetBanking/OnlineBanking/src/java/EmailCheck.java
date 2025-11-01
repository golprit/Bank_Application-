import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import JavaGetEmail.JavaMail;

public class EmailCheck extends HttpServlet {

    private String generateOTP() {
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000); // 6 digit OTP
        return String.valueOf(otp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession(false); // use existing session
            if (session == null || session.getAttribute("useremail") == null) 
            {
                out.println("<script>alert('Session expired. Please register again.'); window.location='register.jsp';</script>");
                return;
            }

            String email = (String) session.getAttribute("useremail");

            String otp = generateOTP();
            session.setAttribute("otp", otp);

            if (session.getAttribute("resendCount") == null)
            {
                session.setAttribute("resendCount", 0);
            }

            String subject = "Your OTP Code";
            String message = "Your OTP for verification is: " + otp;
            String from = "yash.d.makwana@gmail.com";

            try {
                JavaMail gm = new JavaMail();
                boolean sent = gm.sendEmail(email, from, subject, message);

                if (sent) 
                {
                    System.out.println("OTP Sent to " + email + " : " + otp);
                    response.sendRedirect("EmailCheck.jsp"); // Show OTP input page
                } 
                else
                {
                    out.println("<script>alert('Email sending failed!'); window.location='register.jsp';</script>");
                }
            } 
            catch (Exception e)
            {
                e.printStackTrace();
                out.println("<script>alert('Error sending OTP!'); window.location='register.jsp';</script>");
            }
        }
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    }
}
