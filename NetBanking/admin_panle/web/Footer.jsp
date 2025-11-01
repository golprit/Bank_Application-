<%-- 
    Document   : Footer
    Created on : Sep 2, 2025, 10:26:30 PM
    Author     : makwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Fables">
        <meta name="author" content="Enterprise Development">
        <link rel="shortcut icon" href="assets/custom/images/shortcut.png">
        <title>Footer</title>

        <style>
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
        </style>

        <!-- External Libraries -->
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
        <!-- Footer -->
        <div class="footer">
            <ul class="fables-footer-social-links">
                <li><a href="#"><i class="fab fa-google-plus-square"></i></a></li>
                <li><a href="#"><i class="fab fa-facebook"></i></a></li>
                <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                <li><a href="#"><i class="fab fa-pinterest-square"></i></a></li>
                <li><a href="#"><i class="fab fa-twitter-square"></i></a></li>
                <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
            </ul>
            <p>&copy; 2025 Yes Bank. All Rights Reserved.</p>
        </div>
        </div>
        <!-- Scripts -->
        <script src="assets/vendor/jquery/jquery-3.3.1.min.js"></script>
        <script src="assets/vendor/popper/popper.min.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap-4-navbar.js"></script>
        <script src="assets/vendor/owlcarousel/owl.carousel.min.js"></script> 
        <script src="assets/custom/js/custom.js"></script>  
    </body>
</html>
