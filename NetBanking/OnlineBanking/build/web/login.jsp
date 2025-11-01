<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="passwordencryption.PasswordEncryption" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String emailParam = request.getParameter("email");
    String password = request.getParameter("password");

    if (emailParam != null && password != null) {
        try {
            String hashedPassword = PasswordEncryption.hashPassword(password);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/netbanking","root","");

            PreparedStatement ps = con.prepareStatement(
                "SELECT email,password FROM register_user WHERE email=? AND password=?"
            );
            ps.setString(1, emailParam.toLowerCase());
            ps.setString(2, hashedPassword);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                session.setAttribute("email", emailParam);
                request.getRequestDispatcher("CheckUser").forward(request, response);
                // or servlet mapping name
                return;
            } else {
%>
                <script type="text/javascript">
                    alert("Invalid email or password!");
                    window.location = "login.jsp";
                </script>
<%
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SmartBank - Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #004e92, #000428);
            margin: 0;
            padding: 0;
        }
        .login-container {
            max-width: 420px;
            margin: 100px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .login-container h2 {
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
        .register-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #004e92;
            font-size: 14px;
            text-decoration: none;
        }
        .register-link:hover {
            text-decoration: underline;
        }
        .forgot-link {
            display: block;
            text-align: center;
            margin-top: 8px;
            color: #666;
            font-size: 14px;
            text-decoration: none;
        }

        .forgot-link:hover {
            text-decoration: underline;
            color: #004e92;
        }
    </style>
    <link rel="shortcut icon" type="image/x-icon" href="image/YesBank.png">
</head>
<body>

<div class="login-container">
    <img src="assets/custom/images/YesBank.png" alt="Bank Logo" class="bank-logo">
    <h2>Customer Login</h2>
    <form id="loginForm" action="login.jsp" method="post">
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <input type="submit" value="Login">
        </div>
        
        <!-- Forgot Password link -->
        <a class="forgot-link" href="forgot_password.jsp">Forgot Password?</a>
        <a class="register-link" href="register.jsp">Don't have an account? Register here!</a>
    </form>
</div>
</body>
</html>
