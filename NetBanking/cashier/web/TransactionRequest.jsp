<%-- 
    Document   : TransactionRequest
    Created on : Oct 25, 2025, 9:58:27 AM
    Author     : makwa
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="java.sql.*"%>
<%
    session=request.getSession(false);
    if(session==null || session.getAttribute("email")==null)
    {
        response.sendRedirect("index.html");
    }
    String email = (String) session.getAttribute("email");
    session.setAttribute("email", email);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transaction Request</title>
            <style>
            body {
                font-family: 'Open Sans', sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
                color: #222;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin: 30px auto;
                background-color: #fff;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            th, td {
                border: 1px solid #dee2e6;
                padding: 10px;
                text-align: left;
            }

            th {
                background-color: #004085;
                color: #fff;
            }

            td {
                background-color: #fdfdfd;
            }

            a[href*="accept"] {
                font-weight: bold;
                color: green !important;
            }

            a[href*="reject"] {
                font-weight: bold;
                color: red !important;
            }

            /* Header styling */
            .fables-top-header-signin p {
                color: #fff !important;
                margin: 0;
            }

            .fables-top-header-signin span {
                color: #ffdd57 !important;
            }

            /* Navbar */
            .fables-nav .nav-link {
                color: #fff !important;
            }

            .fables-nav .nav-link:hover {
                color: #ffdd57 !important;
            }

            /* Footer */
            .fables-footer-social-links li a {
                color: #fff !important;
                font-size: 22px;
            }

            .fables-footer-social-links li a:hover {
                color: #ffdd57 !important;
            }

            .spacer {
                height: 50px;
            }

            <!-- Custom Styles -->
            /* Make body use full height */
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            /* Main content takes available space */
            .main-content {
                flex: 1;
            }

            /* Footer stays at bottom */
            .footer {
                background-color: #002147; /* Dark navy for banking look */
                color: #fff;
                text-align: center;
                padding: 15px 0;
                margin-top: auto; /* pushes footer to bottom */
            }

            .footer ul {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex;
                justify-content: center;
                gap: 15px;
            }

            .footer ul li a {
                color: #fff;
                font-size: 22px;
                transition: color 0.3s;
            }

            .footer ul li a:hover {
                color: #ffdd57; /* yellow hover */
            }
        </style><!-- External Libraries -->
        <link href="assets/vendor/animate.css-master/animate.min.css" rel="stylesheet">
        <link href="assets/vendor/loadscreen/css/spinkit.css" rel="stylesheet">
        <link href="assets/vendor/fontawesome/css/fontawesome-all.min.css" rel="stylesheet">
        <link href="assets/custom/css/fables-icons.css" rel="stylesheet"> 
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap/css/bootstrap-4-navbar.css" rel="stylesheet">
        <link href="assets/vendor/owlcarousel/owl.carousel.min.css" rel="stylesheet">
        <link href="assets/vendor/owlcarousel/owl.theme.default.min.css" rel="stylesheet">
        <link href="assets/custom/css/custom.css" rel="stylesheet">
        <link href="assets/custom/css/custom-responsive.css" rel="stylesheet">
        </head>
        <body>
        <div class="fables-forth-background-color fables-top-header-signin">
                <div class="container">
                    <div class="row" id="top-row">
                        <div class="col-12 col-sm-5 offset-sm-7 text-right">
                            <p><span class="fables-iconphone"></span> Phone : +918200374296</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Navigation -->
            <div class="fables-navigation fables-main-background-color py-3 py-lg-0">
                <div class="container">
                    <nav class="navbar navbar-expand-md btco-hover-menu py-lg-2">
                        <a class="navbar-brand pl-0" href="home.jsp">
                            <img src="assets/custom/images/YesBank.png" style="width:120px;height:60px" alt="Logo">
                        </a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#fablesNavDropdown">
                            <span class="fables-iconmenu-icon text-white font-16"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="fablesNavDropdown">
                            <ul class="navbar-nav mx-auto fables-nav">   
                                <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li> 
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">Deposit Management</a>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="ApprovedDeposit.jsp">Approved Deposit</a></li>
                                        <li><a class="dropdown-item" href="DepositRequest.jsp">Deposit Request</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">Transaction Management</a>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="ApprovedTransaction.jsp">Approved Transaction</a></li>
                                        <li><a class="dropdown-item" href="TransactionRequest.jsp">Transaction Request</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item"><a class="nav-link" href="logout">Logout</a></li> 
                            </ul> 
                        </div>
                    </nav>
                </div>
            </div>

        
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
                        <th>Transfer_At</th>
                        <th>Transaction_ID</th>
                        <th>Accept</th>
                        <th>Reject</th>
                    </tr>
                </thead>
                <tbody>
                        <%
                            boolean hasPending = false;

                            try (
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking", "root", "");
                                PreparedStatement ps = con.prepareStatement("SELECT * FROM moneytransfer_request");
                                ResultSet rs = ps.executeQuery();
                            ) {
                                while (rs.next()) {
                                    String status = rs.getString("status");
                                    
                                    if ("pending".equalsIgnoreCase(status)) {   // ✅ correct spelling check
                                        hasPending = true;
                        %>
                                        <tr>
                                            <td><%= rs.getInt("id") %></td>
                                            <td><%= rs.getString("SenderAccountNumber") %></td>
                                            <td><%= rs.getString("ReciveAccountNumber") %></td>
                                            <td><%= rs.getString("Amount") %></td>
                                            <td><%= rs.getString("Transfer_at") %></td>
                                            <td><%= rs.getString("TransactionID") %></td>
                                            <td>
                                                <form action="TransactionRequestAccept" method="post">
                                                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                    <input type="hidden" name="SenderAccountNumber" value="<%= rs.getString("SenderAccountNumber") %>">
                                                    <input type="hidden" name="ReciveAccountNumber" value="<%= rs.getString("ReciveAccountNumber") %>">
                                                    <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                                                    <input type="hidden" name="amount" value="<%= rs.getInt("Amount") %>">
                                                    <input type="hidden" name="Transfer_at" value="<%= rs.getTimestamp("Transfer_at") %>">
                                                    <input type="hidden" name="TransactionID" value="<%= rs.getString("TransactionID") %>">
                                                    <button type="submit" style="background:none; border:none; color:green; font-weight:bold; cursor:pointer;">Accept</button>
                                                </form>
                                            </td>
                                            <td>
                                                <form action="reject" method="post">
                                                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                                    <input type="hidden" name="email" value="<%= rs.getString("email") %>">
                                                    <input type="hidden" name="TransactionID" value="<%= rs.getString("TransactionID") %>">
                                                    <button type="submit" style="background:none; border:none; color:red; font-weight:bold; cursor:pointer;">Reject</button>
                                                </form>
                                            </td>
                                        </tr>
                        <%
                                    }
                                }

                                // 🟥 If no pending requests found
                                if (!hasPending) {
                        %>
                                    <tr>
                                        <td colspan="12" style="text-align:center; font-weight:bold; color:#ff0000; padding:20px;">
                                            🚫 No Pending Requests 🚫
                                        </td>
                                    </tr>
                        <%
                                }
                            } catch (Exception e) {
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