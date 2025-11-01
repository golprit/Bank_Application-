<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check session and redirect if not logged in
    HttpSession se = request.getSession(false);
    if (se == null || se.getAttribute("email") == null)
    {
        response.sendRedirect("index.html");
        return;
    }
    String userEmail = (String) se.getAttribute("email");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Yes Bank – User Dashboard</title>
    <link rel="shortcut icon" href="assets/custom/images/YesBank.png">
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/fontawesome/css/fontawesome-all.min.css" rel="stylesheet">
    <link href="assets/custom/css/custom.css" rel="stylesheet">
    <link href="assets/custom/css/custom-responsive.css" rel="stylesheet">

        <!-- Custom Dashboard Styling -->
        <style>
            body{
                font-family: "Open Sans", sans-serif;
                background:#f5f7fa;
            }
            /* top navbar */
            .navbar-brand img { height:55px; }
            /* welcome banner */
            .welcome-banner{
                background: linear-gradient(135deg,#004e92,#000428);
                color:#fff;
                padding:60px 0;
                text-align:center;
            }
            .welcome-banner h1{ font-weight:600; font-size:36px; }
            .welcome-banner p{ font-size:18px; margin-top:10px; }

            /* quick actions */
            .quick-actions{
                margin-top:-40px;
            }
            .action-card{
                background:#fff;
                border-radius:10px;
                padding:30px 20px;
                box-shadow:0 4px 10px rgba(0,0,0,.1);
                transition:transform .2s;
            }
            .action-card:hover{
                transform:translateY(-5px);
            }
            .action-card i{
                font-size:40px;
                color:#004e92;
                margin-bottom:15px;
            }
            /* footer */
            footer{
                background:#002244;
                color:#ccc;
            }
            footer a{ color:#ccc; }
            footer a:hover{ color:#fff; text-decoration:none; }
        </style>
    </head>
    <body>

    <!-- ===== Navigation ===== -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="assets/custom/images/YesBank.png" alt="Yes Bank">
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="deposite.jsp">Deposit</a></li>
                    <li class="nav-item"><a class="nav-link" href="transfer.jsp">Transfer</a></li>
                    <li class="nav-item"><a class="nav-link" href="TransactionHistory.jsp">History</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- ===== Welcome Banner ===== -->
    <section class="welcome-banner">
        <div class="container">
            <h1>Welcome back, <%= userEmail %>!</h1>
            <p>Your secure Yes Bank dashboard</p>
        </div>
    </section>

    <!-- ===== Quick Actions ===== -->
    <section class="quick-actions py-5">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="action-card">
                        <i class="fas fa-university"></i>
                        <h5>View Balance</h5>
                        <p>Check your latest account balance.</p>
                        <a href="balance.jsp" class="btn btn-outline-primary btn-sm mt-2">View</a>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="action-card">
                        <i class="fas fa-arrow-down"></i>
                        <h5>Deposit Funds</h5>
                        <p>Quickly add money to your account.</p>
                        <a href="deposite.jsp" class="btn btn-outline-primary btn-sm mt-2">Deposit</a>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="action-card">
                        <i class="fas fa-exchange-alt"></i>
                        <h5>Transfer Money</h5>
                        <p>Send funds to another account securely.</p>
                        <a href="transfer.jsp" class="btn btn-outline-primary btn-sm mt-2">Transfer</a>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="action-card">
                        <i class="fas fa-history"></i>
                        <h5>Transaction History</h5>
                        <p>View all recent transactions.</p>
                        <a href="TransactionHistory.jsp" class="btn btn-outline-primary btn-sm mt-2">View</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="pt-5 pb-3">
                <div class="container">
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <h5 class="text-uppercase">Yes Bank</h5>
                        <p>Secure, smart and seamless banking for your future.</p>
                    </div>
                    <div class="col-md-4 mb-4">
                        <h5 class="text-uppercase">Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="deposite.jsp">Deposit</a></li>
                            <li><a href="contact.jsp">Contact Support</a></li>
                            <li><a href="logout">Logout</a></li>
                        </ul>
                    </div>
                    <div class="col-md-4 mb-4">
                        <h5 class="text-uppercase">Contact</h5>
                        <p class="mb-1"><i class="fas fa-map-marker-alt mr-2"></i>123 Smart Street, Morbi, India</p>
                        <p class="mb-1"><i class="fas fa-phone mr-2"></i>+91 8200374296</p>
                        <p><i class="fas fa-envelope mr-2"></i>support@yesbank.com</p>
                        <div>
                            <a href="#" class="text-light mr-3"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="text-light mr-3"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-light mr-3"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
                <hr class="border-secondary">
                <div class="text-center">
                    © <%= java.time.Year.now() %> Yes Bank. All rights reserved.
                </div>
            </div>
        </footer>

        <!-- ===== Scripts ===== -->
        <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
       
</body>
</html>
