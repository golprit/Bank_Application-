import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.time.LocalDateTime;
import JavaGetEmail.JavaMail;
import java.util.ArrayList;

public class TransactionRequestAccept extends HttpServlet {
    
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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TransactionRequestAccept</title>");
            out.println("</head>");
            out.println("<body>");
            
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/netbanking", "root", "")) {
                
                con.setAutoCommit(false);
                
                ArrayList<String> UserBalanceAccountNumber=new ArrayList();
                String senderAccountNumber = request.getParameter("SenderAccountNumber");
                String receiverAccountNumber = request.getParameter("ReciveAccountNumber");
                String senderEmail = request.getParameter("email");
                int amount = Integer.parseInt(request.getParameter("amount"));
                String transactionID = request.getParameter("TransactionID");
                String Transfer_at=request.getParameter("Transfer_at");
                Timestamp TransferTime=Timestamp.valueOf(Transfer_at);
                
                LocalDateTime now = LocalDateTime.now();
                Timestamp sqlTimestamp = Timestamp.valueOf(now);
                
                // Check Sender Balance
                int senderBalance = 0;
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT Amount FROM userbalance WHERE AccountNumber=?")) {
                    ps.setString(1, senderAccountNumber);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        senderBalance = rs.getInt("Amount");
                    }
                }

                if (senderBalance < amount) {
                    out.println("<h3 style='color:red;'>Insufficient Balance!</h3>");
                    con.rollback();
                    return;
                }
                //Get All AccountNumber in UserBalance Table
                try(PreparedStatement ps=con.prepareStatement("select * from userbalance")){
                    ResultSet rs=ps.executeQuery();
                    while(rs.next()){
                        UserBalanceAccountNumber.add(rs.getString("AccountNumber"));
                    }
                }catch(Exception e){
                    e.printStackTrace();
                }
                // Deduct from Sender
                try (PreparedStatement ps = con.prepareStatement(
                        "UPDATE userbalance SET Amount = Amount - ? WHERE AccountNumber=?")) {
                    ps.setInt(1, amount);
                    ps.setString(2, senderAccountNumber);
                    ps.executeUpdate();
                }
                
                // Get Receiver Email
                String receiverEmail = null;
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT email FROM useraccount WHERE AccountNumber=?")) {
                    ps.setString(1, receiverAccountNumber);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        receiverEmail = rs.getString("email");
                    }
                }

                // Get Sender New Balance
                int senderNewBalance = 0;
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT Amount FROM userbalance WHERE AccountNumber=?")) {
                    ps.setString(1, senderAccountNumber);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        senderNewBalance = rs.getInt("Amount");
                    }
                }
                // Check if receiver exists in userbalance table
                if (UserBalanceAccountNumber.contains(receiverAccountNumber)) {
                    // Update existing receiver balance
                    try (PreparedStatement ps = con.prepareStatement(
                            "UPDATE userbalance SET Amount = Amount + ? WHERE AccountNumber=?")) {
                        ps.setInt(1, amount);
                        ps.setString(2, receiverAccountNumber);
                        ps.executeUpdate();
                    }
                } else {
                    // Insert new receiver record
                    try (PreparedStatement ps = con.prepareStatement(
                            "INSERT INTO userbalance(AccountNumber, Amount, email, Status, DateTime) VALUES(?, ?, ?, ?, ?)")) {
                        ps.setString(1, receiverAccountNumber);
                        ps.setInt(2, amount);
                        ps.setString(3, receiverEmail);
                        ps.setString(4, "ACCEPTED");
                        ps.setTimestamp(5, sqlTimestamp);
                        ps.executeUpdate(); // <-- missing in your version
                    }
                }
    
                
                // Get Receiver New Balance
                int receiverNewBalance = 0;
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT Amount FROM userbalance WHERE AccountNumber=?")) {
                    ps.setString(1, receiverAccountNumber);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next()) {
                        receiverNewBalance = rs.getInt("Amount");
                    }
                }

                // Insert Transaction Record
                try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO transermoney(SenderAccountNumber,ReciveAccountNumber,Amount,SenderEmail,Transfer_at,TransactionID,approved_at,status) "
                                + "VALUES(?,?,?,?,?,?,?,?)")) {
                    ps.setString(1, senderAccountNumber);
                    ps.setString(2, receiverAccountNumber);
                    ps.setInt(3, amount);
                    ps.setString(4, senderEmail);
                    ps.setTimestamp(5, TransferTime);
                    ps.setString(6, transactionID);
                    ps.setTimestamp(7, sqlTimestamp);
                    ps.setString(8, "approved");

                    int i = ps.executeUpdate();
                    if (i > 0) {
                        
                        // ✅ Email to Sender
                        try {
                            JavaMail mail = new JavaMail();
                            mail.sendEmail(
                                    senderEmail,
                                    "yash.d.makwana@gmail.com",
                                    "Transaction Successful - Yes Bank",
                                    "Dear Customer,\n\n"
                                    + "Your transaction has been successfully processed.\n\n"
                                    + "Transaction Details:\n"
                                    + "-----------------------------------\n"
                                    + "Transaction ID: " + transactionID + "\n"
                                    + "Debited Amount: ₹" + amount + "\n"
                                    + "To Account: " + receiverAccountNumber + "\n"
                                    + "Date & Time: " + sqlTimestamp + "\n"
                                    + "New Balance: ₹" + senderNewBalance + "\n"
                                    + "-----------------------------------\n\n"
                                    + "Thank you for using Yes Bank.\n"
                                    + "If this transaction was not initiated by you, please contact our support immediately.\n\n"
                                    + "Warm regards,\n"
                                    + "Yes Bank Team"
                            );
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        // ✅ Email to Receiver
                        try {
                            JavaMail mail = new JavaMail();
                            mail.sendEmail(
                                    receiverEmail,
                                    "yash.d.makwana@gmail.com",
                                    "Amount Credited - Yes Bank",
                                    "Dear Customer,\n\n"
                                    + "You have received a fund transfer.\n\n"
                                    + "Transaction Details:\n"
                                    + "-----------------------------------\n"
                                    + "Transaction ID: " + transactionID + "\n"
                                    + "Credited Amount: ₹" + amount + "\n"
                                    + "From Account: " + senderAccountNumber + "\n"
                                    + "Date & Time: " + sqlTimestamp + "\n"
                                    + "New Balance: ₹" + receiverNewBalance + "\n"
                                    + "-----------------------------------\n\n"
                                    + "Thank you for banking with Yes Bank.\n\n"
                                    + "Warm regards,\n"
                                    + "Yes Bank Team"
                            );
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        
                        //Update Status
                        try(PreparedStatement p=con.prepareStatement
                        ("update moneytransfer_request set status = ? where TransactionID=?")){
                            p.setString(1, "approved");
                            p.setString(2, transactionID);
                            p.executeUpdate();
                        }catch(Exception e){e.printStackTrace();}
                        
                        con.commit();
                        
                        // Redirect
                        response.sendRedirect("TransactionRequest.jsp");
                    } else {
                        con.rollback();
                        out.println("<script>alert('Transaction failed! Please try again.'); window.location='TransactionRequest.jsp';</script>");
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
            }

            out.println("</body>");
            out.println("</html>");
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
        return "Handles transaction approval and fund transfer.";
    }

}
