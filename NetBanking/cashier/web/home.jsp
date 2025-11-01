<%-- 
    Document   : home
    Created on : Sep 11, 2025, 11:41:18 AM
    Author     : makwa
--%>
<%@include file="header.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%
    HttpSession se = request.getSession(false); 
    if (se == null || se.getAttribute("email") == null)
    {
        response.sendRedirect("index.html");
        return; 
    }
    String email = (String) se.getAttribute("email");
    se.setAttribute("email", email);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f7fa;
                margin: 0;
                padding: 0;
            }
            .welcome-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 80vh;
                text-align: center;
            }
            .welcome-box {
                background: #ffffff;
                padding: 40px 60px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            .welcome-box h1 {
                color: #2c3e50;
                margin-bottom: 10px;
                font-size: 2rem;
            }
            .welcome-box p {
                color: #555;
                font-size: 1.1rem;
            }
        </style>
    </head>
    <body>
        <div class="welcome-container">
            <div class="welcome-box">
                <h1>Welcome to the Cashier Side</h1>
                <p>We’re glad to have you here. Manage your transactions with ease.</p>
            </div>
        </div>
    </body>
</html>
<%@include file="Footer.jsp"%>
