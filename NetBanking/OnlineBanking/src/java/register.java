import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.sql.*;
import java.security.MessageDigest;

public class register extends HttpServlet 
{
    // Hashing method (can also move to separate class)
    private String hashPassword(String password) 
    {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b)); // Convert byte to hex
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                String password = request.getParameter("password");

                // ✅ Validate password strength
                String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,16}$";
                if (!password.matches(passwordPattern)) {
                    out.println("<script>alert('Password is not strong!'); location='register.jsp';</script>");
                    return;
                }

                // ✅ Hash password before storing
                String hashedPassword = hashPassword(password);

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking", "root", "");

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO register_user (surname, firstname, lastname, dob, address, account_type, idProof, email, phone, password, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                );
                ps.setString(1, request.getParameter("surname"));
                ps.setString(2, request.getParameter("firstname"));
                ps.setString(3, request.getParameter("lastname"));
                ps.setString(4, request.getParameter("dob"));
                ps.setString(5, request.getParameter("address"));
                ps.setString(6, request.getParameter("accountType"));
                ps.setString(7, request.getParameter("idProof"));
                ps.setString(8, request.getParameter("email").toLowerCase());
                ps.setString(9, request.getParameter("phone"));
                ps.setString(10, hashedPassword);
                ps.setBoolean(11, false);
      
                int i = ps.executeUpdate();
                if (i > 0) 
                {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("useremail", request.getParameter("email"));
                    request.getRequestDispatcher("EmailCheck").forward(request, response);
                }
                con.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
                response.getWriter().println("<script>alert('Error: " + e.getMessage() + "'); location='register.jsp';</script>");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
