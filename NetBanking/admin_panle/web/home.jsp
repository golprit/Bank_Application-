<%-- 
    Document   : home
    Created on : Feb 8, 2025, 8:52:31 PM
    Author     : makwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%
    HttpSession se = request.getSession(false);
    if (se == null || se.getAttribute("user") == null) {
        response.sendRedirect("index.html");
        return;
    }
    String email=(String)se.getAttribute("user");
    se.setAttribute("user", email);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Bank Admin Dashboard">
    <meta name="author" content="Enterprise Development">
    <title>Admin Dashboard | YesBank</title>
    <link rel="shortcut icon" type="image/x-icon" href="image/YesBank.png">

    <!-- CSS Libraries -->
    <link href="assets/vendor/animate.css-master/animate.min.css" rel="stylesheet">
    <link href="assets/vendor/loadscreen/css/spinkit.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700&display=swap" rel="stylesheet">
    <link href="assets/vendor/fontawesome/css/fontawesome-all.min.css" rel="stylesheet">
    <link href="assets/custom/css/fables-icons.css" rel="stylesheet"> 
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap/css/bootstrap-4-navbar.css" rel="stylesheet">
    <link href="assets/custom/css/custom.css" rel="stylesheet">
    <link href="assets/custom/css/custom-responsive.css" rel="stylesheet">

    <!-- Extra Dashboard Styling -->
    <style>
        body {
            font-family: 'Open Sans', sans-serif;
            background-color: #f4f6f9;
            color: #333;
        }

        /* Navbar */
        .navbar {
            background: #003366 !important;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }
        .navbar-brand img {
            height: 55px;
        }
        .navbar-nav .nav-link {
            font-weight: 600;
            color: #fff !important;
            transition: 0.3s;
        }
        .navbar-nav .nav-link:hover {
            color: #ffd633 !important;
        }

        /* Header Section */
        .fables-header {
            height: 280px;
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .fables-header h1 {
            font-size: 2.8rem;
            font-weight: 700;
            color: #fff;
            text-shadow: 0px 3px 8px rgba(0,0,0,0.5);
        }

        /* Dashboard Section */
        .dashboard-section {
            margin: 50px auto;
        }
        .card {
            border: none;
            border-radius: 14px;
            background: #fff;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: transform 0.25s ease, box-shadow 0.25s ease;
        }
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
        }
        .card i {
            padding: 15px;
            border-radius: 50%;
            background: #f1f5fb;
        }
        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #003366;
            margin-top: 12px;
        }
        .text-muted {
            font-size: 0.9rem;
        }

        /* Footer */
        footer {
            background: #003366;
            padding: 25px 0;
            margin-top: 40px;
            color: #fff;
        }
        footer .fables-footer-social-links li {
            display: inline-block;
            margin: 0 8px;
        }
        footer .fables-footer-social-links li a {
            color: #fff;
            font-size: 1.4rem;
            transition: color 0.3s;
        }
        footer .fables-footer-social-links li a:hover {
            color: #ffd633;
        }
        footer p {
            margin-top: 12px;
            font-size: 0.85rem;
            opacity: 0.8;
        }
    </style>
</head>

<body>

<!-- Top Header -->
<div class="fables-top-header-signin py-2 bg-light border-bottom">
    <div class="container d-flex justify-content-between">
        <p class="mb-0 font-14 text-muted"><i class="fas fa-university mr-2"></i>Welcome to YesBank Admin</p>
        <div>
            <span class="mr-4"><i class="fas fa-phone-alt mr-2"></i>+91 82003 74296</span>
            <span><i class="fas fa-envelope mr-2"></i>makwanayash705@gmail.com</span>
        </div>
    </div>
</div>

<!-- Navigation -->
<nav class="navbar navbar-expand-md navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">
            <img src="assets/custom/images/YesBank.png" alt="YesBank">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav ml-auto">
                <!-- Customer -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="account_list.jsp" id="custMenu" data-toggle="dropdown">Customer Management</a>
                </li>
                <!--Cashier-->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="cashier.jsp" id="custMenu" data-toggle="dropdown">Cashier</a>
                </li>
                <!-- Transaction -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="Transaction.jsp" id="txnMenu" data-toggle="dropdown">Transactions</a>
                </li>
                <!-- Logout -->
                <li class="nav-item">
                    <a class="nav-link text-danger font-weight-bold" href="logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Header Section -->
<header class="fables-header" style="background-image: url('assets/custom/images/img1.jpg');">
    <div class="container">
        <h1 class="wow fadeInUp" data-wow-delay="0.3s">Welcome To The Admin Dashboard</h1>
    </div>
</header>

<!-- Dashboard Quick Links -->
<div class="container dashboard-section">
    <div class="row justify-content-center text-center">
        <div class="col-md-4 mb-4">
            <div class="card p-4">
                <i class="fas fa-users fa-2x mb-3 text-primary"></i>
                <h5 class="card-title">Customer Accounts</h5>
                <p class="text-muted">Manage and view all customer accounts.</p>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card p-4">
                <i class="fas fa-exchange-alt fa-2x mb-3 text-info"></i>
                <h5 class="card-title">Transactions</h5>
                <p class="text-muted">Monitor deposits, withdrawals, and transfers.</p>
            </div>
        </div>
    </div>
</div>
    
<!-- Footer -->
<footer class="text-center">
    <ul class="fables-footer-social-links mb-2">
        <li><a href="#"><i class="fab fa-google-plus-square"></i></a></li>
        <li><a href="#"><i class="fab fa-facebook"></i></a></li>
        <li><a href="#"><i class="fab fa-instagram"></i></a></li>
        <li><a href="#"><i class="fab fa-pinterest-square"></i></a></li>
        <li><a href="#"><i class="fab fa-twitter-square"></i></a></li>
        <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
    </ul>
    <p>© 2025 YesBank Admin Panel</p>
</footer>

<!-- JS -->
<script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendor/owlcarousel/owl.carousel.min.js"></script> 
<script src="assets/vendor/WOW-master/dist/wow.min.js"></script>
<script src="assets/custom/js/custom.js"></script>
</body>
</html>
