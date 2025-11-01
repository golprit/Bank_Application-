import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.sql.*;
import java.time.LocalDateTime;

public class TransferMoney extends HttpServlet {

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

            String fromAccount = request.getParameter("fromAccount");
            String toAccount = request.getParameter("toAccount");
            String IfscCode = request.getParameter("ifsc");
            final String ifscid = "YESB0000726";

            //Get Date & Time
            LocalDateTime now = LocalDateTime.now();
            Timestamp sqlTimestamp = Timestamp.valueOf(now);
            String txnId = "TXN" + System.currentTimeMillis() + (int) (Math.random() * 1000);

            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("email") == null) {
                out.println("<script>alert('Session expired. Please login again.'); window.location='login.jsp';</script>");
                return;
            }
            String email = (String) session.getAttribute("email");

            int amount = Integer.parseInt(request.getParameter("amount"));
            if (amount <= 0) {
                out.println("<script>alert('Invalid transfer amount!'); window.location='transfer.jsp';</script>");
                return;
            }

            String FromAcc = null;
            String ToAcc = null;
            int balance = 0;

            try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking", "root", "")) {

                // Fetch From Account
                try (PreparedStatement ps = con.prepareStatement("SELECT AccountNumber FROM useraccount WHERE AccountNumber=?")) {
                    ps.setString(1, fromAccount);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) FromAcc = rs.getString("AccountNumber");
                }

                // Fetch To Account
                try (PreparedStatement ps = con.prepareStatement("SELECT AccountNumber FROM useraccount WHERE AccountNumber=?")) {
                    ps.setString(1, toAccount);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) ToAcc = rs.getString("AccountNumber");
                }

                // Fetch Balance
                try (PreparedStatement ps = con.prepareStatement("SELECT Amount FROM userbalance WHERE AccountNumber=?")) {
                    ps.setString(1, fromAccount);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) balance = rs.getInt("Amount");
                }

                // Validate
                if (FromAcc != null && ToAcc != null && ifscid.equals(IfscCode)) {
                    if (amount <= balance) {
                        try (PreparedStatement ps = con.prepareStatement(
                                "INSERT INTO moneytransfer_request (SenderAccountNumber, ReciveAccountNumber, Amount, email, Transfer_at, TransactionID, status) VALUES (?,?,?,?,?,?,?)")) {
                            ps.setString(1, fromAccount);
                            ps.setString(2, toAccount);
                            ps.setInt(3, amount);
                            ps.setString(4, email);
                            ps.setTimestamp(5, sqlTimestamp);
                            ps.setString(6, txnId);
                            ps.setString(7, "Pending");

                            int i = ps.executeUpdate();
                            if (i > 0) {
                                out.println("<script>alert('Request sent successfully.'); window.location='transfer.jsp';</script>");
                            }
                        }
                    } else {
                        out.println("<script>alert('Not enough balance!'); window.location='transfer.jsp';</script>");
                    }
                } else {
                    out.println("<script>alert('Invalid Account Number or IFSC Code!'); window.location='transfer.jsp';</script>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Server error occurred! Please try again later.'); window.location='transfer.jsp';</script>");
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
        return "Handles fund transfer requests.";
    }
}
