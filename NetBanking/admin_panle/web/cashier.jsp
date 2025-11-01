<%-- 
    Document   : cashier
    Created on : Sep 3, 2025, 5:52:43 PM
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
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cashier Page</title>
    <!-- Bootstrap CSS (won’t override your custom css) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Local styles for this form only */
        .cashier-form-container {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            padding: 25px;
        }
        .cashier-form-container h2 {
            color: #0d47a1;
            margin-bottom: 20px;
            text-align: center;
        }
        .btn-cashier {
            background-color: #1976d2;
            color: #fff;
        }
        .btn-cashier:hover {
            background-color: #0d47a1;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="cashier-form-container">
            <h2>Add Cashier</h2>
            <form action="cashier" method="post">
                <div class="mb-3">
                    <label for="name" class="form-label">Cashier Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter cashier name" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-cashier">Add Cashier</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
<%@include file="Footer.jsp"%>
