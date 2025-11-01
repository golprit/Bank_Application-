import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import JavaGetEmail.JavaMail;

public class reject extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("id");   // id of the deposit request
        String email = request.getParameter("email");
        String acc = request.getParameter("AccountNumber");
        String amount = request.getParameter("amount");

        try (PrintWriter out = response.getWriter()) {

            if (id == null || id.isEmpty()) {
                out.println("Missing id parameter");
                return;
            }

            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/netbanking", "root", "");
                 PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM depositrequest WHERE id=?")) {

                ps.setString(1, id);
                int rows = ps.executeUpdate();

                if (rows > 0) 
                {
                    // Step 1: Send rejection email
                    try {
                        JavaMail gm = new JavaMail();
                        gm.sendEmail(
                            email,
                            "yash.d.makwana@gmail.com",   // sender email
                            "Deposit Request Rejected - Yes Bank",
                            "Dear Customer,\n\nYour deposit request of ₹" + amount +
                                    " for account " + acc +
                                    " has been rejected by the bank.\n\n" +
                                    "If you believe this is an error, please contact customer support.\n\nThank you."
                        );
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    // Step 2: Redirect back
                    response.sendRedirect("DepositRequest.jsp");
                } else {
                    out.println("No matching request found for id " + id);
                }
            }

        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }

    // Optional: handle GET the same as POST
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
