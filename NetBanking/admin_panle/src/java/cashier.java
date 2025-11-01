import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import JavaGetEmail.JavaMail;

@WebServlet("/cashier")
public class cashier extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name     = request.getParameter("name");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        if (name == null || email == null || password == null ||
            name.isBlank() || email.isBlank() || password.isBlank()) 
        {
            response.sendRedirect("cashier.jsp?error=missing");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/netbanking", "root", "");
                 PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO cashier(name,password,email) VALUES (?,?,?)"))
            {

                ps.setString(1, name);
                ps.setString(2, password);   
                ps.setString(3, email);

                int rows = ps.executeUpdate();

                if (rows > 0) 
                {    
                    String subject = "Congratulations! You are selected as Cashier";
                    String message = "Your temporary password is: " + password;

                    try {
                        JavaMail mailer = new JavaMail();
                        boolean sent = mailer.sendEmail(email,
                                                        "yash.d.makwana@gmail.com",
                                                        subject,
                                                        message);

                        if (!sent)
                        {
                            // optionally log or alert admin
                        }
                    } catch (Exception e) {
                        log("Email sending failed", e);
                    }

                    response.sendRedirect("cashier.jsp?success=1");
                } else {
                    response.sendRedirect("cashier.jsp?error=db");
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
}
