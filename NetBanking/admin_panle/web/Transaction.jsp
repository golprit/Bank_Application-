<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@include file="header.jsp"%>
<%
    session=request.getSession(false);
    if(session==null || session.getAttribute("user")==null)
    {
        response.sendRedirect("index.html");
    }
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transaction Page</title>
    </head>
    <body>
    <div class="spacer"></div>
    <!-- Request Table -->
    <div class="container">
        <table>
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Sender Account Number</th>
                    <th>Receiver Account Number</th>
                    <th>Amount</th>
                    <th>Sender Email</th>
                    <th>Transfer At</th>
                    <th>Transaction ID</th>
                    <th>Approved_at</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking","root","");
                            Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                            ResultSet rs = st.executeQuery("SELECT * FROM transermoney");
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
                                        <td><%= rs.getString("SenderAccountNumber") %></td>
                                        <td><%= rs.getString("ReciveAccountNumber") %></td>
                                        <td><%= rs.getInt("Amount") %></td>
                                        <td><%= rs.getString("SenderEmail")%></td>
                                        <td><%= rs.getTimestamp("Transfer_at")%></td>
                                        <td><%= rs.getString("TransactionID")%></td>
                                        <td><%= rs.getTimestamp("approved_at")%></td>
                                        <td><%= rs.getString("status")%></td>
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