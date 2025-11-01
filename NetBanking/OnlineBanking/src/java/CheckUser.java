import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.sql.*;

public class CheckUser extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");

        // ✅ Validate email input
        if (email == null || email.isEmpty()) {
            response.getWriter().println("<script>alert('Please enter your email!'); window.location='login.jsp';</script>");
            return;
        }
        boolean emailFound = false;
        boolean registerStatus = false;
        boolean hasUserAccount = false;
        boolean accountStatus = false;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/netbanking",
                    "root", "")) {

                //✅ Step 1: Check if email exists in register_user
                try (PreparedStatement ps = con.prepareStatement(
                        "SELECT status FROM register_user WHERE email=?")) {
                    ps.setString(1, email);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            emailFound = true;
                            registerStatus = rs.getBoolean("status");
                        }
                    }
                }

                if (!emailFound) {
                    try (PrintWriter out = response.getWriter()) {
                        out.println("<script>alert('Email not registered!');");
                        out.println("window.location='login.jsp';</script>");
                    }
                    return;
                }

                // ✅ Step 2: Check if user has an account in useraccount table
                try (PreparedStatement us = con.prepareStatement(
                        "SELECT status FROM useraccount WHERE email=?")) {
                    us.setString(1, email);
                    try (ResultSet rs = us.executeQuery()) {
                        if (rs.next()) {
                            hasUserAccount = true;
                            accountStatus = rs.getBoolean("status");
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
            return;
        }

        // ✅ Step 3: Respond based on status
        HttpSession session = request.getSession();
        try (PrintWriter out = response.getWriter()) {

            if (!hasUserAccount) {
                out.println("<script>alert('Your request is still pending. Please wait for approval.');");
                out.println("window.location='index.html';</script>");
            } else if (accountStatus) {
                session.setAttribute("email", email);
                response.sendRedirect("home.jsp");
            } else {
                out.println("<script>alert('Your account is disabled. Please contact admin.');");
                out.println("window.location='index.html';</script>");
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
        return "CheckUser servlet to validate user by email and check account status.";
    }
}
