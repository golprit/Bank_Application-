import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/ReceiverDetailsServlet")
public class ReceiverDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String accNo = request.getParameter("accountNumber");

        if (accNo == null || accNo.trim().isEmpty()) {
            out.print("<span style='color:red;'>Please enter account number</span>");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/netbanking", "root", ""); // 🔹 Update DB name & credentials

            PreparedStatement ps = con.prepareStatement(
                "SELECT FirstName,surname,account_type FROM useraccount WHERE AccountNumber=?");
            ps.setString(1, accNo);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                out.println("<span style='color:green;'><b>Receiver Name:</b> " + rs.getString("FirstName") + " " +rs.getString("surname") + "<br>");
                out.println("<b>Account Type:</b> " + rs.getString("account_type") + "</span>");
            } else {
                out.println("<span style='color:red;'>Account not found!</span>");
            }

            con.close();
        } catch (Exception e) {
            out.println("<span style='color:red;'>Error: " + e.getMessage() + "</span>");
        }
    }
}
