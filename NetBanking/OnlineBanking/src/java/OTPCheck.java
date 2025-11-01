import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class OTPCheck extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("otp") == null) 
            {
                out.println("<script>alert('Session expired! Please try again.'); window.location='register.jsp';</script>");
                return;
            }

            String enteredOtp = request.getParameter("d1")
                                + request.getParameter("d2")
                                + request.getParameter("d3")
                                + request.getParameter("d4")
                                + request.getParameter("d5")
                                + request.getParameter("d6");

            String sessionOtp = (String) session.getAttribute("otp");
            String email = (String) session.getAttribute("useremail");

            if (enteredOtp.equals(sessionOtp)) 
            {
                out.println("<script>alert('OTP Verified Successfully for " + email + "!'); window.location='login.jsp';</script>");
                session.setAttribute("useremail", email);
                session.removeAttribute("otp"); 
            } 
            else 
            {
                out.println("<script>alert('Invalid OTP! Please try again.'); window.location='EmailCheck.jsp';</script>");
            }
        }
    }
}
