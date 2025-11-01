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
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Request Page</title>
    <body>
    <div class="spacer"></div>
    <!-- Request Table -->
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
                    <th>Accept</th>
                    <th>Reject</th>
                </tr>
            </thead>
            <tbody>
                    <%
                        boolean hasPending = false;  // to track if there are any pending requests
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking", "root", "");
                            Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                            ResultSet rs = st.executeQuery("SELECT * FROM register_user");

                            while (rs.next()) {
                                boolean status = rs.getBoolean("status");

                                if (!status) { // only show pending requests
                                    hasPending = true;
                    %>
                                    <tr>
                                        <td><%= rs.getInt("id") %></td>
                                        <td><%= rs.getString("surname") %></td>
                                        <td><%= rs.getString("firstname") %></td>
                                        <td><%= rs.getString("lastname") %></td>
                                        <td><%= rs.getString("dob") %></td>
                                        <td><%= rs.getString("address") %></td>
                                        <td><%= rs.getString("account_type") %></td>
                                        <td><%= rs.getString("idProof") %></td>
                                        <td><%= rs.getString("email") %></td>
                                        <td><%= rs.getString("phone") %></td>
                                        <td><a href="accept?id=<%= rs.getInt("id") %>">Accept</a></td>
                                        <td><a href="reject?id=<%= rs.getInt("id") %>">Reject</a></td>
                                    </tr>
                    <%
                                }
                            }

                            if (!hasPending) {
                    %>
                                <tr>
                                    <td colspan="12" style="text-align:center; font-weight:bold; color:#ff0000; padding:20px;">
                                        🚫 No Pending Requests 🚫
                                    </td>
                                </tr>
                    <%
                            }

                            con.close();
                        } catch (Exception e) {
                    %>
                            <tr>
                                <td colspan="12" style="color:red; text-align:center;">
                                    Error: <%= e.getMessage() %>
                                </td>
                            </tr>
                    <%
                        }
                    %>
                </tbody>
        </table>
    </div>
    <div class="spacer"></div>
</body>
</html>

<%@include file="Footer.jsp"%>