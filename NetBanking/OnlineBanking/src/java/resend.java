import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import JavaGetEmail.JavaMail;

public class resend extends HttpServlet {

    private String generateOTP() {
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000); // 6 digit OTP
        return String.valueOf(otp);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession(false); // use existing session
            if (session == null || session.getAttribute("useremail") == null) {
                out.println("<script>alert('Session expired. Please register again.'); window.location='register.jsp';</script>");
                return;
            }

            String email = (String) session.getAttribute("useremail");

            // Generate and save OTP
            String otp = generateOTP();
            session.setAttribute("otp", otp);

            // Handle resend count
            Integer count = (Integer) session.getAttribute("resendCount");
            if (count == null) {
                count = 0;
            }
            count++;
            session.setAttribute("resendCount", count);

            String subject = "Your OTP Code";
            String message = "Your OTP for verification is: " + otp;
            String from = "yash.d.makwana@gmail.com";

            try {
                JavaMail gm = new JavaMail();
                boolean sent = gm.sendEmail(email, from, subject, message);

                if (sent) {
                    System.out.println("OTP Sent to " + email + " : " + otp);
                    response.sendRedirect("EmailCheck.jsp"); // Show OTP input page
                } else {
                    out.println("<script>alert('Email sending failed!'); window.location='register.jsp';</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Error sending OTP!'); window.location='register.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to resend OTP";
    }
}
