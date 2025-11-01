<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - SmartBank</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #004e92, #000428);
            margin: 0;
            padding: 0;
        }
        .forgot-container {
            max-width: 420px;
            margin: 100px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .forgot-container h2 {
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
        .back-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #004e92;
            font-size: 14px;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
    <link rel="shortcut icon" type="image/x-icon" href="image/YesBank.png">
</head>
<body>

<div class="forgot-container">
    <img src="assets/custom/images/YesBank.png" alt="Bank Logo" class="bank-logo">
    <h2>Forgot Password</h2>
    <p style="text-align:center; color:#333; font-size:14px;">
        Enter your registered email address and we’ll send you a link to reset your password.
    </p>

    <form action="forgot_password" method="post">
        <div class="form-group">
            <label for="email">Registered Email Address</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Send Reset Link">
        </div>
        <a class="back-link" href="login.jsp">Back to Login</a>
    </form>
</div>

</body>
</html>
