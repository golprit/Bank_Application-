<%-- 
    Document   : EmailCheck
    Created on : Aug 27, 2025, 1:17:54 PM
    Author     : makwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.servlet.http.HttpSession"%>

<%
    HttpSession se = request.getSession(false);
    String userEmail = null;

    if (se != null) 
    {
        userEmail = (String) se.getAttribute("useremail");
        if (userEmail == null) 
        {
            response.sendRedirect("register.jsp");
            return; // stop rendering page
        }
    } 
    else 
    {
        response.sendRedirect("register.jsp");
        return; // stop rendering page
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Email OTP Validation</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f0f4f9;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .otp-container {
      background: #fff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      text-align: center;
      width: 350px;
    }

    .otp-container h2 {
      margin-bottom: 10px;
      color: #222;
    }

    .otp-container p {
      font-size: 14px;
      margin-bottom: 20px;
      color: #555;
    }

    .otp-inputs {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }

    .otp-inputs input {
      width: 45px;
      height: 50px;
      text-align: center;
      font-size: 20px;
      border: 2px solid #ddd;
      border-radius: 8px;
      outline: none;
      transition: border-color 0.3s;
    }

    .otp-inputs input:focus {
      border-color: #007bff;
    }

    button {
      width: 100%;
      padding: 12px;
      border: none;
      border-radius: 8px;
      background: #007bff;
      color: #fff;
      font-size: 16px;
      cursor: pointer;
      transition: background 0.3s;
    }

    button:hover {
      background: #0056b3;
    }

    .resend {
      margin-top: 15px;
      font-size: 14px;
      color: #007bff;
      cursor: pointer;
    }
  </style>
</head>
<body>
  <div class="otp-container">
    <h2>Email Verification</h2>
    <p>Enter the 6-digit code sent to <b><%= userEmail %></b></p>
    <form action="OTPCheck" method="post">
      <div class="otp-inputs">
        <!-- keep email hidden -->
        <input type="text" name="d1" maxlength="1" required>
        <input type="text" name="d2" maxlength="1" required>
        <input type="text" name="d3" maxlength="1" required>
        <input type="text" name="d4" maxlength="1" required>
        <input type="text" name="d5" maxlength="1" required>
        <input type="text" name="d6" maxlength="1" required>
      </div>
      <button type="submit">Verify OTP</button>
    </form>
    <div class="resend">Resend Code</div>
  </div>
</body>
</html>
