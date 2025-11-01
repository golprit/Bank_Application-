import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class login extends HttpServlet {   // <-- use capital L for class name

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {

        String emailParam = request.getParameter("email");
        String passwordParam = request.getParameter("password");

        if (emailParam == null || passwordParam == null) {
            showAlert(response, "Missing email or password.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/netbanking", "root", "");
                 PreparedStatement pst = con.prepareStatement(
                        "SELECT 1 FROM cashier WHERE email=? AND password=?")) 
            {
                pst.setString(1, emailParam);
                pst.setString(2, passwordParam);

                try (ResultSet rs = pst.executeQuery()) 
                {
                    if (rs.next()) {
                        HttpSession session = request.getSession(true);
                        session.setAttribute("email", emailParam);
                        response.sendRedirect("home.jsp");
                    } else {
                        // Show alert and go back to login page
                        showAlert(response, "Invalid username or password. Please try again.");
                    }
                }
            }
        } catch (Exception e) {
            showAlert(response, "A database error occurred: " + e.getMessage());
        }
    }

    /** Utility method to show a JavaScript alert and redirect */
    private void showAlert(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Login Error</title></head>");
            out.println("<body>");
            out.println("<script type='text/javascript'>");
            out.println("alert('" + escapeForJS(message) + "');");
            out.println("window.location='index.html';");
            out.println("</script>");
            out.println("</body></html>");
        }
    }

    // Basic escaping to avoid breaking the JS string
    private String escapeForJS(String s) {
        return s.replace("'", "\\'").replace("\"", "\\\"");
    }

    @Override
    public String getServletInfo() {
        return "Handles login authentication and shows error alerts.";
    }
}
