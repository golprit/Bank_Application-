import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class ResetPassword extends HttpServlet {
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String token = request.getParameter("token");

        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking", "root", "")) {

            PreparedStatement ps = con.prepareStatement(
                "SELECT user_id FROM password_reset WHERE token=? AND expiry > NOW()"
            );
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("token", token);
                request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            } else {
                response.sendRedirect("forgotPassword.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("forgotPassword.jsp");
        }
    }
}
