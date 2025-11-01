import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

public class CashierDeposit extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            
            int userRequest = Integer.parseInt(request.getParameter("amount"));
            String accNo = request.getParameter("accountNumber");
            String note = request.getParameter("note");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/netbanking", "root", "")) {

                    // Step 1: Check if account exists
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT AccountNumber FROM useraccount WHERE AccountNumber=?");
                    ps.setString(1, accNo);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        // Step 2: Insert into depositrequest
                        PreparedStatement insert = con.prepareStatement(
                            "INSERT INTO depositrequest (AccountNumber, Amount, Note, Status) VALUES (?,?,?,?)");
                        insert.setString(1, accNo);
                        insert.setInt(2, userRequest);
                        insert.setString(3, note);
                        insert.setString(4, "Pending");

                        int i = insert.executeUpdate();
                        if (i > 0) {
                            out.println("<script>alert('Deposit Request Sent!'); window.location='deposite.jsp';</script>");
                        } else {
                            out.println("<script>alert('Deposit Request Failed!'); window.location='deposite.jsp';</script>");
                        }
                    } else {
                        // Step 3: Account not found
                        out.println("<script>alert('Account number not found! Please check and try again.'); window.location='deposite.jsp';</script>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace(out);
                out.println("<script>alert('Error occurred while processing request!'); window.location='deposite.jsp';</script>");
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
        return "Handles cashier deposit requests";
    }
}
