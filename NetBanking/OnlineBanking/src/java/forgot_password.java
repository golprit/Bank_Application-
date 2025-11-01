import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.*;
import JavaGetEmail.JavaMail;

public class forgot_password extends HttpServlet {

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String email = request.getParameter("email");

            if (email == null || email.trim().isEmpty()) {
                out.println("<script>alert('Please enter your email address!');window.location='forgotPassword.jsp';</script>");
                return;
            }

            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking", "root", "")) {

                PreparedStatement ps = con.prepareStatement("SELECT id FROM useraccount WHERE email=?");
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    int userId = rs.getInt("id");

                    // Generate unique token
                    String token = UUID.randomUUID().toString();

                    // Expiry after 15 minutes
                    Timestamp expiry = new Timestamp(System.currentTimeMillis() + 15 * 60 * 1000);

                    // Insert reset record
                    PreparedStatement p = con.prepareStatement(
                        "INSERT INTO password_reset (user_id, token, expiry) VALUES (?, ?, ?)"
                    );
                    p.setInt(1, userId);
                    p.setString(2, token);
                    p.setTimestamp(3, expiry);
                    p.executeUpdate();

                    // Send email to user
                    try {
                        JavaMail jm = new JavaMail();
                        String subject = "Password Reset Request - SmartBank";
                        String resetLink = "http://localhost:8080/SmartBank/ResetPassword?token=" + token;

                        String message = "Dear user,\n\n"
                                + "We received a request to reset your password.\n"
                                + "Please click the link below to reset it:\n"
                                + resetLink + "\n\n"
                                + "This link will expire in 15 minutes.\n\n"
                                + "If you did not request a password reset, please ignore this email.\n\n"
                                + "Regards,\nSmartBank Support Team";

                        jm.sendEmail(email, "yash.d.makwana@gmail.com", subject, message);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    out.println("<script>alert('Password reset link has been sent to your email.');window.location='login.jsp';</script>");
                } else {
                    out.println("<script>alert('Email not found!');window.location='forgotPassword.jsp';</script>");
                }

            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<script>alert('Database error occurred.');window.location='forgot_Password.jsp';</script>");
            }
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
        return "Forgot password servlet for SmartBank";
    }
}
