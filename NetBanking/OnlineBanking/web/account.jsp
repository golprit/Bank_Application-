<%-- 
    Document   : account
    Created on : Jan 28, 2025, 3:54:57 PM
    Author     : makwa
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="AccountHeader.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
    </head>    
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
        <script>
            function goBack() {
                window.history.back();
            }
        </script>
    </body>
</html>
