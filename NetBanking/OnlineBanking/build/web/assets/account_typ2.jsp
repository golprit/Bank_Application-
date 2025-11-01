<%-- 
    Document   : account_typ2
    Created on : Feb 8, 2025, 5:56:53 PM
    Author     : makwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
                <!-- animate.css-->  
                <link href="assets/vendor/animate.css-master/animate.min.css" rel="stylesheet">

                <meta charset="utf-8">
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
                <meta name="description" content="Fables">
                <meta name="author" content="Enterprise Development">

                <link rel="shortcut icon" href="assets/custom/images/shortcut.png">

                <title> Create Account </title>
                
                <link rel="shortcut icon" type="image/x-icon" href="image/YesBank.png">
                <!-- animate.css-->  
                <link href="assets/vendor/animate.css-master/animate.min.css" rel="stylesheet">
                <!-- Load Screen -->
                <link href="assets/vendor/loadscreen/css/spinkit.css" rel="stylesheet">
                <!-- GOOGLE FONT -->
                <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
                <!-- Font Awesome 5 -->
                <link href="assets/vendor/fontawesome/css/fontawesome-all.min.css" rel="stylesheet">
                <!-- Fables Icons -->
                <link href="assets/custom/css/fables-icons.css" rel="stylesheet"> 
                <!-- Bootstrap CSS --> 
                <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
                <link href="assets/vendor/bootstrap/css/bootstrap-4-navbar.css" rel="stylesheet">
                <!-- portfolio filter gallery -->
                <link href="assets/vendor/portfolio-filter-gallery/portfolio-filter-gallery.css" rel="stylesheet">
                <!-- Video Background -->
                <link href="assets/vendor/video-background/video-background.css" rel="stylesheet"> 
                <!-- FANCY BOX -->
                <link href="assets/vendor/fancybox-master/jquery.fancybox.min.css" rel="stylesheet"> 
                <!-- RANGE SLIDER -->
                <link href="assets/vendor/range-slider/range-slider.css" rel="stylesheet">
                <!-- OWL CAROUSEL  --> 
                <link href="assets/vendor/owlcarousel/owl.carousel.min.css" rel="stylesheet">
                <link href="assets/vendor/owlcarousel/owl.theme.default.min.css" rel="stylesheet">
                <!-- FABLES CUSTOM CSS FILE -->
                <link href="assets/custom/css/custom.css" rel="stylesheet">
                <!-- FABLES CUSTOM CSS RESPONSIVE FILE -->
                <link href="assets/custom/css/custom-responsive.css" rel="stylesheet">

    </head>
    <body>
    
        <div class="search-section">
        <a class="close-search" href="#"></a>
            <div class="d-flex justify-content-center align-items-center h-100">
                <form method="post" action="#" class="w-50">
                    <div class="row">
                        <div class="col-10">
                            <input type="search" value="" class="form-control palce bg-transparent border-0 search-input" placeholder="Search Here ..." /> 
                        </div>
                        <div class="col-2 mt-3">
                             <button type="submit" class="btn bg-transparent text-white"> <i class="fas fa-search"></i> </button>
                        </div>
                    </div>
                </form>
            </div>
            </div>

            <!-- Loading Screen -->
                <div id="ju-loading-screen">
                  <div class="sk-double-bounce">
                    <div class="sk-child sk-double-bounce1"></div>
                    <div class="sk-child sk-double-bounce2"></div>
                  </div>
                </div>
            
            <!-- Start Fables Navigation -->
            <div class="fables-navigation fables-main-background-color py-3 py-lg-0">
                <div class="container">
                           <div class="row">
                               <div class="col-12 col-md-10 col-lg-9 pr-md-0">                       
                                   <nav class="navbar navbar-expand-md btco-hover-menu py-lg-2">

                                       <a class="navbar-brand pl-0" href="index.html"><img src="assets/custom/images/YesBank.png" style="width:120px;height:60px" alt="Fables Template" class="fables-logo"></a>
                                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#fablesNavDropdown" aria-controls="fablesNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                                            <span class="fables-iconmenu-icon text-white font-16"></span>
                                        </button>
                                        <div class="collapse navbar-collapse" id="fablesNavDropdown"> 

                                            <ul class="navbar-nav mx-auto fables-nav">   
                                                <li class="nav-item dropdown">
                                                    <a class="nav-link dropdown-toggle" href="#" id="sub-nav1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        Accounts
                                                    </a>
                                                    <ul class="dropdown-menu" aria-labelledby="sub-nav1">
                                                        <li><a class="dropdown-item" href="account.jsp">Saving Account</a></li>
                                                        <li><a class="dropdown-item" href="account_type.jsp">Student Account</a></li>
                                                    </ul>
                                                </li>

                                                <li class="nav-item dropdown">
                                                    <a class="nav-link dropdown-toggle" href="#" id="sub-nav2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        Transactions
                                                    </a>
                                                    <ul class="dropdown-menu" aria-labelledby="sub-nav2">
                                                        <li><a class="dropdown-item" href="deposite.jsp">Deposite</a>
                                                        <li><a class="dropdown-item" href="#">Withdraw</a>
                                                        <li><a class="dropdown-item" href="team.html">Transfer Money</a></li>
                                                        <li><a class="dropdown-item" href="team.html">Transaction History</a></li>
                                                    </ul>
                                                </li>
                                                <li class="nav-item dropdown">
                                                    <a class="nav-link dropdown-toggle" href="#" id="sub-nav3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        Account Management
                                                    </a>
                                                    <ul class="dropdown-menu" aria-labelledby="sub-nav3">
                                                        <li><a class="dropdown-item" href="about1.html">View Account Details</a></li>
                                                        <li><a class="dropdown-item" href="about2.html">Edit Account Details</a></li>
                                                    </ul>
                                                </li>
                                                <li class="nav-item dropdown">
                                                    <a class="nav-link dropdown-toggle" href="#" id="sub-nav4" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        Customer Support
                                                    </a>
                                                    <ul class="dropdown-menu" aria-labelledby="sub-nav4">
                                                        <li><a class="dropdown-item" href="store_grid_list.html">Contact Us</a></li>
                                                        <li><a class="dropdown-item" href="store_single.html">Feedback</a></li> 
                                                    </ul>
                                                </li>
                                            </ul> 

                                </div>
                            </nav>
                               </div>
                               <div class="col-12 col-md-2 col-lg-3 pr-md-0 icons-header-mobile">
                                <div class="fables-header-icons">
                                    <a href="#" class="open-search fables-third-text-color right  top-header-link px-3 px-md-2 px-lg-4 fables-second-hover-color border-0 max-line-height">
                                        <span class="fables-iconsearch-icon"></span>
                                    </a>
                                     <a href="register.html" class="fables-third-text-color fables-second-hover-color font-13 top-header-link px-3 px-md-2 px-lg-4 max-line-height"><span class="fables-iconuser"></span></a>
                                </div>
                               </div>
                           </div>
                </div>
            </div> 
            
        <!-- /End Fables Navigation -->  

        
        
        <!-- Start page content -->   
        <div class="container">
             <div class="row my-4 my-lg-5">
                  <div class="col-12 col-md-10 offset-md-1 col-lg-6 offset-lg-3 text-center">
                       <img src="assets/custom/images/YesBank.png" style="width: 200px;height: 100px" alt="signin" class="img-fluid">
                       <p class="font-20 semi-font fables-main-text-color mt-4 mb-5">Create a new account</p>
                       <form action="account" method="post">
                          
                           <div class="form-row form-group">
                            <div class="col-12 col-md-6 mb-4 mb-md-0">
                                <div class="input-icon">
                                      <span class="fables-iconuser-register fables-input-icon mt-2 font-13"></span>
                                      <input type="text" name="fnm" class="form-control rounded-0 py-3 pl-5 font-13 sign-register-input" placeholder="First name" required>
                                </div>
                            </div>
                            <div class="col-12 col-md-6">
                                <div class="input-icon">
                                      <span class="fables-iconuser-register fables-input-icon mt-2 font-13"></span>
                                      <input type="text" name="lnm" class="form-control rounded-0 py-3 pl-5 font-13 sign-register-input" placeholder="Last name" required>
                                </div>
                            </div>
                          </div>
                          
                           <div class="form-group"> 
                              <div class="input-group">
                                   <span class="input-group-text" id="basic-addon1"><i class="bi bi-calendar"></i></span>
                                  <input type="date" name="date" class="form-control" id="dob" aria-describedby="basic-addon1" required> 
                              </div>

                          </div>
                        <div class="mb-3">
                                <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                                <input type="text" name="address" class="form-control" id="address" placeholder="Enter your address" required>
                                </div>
                        </div>
                            <div class="mb-3">
                           <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email" required>
                            </div>
                            </div>

                        <div class="mb-3">
                            <div class="input-group">
                            <span class="input-group-text" id="basic-addon6"><i class="bi bi-card-text"></i></span>
                            <input type="text" class="form-control" id="aadhaarNumber" placeholder="Enter Aadhaar Number" aria-describedby="basic-addon6" maxlength="12" name="adhar" pattern="\d{12}" required>
                            </div>
                        </div>

                          <input type="hidden" name="id" id="id">
                          <input type="submit" class="btn btn-block rounded-0 white-color fables-main-hover-background-color fables-second-background-color font-16 semi-font py-3" value="Create Now">
                        </form>
                  </div>
             </div>
        </div>
      
        <!-- /End page content -->

        
        
        <!-- Footer -->
        <%@include file="footer.jsp"%>
    </body>
</html>
