<%-- 
    Document   : balance
    Created on : Oct 18, 2025, 5:35:56 PM
    Author     : makwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="java.sql.*"%>
<%
    HttpSession se = request.getSession(false);
    if (se == null || se.getAttribute("email") == null)
    {
        response.sendRedirect("index.html");
        return;
    }
    String userEmail = (String) se.getAttribute("email");
    int balance=0;
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking","root","");
        PreparedStatement ps=con.prepareStatement("select Amount from userbalance where email=?");
        ps.setString(1,userEmail);
        ResultSet rs=ps.executeQuery();
        if(rs.next())
        {
            balance=rs.getInt("Amount");
        }
        con.close();
    }catch(Exception e)
    {
        out.println(e);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Balance</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
    </head>
    <body class="text-center mt-5">
        <div class="card shadow-sm mx-auto" style="width: 22rem;">
            <div class="card-body">
                <i class="fas fa-wallet fa-3x text-primary mb-3"></i>
                <h4 class="card-title">Your Account Balance</h4>
                <h2 class="text-success">₹ <%= balance %></h2>
                <a href="home.jsp" class="btn btn-outline-primary mt-3">Back to Dashboard</a>
            </div>
        </div>
    </body>
</html>
