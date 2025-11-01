/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.*;
import javax.servlet.RequestDispatcher;
/**
 *
 * @author makwa
 */
public class account2 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet account2</title>");
            out.println("</head>");
            out.println("<body>");
            
            try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking", "root", "");
                    PreparedStatement ps = con.prepareStatement("insert into dummy(FirstName,lastname,dob,address,email,account_type,adharcard) values(?,?,?,?,?,?,?)");

                    ps.setString(1, request.getParameter("fnm"));
                    ps.setString(2, request.getParameter("lnm"));
                    ps.setString(3, request.getParameter("date"));
                    ps.setString(4, request.getParameter("address"));
                    ps.setString(5, request.getParameter("email"));
                    ps.setString(6, "Saving");
                    ps.setString(7, request.getParameter("adhar"));

                    //Data Retrive for validation
                    ArrayList<String> emaildata=new ArrayList<>();
                    ArrayList<String> adhardata=new ArrayList<>();
                    
                    Statement st=con.createStatement();
                    ResultSet rss=st.executeQuery("select * from dummy");
                    while(rss.next())
                    {
                        emaildata.add(rss.getString("email"));
                        adhardata.add(rss.getString("adharcard"));
                    }

                    //Validation
                    
                        if(emaildata.contains(request.getParameter("email")))
                        {
                            RequestDispatcher rs=request.getRequestDispatcher("account.jsp");
                            out.println("<h1 align='center' style='color:Red'>Email Areadly Used!</h1>");
                            rs.include(request, response);
                        }
                        else if(adhardata.contains(request.getParameter("adhar")))
                        {
                            RequestDispatcher rs=request.getRequestDispatcher("account.jsp");
                            out.println("<h1 align='center' style='color:Red'>AdharCard Areadly Exits!</h1>");
                            rs.include(request, response);
                        }
                        else
                        {
                            int i = ps.executeUpdate();
                            if(i>0)
                            {
                                RequestDispatcher rs=request.getRequestDispatcher("account.jsp");
                                out.println("<h1 align='center' style='color:green'>Request Send</h1>");
                                rs.include(request, response);
                            }
                        }
                } 
                catch (Exception e)
                {
                    e.printStackTrace();
                }

            
            out.println("</body>");
            out.println("</html>");
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
