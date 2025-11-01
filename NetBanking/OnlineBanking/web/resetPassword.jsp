<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Get the token from the URL parameter
    String token = request.getParameter("token");
    if (token == null || token.trim().isEmpty()) {
%>
    <script type="text/javascript">
        alert("Invalid or missing password reset token!");
        window.location = "login.jsp";
    </script>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password - SmartBank</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #004e92, #000428);
            margin: 0;
            padding: 0;
        }
        .reset-container {
            max-width: 420px;
            margin: 100px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .reset-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #004e92;
        }
        .bank-logo {
            display: block;
            margin: 0 auto 15px auto;
            width: 120px;
            height: auto;
        }
        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #333;
        }
        .form-group input {
            width: 95%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }
        .form-group input:focus {
            outline: none;
            border-color: #004e92;
            box-shadow: 0 0 5px rgba(0,78,146,0.5);
        }
        .form-group input[type="submit"] {
            background-color: #004e92;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: 0.3s;
        }
        .form-group input[type="submit"]:hover {
            background-color: #003366;
        }
        .login-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #004e92;
            font-size: 14px;
            text-decoration: none;
        }
        .login-link:hover {
            text-decoration: underline;
        }
    </style>
    <link rel="shortcut icon" type="image/x-icon" href="image/YesBank.png">
</head>
<body>

<div class="reset-container">
    <img src="assets/custom/images/YesBank.png" alt="Bank Logo" class="bank-logo">
    <h2>Reset Your Password</h2>

    <form action="ResetPassword" method="post">
        <!-- Hidden token to verify -->
        <input type="hidden" name="token" value="<%= token %>">

        <div class="form-group">
            <label for="password">New Password</label>
            <input type="password" id="password" name="password" placeholder="Enter new password" required>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter new password" required>
        </div>

        <div class="form-group">
            <input type="submit" value="Reset Password">
        </div>

        <a class="login-link" href="login.jsp">Back to Login</a>
    </form>
</div>

<script>
    // Simple frontend validation
    document.querySelector("form").addEventListener("submit", function(e) {
        const pwd = document.getElementById("password").value;
        const confirmPwd = document.getElementById("confirmPassword").value;
        if (pwd !== confirmPwd) {
            alert("Passwords do not match!");
            e.preventDefault();
        }
    });
</script>

</body>
</html>
