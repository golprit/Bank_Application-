<%-- 
    Document   : totalcashier
    Created on : Sep 3, 2025, 6:58:19 PM
    Author     : makwa
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Total Cashier</title>
    </head>
    <body>
       
    <div class="spacer"></div>
    <!-- Request Table -->
    <div class="container">
        <table>
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Password</th>
                    <th>Email</th>
                    <th>Remove</th>
                </tr>
            </thead>
            <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking","root","");
                            Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                            ResultSet rs = st.executeQuery("SELECT * FROM cashier");
                            if (!rs.isBeforeFirst()) { // check if resultset has no rows
                    %>
                                <tr>
                                    <td colspan="12" style="text-align:center; font-weight:bold; color:#ff0000; padding:20px;">
                                        🚫 Not Available 🚫
                                    </td>
                                </tr>
                    <%
                            } else {
                                while (rs.next()) {
                    %>
                                    <tr>
                                        <td><%= rs.getInt("id") %></td>
                                        <td><%= rs.getString("name") %></td>
                                        <td><%= rs.getString("password") %></td>
                                        <td><%= rs.getString("email") %></td>
                                        <td><a href="RemoveCashier?id=<%= rs.getInt("id") %>">Remove</a></td>
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
<%@include file="Footer.jsp"%>
