import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import AccountNumber.AccountNumberGen;
import JavaGetEmail.JavaMail;

public class accept extends HttpServlet {

    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void UpdateRecord(Connection con, String id) throws SQLException {
        String sql = "update register_user set status = ? WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, true);
            ps.setString(2, id);
            ps.executeUpdate();
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            String userId = request.getParameter("id");
            if (userId == null || userId.trim().isEmpty()) {
                out.println("<script>alert('Invalid User ID'); window.location='account_list.jsp';</script>");
                return;
            }

            AccountNumberGen am = new AccountNumberGen();
            String acc = am.demo();  // generate account number
            String ifscCode = "YESB0000726";

            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/netbanking", "root", "")) {

                con.setAutoCommit(false); // Begin transaction

                String fetchSql = "SELECT * FROM register_user WHERE id=?";
                try (PreparedStatement pss = con.prepareStatement(fetchSql)) {
                    pss.setString(1, userId);

                    try (ResultSet rs = pss.executeQuery()) {
                        if (!rs.next()) {
                            out.println("<script>alert('User not found!'); window.location='account_list.jsp';</script>");
                            return;
                        }

                        // Collect data
                        String sname = rs.getString("surname");
                        String fname = rs.getString("firstName");
                        String lname = rs.getString("lastname");
                        String dob = rs.getString("dob");
                        String address = rs.getString("address");
                        String email = rs.getString("email");
                        String password = rs.getString("password");
                        String phone = rs.getString("phone");
                        String account_type = rs.getString("account_type");
                        String adharcard = rs.getString("idProof");

                       
                        // Insert into useraccount
                        String insertSql = "INSERT INTO useraccount "
                                + "(surname,FirstName,LastName,Dob,address,email,password,phone,account_type,adharcard,AccountNumber,ifsc,status) "
                                + "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";

                        int InData;
                        try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                            ps.setString(1, sname);
                            ps.setString(2, fname);
                            ps.setString(3, lname);
                            ps.setString(4, dob);
                            ps.setString(5, address);
                            ps.setString(6, email);
                            ps.setString(7, password);
                            ps.setString(8, phone);
                            ps.setString(9, account_type);
                            ps.setString(10, adharcard);
                            ps.setString(11, acc);
                            ps.setString(12, ifscCode);
                            ps.setBoolean(13, true);

                            InData = ps.executeUpdate();
                        }

                        if (InData <= 0) {
                            con.rollback();
                            out.println("<script>alert('Failed to create account!'); window.location='account_list.jsp';</script>");
                            return;
                        }

                        // Delete original request
                        UpdateRecord(con, userId);

                        // Commit transaction
                        con.commit();
                        con.setAutoCommit(true); // reset auto-commit

                        // Send email after successful commit
                        String subject = "Congratulations! Your bank account has been successfully created.";
                        String message = "Dear Customer,\n\nYour account has been approved successfully.\n\n"
                                + "Account Number: " + acc + "\n"
                                + "IFSC Code: " + ifscCode + "\n\n"
                                + "You can now log in and access your account.\n\n"
                                + "Best regards,\nYes Bank Support";
                        String from = "yash.d.makwana@gmail.com";

                        try {
                            JavaMail gm = new JavaMail();
                            boolean sent = gm.sendEmail(email, from, subject, message);

                            if (sent) {
                                out.println("<script>alert('Account created & Email Sent Successfully'); window.location='account_list.jsp';</script>");
                            } else {
                                out.println("<script>alert('Account created, but Email Not Sent'); window.location='account_list.jsp';</script>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<script>alert('Account created, but Error while sending email'); window.location='account_list.jsp';</script>");
                        }
                    }
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='account_list.jsp';</script>");
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
        return "Accept Servlet - creates user account, deletes request, and sends confirmation email";
    }
}
