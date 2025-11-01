import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;
import JavaGetEmail.JavaMail;

public class TransactionRequestReject extends HttpServlet {
    static{
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch(Exception e)
        {
            e.printStackTrace();
        }
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            try(Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking","root",""))
            {
                //check session
                HttpSession session = request.getSession(false);
                if (session == null || session.getAttribute("email") == null) {
                    response.sendRedirect("index.html");
                    return;
                }
                
                String email=request.getParameter("email");
                String tr=request.getParameter("TransactionID");
                
                //Update Status
                try(PreparedStatement ps=con.prepareStatement
                ("update moneytransfer_request set status = ? where TransactionID = ?")){
                    ps.setString(1, "Reject");
                    ps.setString(2, tr);
                    ps.executeUpdate();
                }catch(Exception e){e.printStackTrace();}
                
                try {
                    JavaMail jm = new JavaMail();

                    String subject = "Transaction Request Rejected";
                    String message = "Dear Customer,\n\n"
                                   + "Your transaction request with ID: " + tr + " has been rejected by the cashier.\n"
                                   + "If you have any questions, please contact support.\n\n"
                                   + "Regards,\n"
                                   + "Your Bank Team";

                    jm.sendEmail(email,              // recipient email
                                 "yash.d.makwana@gmail.com", // sender email
                                 subject,            // email subject
                                 message);           // email body

                } catch(Exception e) {
                    e.printStackTrace();
                }

                
                response.sendRedirect("TransactionRequest.jsp");
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
