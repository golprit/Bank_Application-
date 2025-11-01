<%-- 
    Document   : TransactionHistory
    Created on : Oct 17, 2025, 12:20:33 PM
    Author     : Yash Makwana
--%>

<%@ page import="java.sql.*, javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Session validation 
    HttpSession se = request.getSession(false);
    if (se == null || se.getAttribute("email") == null) {
        response.sendRedirect("index.html");
        return;
    }

    String userEmail = (String) se.getAttribute("email");

    // DataBase Connection
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Transaction History</title>

    <link rel="shortcut icon" href="assets/custom/images/YesBank.png">
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/fontawesome/css/fontawesome-all.min.css" rel="stylesheet">
    <link href="assets/custom/css/custom.css" rel="stylesheet">
    <link href="assets/custom/css/custom-responsive.css" rel="stylesheet">

    <style>
        body {
            font-family: "Open Sans", sans-serif;
            background: #f5f7fa;
        }
        .navbar-brand img { height: 55px; }
        .welcome-banner {
            background: linear-gradient(135deg, #004e92, #000428);
            color: #fff;
            padding: 60px 0;
            text-align: center;
        }
        .welcome-banner h1 { font-weight: 600; font-size: 36px; }
        .welcome-banner p { font-size: 18px; margin-top: 10px; }

        .history-section {
            margin: 60px auto;
            max-width: 900px;
            background: #fff;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0,0,0,.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            background-color: #004e92;
            color: white;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        tr:hover { background-color: #f1f1f1; }

        footer {
            background: #002244;
            color: #ccc;
        }
        footer a { color: #ccc; }
        footer a:hover { color: #fff; text-decoration: none; }

        /* Stylish select box */
        .filter-select { margin-bottom: 25px; }

        .custom-select-history {
            padding: 10px 15px;
            border: 2px solid #004e92;
            border-radius: 6px;
            background-color: #fff;
            color: #004e92;
            font-weight: 600;
            font-size: 16px;
            outline: none;
            transition: all 0.3s ease;
            width: 250px;
            text-align: center;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml;utf8,<svg fill='%23004e92' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/></svg>");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 18px;
        }

        .custom-select-history:hover {
            background-color: #004e92;
            color: #fff;
        }

        .custom-select-history:focus {
            border-color: #002244;
            box-shadow: 0 0 5px rgba(0, 78, 146, 0.4);
        }
    </style>
</head>

<body>

    <!-- ===== Navbar ===== -->
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
                    <li class="nav-item active"><a class="nav-link" href="TransactionHistory.jsp">History</a></li>
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

    <!-- ===== Transaction History Section ===== -->
    <div class="container history-section">
        <div class="filter-select text-center mb-4">
            <label for="historyType" class="mr-2 font-weight-bold text-secondary">View:</label>
            <select id="historyType" class="custom-select-history" onchange="filterHistory()">
                <option value="" selected disabled>-- Select History Type --</option>
                <option value="deposit">Deposit History</option>
                <option value="transaction">Transaction History</option>
            </select>
        </div>

        <div id="historyTable">
            <p class="text-center text-muted">Please select a history type to view records.</p>
        </div>
    </div>

    <!-- ===== JSP Dynamic Data (Hidden Section Loaded via AJAX) ===== -->
    <div id="historyData" style="display:none;">
        <%
            String type = request.getParameter("type");
            if (type != null && !type.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking", "root", "");
                    String query = "";

                    if (type.equals("deposit")) {
                        query = "SELECT * FROM userhistory WHERE email = ?";
                    } else if (type.equals("transaction")) {
                        query = "SELECT * FROM transermoney WHERE SenderEmail = ?";
                    }

                    ps = con.prepareStatement(query);
                    ps.setString(1, userEmail);
                    rs = ps.executeQuery();

                    boolean hasData = false;
        %>

        <table id="resultTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <% if ("deposit".equals(type)) { %>
                        <th>ID</th>
                        <th>Amount (₹)</th>
                        <th>Status</th>
                        <th>Date</th>
                    <% } else { %>
                        <th>ID</th>
                        <th>Send To</th>
                        <th>Amount</th>
                        <th>Transfer At</th>
                        <th>Transaction ID</th>
                        <th>Status</th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        hasData = true;
                        if ("deposit".equals(type)) {
                %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("Amount") %></td>
                        <td><%= rs.getString("Status") %></td>
                        <td><%= rs.getTimestamp("DateTime") %></td>
                    </tr>
                <% } else { %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("ReciveAccountNumber") %></td>
                        <td><%= rs.getInt("Amount") %></td>
                        <td><%= rs.getTimestamp("Transfer_at") %></td>
                        <td><%= rs.getString("TransactionID") %></td>
                        <td><%= rs.getString("status") %></td>
                    </tr>
                <% } } if (!hasData) { %>
                    <tr><td colspan="6" class="text-center">No <%= type %> records found.</td></tr>
                <% } %>
            </tbody>
        </table>

        <%
                } catch (Exception e) {
                    out.println("<p class='text-danger text-center'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                    try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                    try { if (con != null) con.close(); } catch (Exception ignored) {}
                }
            }
        %>
    </div>

    <!-- ===== Footer ===== -->
    <footer class="pt-5 pb-3 mt-5">
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
    <script>
        function filterHistory() {
            const type = document.getElementById("historyType").value;
            const tableDiv = document.getElementById("historyTable");

            if (!type) {
                tableDiv.innerHTML = "<p class='text-center text-muted'>Please select a history type to view records.</p>";
                return;
            }

            // Load data dynamically from same JSP
            fetch("TransactionHistory.jsp?type=" + type)
                .then(response => response.text())
                .then(data => {
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(data, "text/html");
                    const resultTable = doc.querySelector("#resultTable");
                    if (resultTable) {
                        tableDiv.innerHTML = resultTable.outerHTML;
                    } else {
                        tableDiv.innerHTML = "<p class='text-center text-danger'>No records found.</p>";
                    }
                })
                .catch(err => {
                    console.error(err);
                    tableDiv.innerHTML = "<p class='text-center text-danger'>Error loading history.</p>";
                });
        }
    </script>
</body>
</html>
