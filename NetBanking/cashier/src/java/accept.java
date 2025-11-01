import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import JavaGetEmail.JavaMail;
import java.io.PrintWriter;

public class accept extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String id = request.getParameter("id");   
        String acc = request.getParameter("AccountNumber");
        String email = request.getParameter("email");
        int depositAmount = Integer.parseInt(request.getParameter("amount"));
        
        if (id == null || id.isEmpty()) {
            response.getWriter().println("Missing id parameter");
            return;
        }

        LocalDateTime now = LocalDateTime.now();
        Timestamp sqlTimestamp = Timestamp.valueOf(now);

        int newBalance = depositAmount;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/netbanking", "root", "")) {

                // Step 1: Check if balance already exists
                int currentBalance = 0;
                boolean accountExists = false;

                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT Amount FROM userbalance WHERE AccountNumber=?")) {
                    ps.setString(1, acc);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            accountExists = true;
                            currentBalance = rs.getInt("Amount");
                        }
                    }
                }

                // Step 2: Update or Insert
                if (accountExists) {
                    newBalance = currentBalance + depositAmount;

                    try (PreparedStatement ps = con.prepareStatement(
                            "UPDATE userbalance SET Amount=?, Status=?, DateTime=? WHERE AccountNumber=?")) {
                        ps.setInt(1, newBalance);
                        ps.setString(2, "ACCEPTED");
                        ps.setTimestamp(3, sqlTimestamp);
                        ps.setString(4, acc);
                        ps.executeUpdate();
                    }

                } else {
                    try (PreparedStatement ps = con.prepareStatement(
                            "INSERT INTO userbalance (AccountNumber, Amount, Status,email, DateTime) VALUES (?,?,?,?,?)")) {
                        ps.setString(1, acc);
                        ps.setInt(2, depositAmount);
                        ps.setString(3, "ACCEPTED");
                        ps.setString(4, email);
                        ps.setTimestamp(5, sqlTimestamp);
                        ps.executeUpdate();
                    }
                }

                //Step-3: Insert deposit request in History Table
                try(PreparedStatement ps=con.prepareStatement(""
                        + "insert into userhistory(AccountNumber,Amount,Status,email,DateTime)values(?,?,?,?,?)")){
                    ps.setString(1, acc);
                    ps.setInt(2, depositAmount);
                    ps.setString(3, "ACCEPTED");
                    ps.setString(4, email);
                    ps.setTimestamp(5, sqlTimestamp);
                    ps.executeUpdate();
                }
                
                // Step-4: Delete deposit request after acceptance
                try (PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM depositrequest WHERE id=?")) {
                    ps.setString(1, id);
                    ps.executeUpdate();
                }

                // Step 4: Send Email
                try {
                    JavaMail gm = new JavaMail();
                    gm.sendEmail(
                        email,
                        "yash.d.makwana@gmail.com",
                        "Deposit Successful - Yes Bank",
                        "Dear Customer,\n\nYour deposit of ₹" + depositAmount +
                                " has been successfully credited to account " + acc +
                                ".\n\nYour new balance is ₹" + newBalance + ".\n\nThank you."
                    );
                } catch (Exception e) {
                    e.printStackTrace();
                }

                // Step 5: Redirect back
                response.sendRedirect("DepositRequest.jsp");

            }
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
