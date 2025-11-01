<%-- 
    Document   : TotalCustomer
    Created on : Sep 2, 2025, 10:19:51 PM
    Author     : makwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="java.sql.*"%>
<%@include file="header.jsp"%>
<%
    HttpSession se = request.getSession(false);

    if (se == null || se.getAttribute("user") == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Total User</title>
    </head>
    <body>
        
        
    <div class="container">
        <table>
            <thead>
                <tr>
                    <th>Id</th>
                    <th>SurName</th>
                    <th>FirstName</th>
                    <th>LastName</th>
                    <th>Dob</th>
                    <th>Address</th>
                    <th>Account Type</th>
                    <th>Id Proof</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
            </thead>
            <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking","root","");
                            Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                            ResultSet rs = st.executeQuery("SELECT * FROM useraccount");

                            if (!rs.isBeforeFirst()) { // check if resultset has no rows
                    %>
                                <tr>
                                    <td colspan="12" style="text-align:center; font-weight:bold; color:#ff0000; padding:20px;">
                                        🚫 No User 🚫
                                    </td>
                                </tr>
                    <%
                            } else {
                                while (rs.next()) {
                    %>
                                    <tr>
                                        <td><%= rs.getInt("id") %></td>
                                        <td><%= rs.getString("surname") %></td>
                                        <td><%= rs.getString("firstname") %></td>
                                        <td><%= rs.getString("lastname") %></td>
                                        <td><%= rs.getString("dob") %></td>
                                        <td><%= rs.getString("address") %></td>
                                        <td><%= rs.getString("account_type") %></td>
                                        <td><%= rs.getString("adharcard") %></td>
                                        <td><%= rs.getString("email") %></td>
                                        <td><%= rs.getString("phone")%></td>
               
                                    </tr>
                    <%
                                }
                            }
                            con.close();
                        } catch(Exception e) {
                            out.println("<tr><td colspan='12' style='color:red; text-align:center;'>Error: " + e.getMessage() + "</td></tr>");
                        }
                    %>
            </tbody>
        </table>
    </div>
    <div class="spacer"></div>

        
    </body>
</html>
<%@include file="Footer.jsp" %>