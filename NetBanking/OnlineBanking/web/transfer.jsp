<%-- 
    Document   : transfer
    Created on : Oct 18, 2025, 6:22:56 PM
    Author     : makwa
--%>

<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check session and redirect if not logged in
    HttpSession se = request.getSession(false);
    if (se == null || se.getAttribute("email") == null) {
        response.sendRedirect("index.html");
        return;
    }
    String userEmail = (String) se.getAttribute("email");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Transfer Money</title>
        <!-- Vendor/Theme CSS -->
        <link rel="shortcut icon" href="assets/custom/images/YesBank.png">
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/fontawesome/css/fontawesome-all.min.css" rel="stylesheet">
        <link href="assets/custom/css/custom.css" rel="stylesheet">
        <link href="assets/custom/css/custom-responsive.css" rel="stylesheet">

        <style>
            body{
                font-family: "Open Sans", sans-serif;
                background:#f5f7fa;
            }
            .navbar-brand img { height:55px; }
            .welcome-banner{
                background: linear-gradient(135deg,#004e92,#000428);
                color:#fff;
                padding:60px 0;
                text-align:center;
            }
            .welcome-banner h1{ font-weight:600; font-size:36px; }
            .welcome-banner p{ font-size:18px; margin-top:10px; }

            .quick-actions{ margin-top:-40px; }
            .action-card{
                background:#fff;
                border-radius:10px;
                padding:30px 20px;
                box-shadow:0 4px 10px rgba(0,0,0,.1);
                transition:transform .2s;
            }
            .action-card:hover{ transform:translateY(-5px); }
            .action-card i{
                font-size:40px;
                color:#004e92;
                margin-bottom:15px;
            }
            footer{
                background:#002244;
                color:#ccc;
            }
            footer a{ color:#ccc; }
            footer a:hover{ color:#fff; text-decoration:none; }

            /* extra styling for the deposit form */
            .deposit-form-card {
                max-width: 600px;
                margin: 60px auto;
                background: #fff;
                border-radius: 10px;
                padding: 40px 30px;
                box-shadow: 0 4px 10px rgba(0,0,0,.1);
            }
            .deposit-form-card h2 {
                color: #004e92;
                font-weight: 600;
                margin-bottom: 25px;
            }

            /* ADDED */
            #receiverInfo {
                margin-top: 10px;
                font-weight: 500;
            }
        </style>

        <!-- ADDED -->
        <script>
            function fetchReceiverDetails() {
                var accNo = document.getElementById("toAccount").value.trim();
                if (accNo === "") {
                    document.getElementById("receiverInfo").innerHTML = "";
                    return;
                }

                fetch("ReceiverDetailsServlet?accountNumber=" + accNo)
                    .then(response => response.text())
                    .then(data => {
                        document.getElementById("receiverInfo").innerHTML = data;
                    })
                    .catch(error => {
                        document.getElementById("receiverInfo").innerHTML = "<span style='color:red;'>Error fetching data</span>";
                    });
            }
        </script>
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
                        <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
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
                <h1>Hello, <%= userEmail %>!</h1>
                <p>Use the form below to transfer funds securely.</p>
            </div>
        </section>

        <!--Money Transfer Form-->
        <section>
            <div class="container">
                <div class="deposit-form-card">
                    <h2 class="text-center mb-4">Transfer Money</h2>
                    <form action="TransferMoney" method="post">
                        <div class="form-group">
                            <label for="fromAccount">From Account (Your Account Number)</label>
                            <input type="text" id="fromAccount" name="fromAccount" class="form-control" placeholder="Enter your account number" required>
                        </div>

                        <div class="form-group mt-3">
                            <label for="toAccount">To Account Number</label>
                            <input type="text" id="toAccount" name="toAccount" class="form-control"
                                   placeholder="Enter receiver account number"
                                   onblur="fetchReceiverDetails()" required>
                            <!-- ADDED -->
                            <div id="receiverInfo"></div>
                        </div>

                        <div class="form-group mt-3">
                            <label for="ifsc">IFSC Code</label>
                            <input type="text" id="ifsc" name="ifsc" class="form-control" placeholder="Enter receiver bank IFSC code" required>
                        </div>

                        <div class="form-group mt-3">
                            <label for="amount">Amount</label>
                            <input type="number" id="amount" name="amount" class="form-control" placeholder="Enter amount to transfer" required min="1">
                        </div>

                        <div class="form-group mt-3">
                            <label for="remark">Remark (optional)</label>
                            <input type="text" id="remark" name="remark" class="form-control" placeholder="Reason for transfer">
                        </div>

                        <div class="text-center mt-4">
                            <button type="submit" class="btn btn-primary px-4 py-2">Transfer</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <!--Footer-->
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
