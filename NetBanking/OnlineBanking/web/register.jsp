<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html> 
<html lang="en"> 
<head>  
  <meta charset="UTF-8">  
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
  <title>YesBank - Register</title>  
  <style>  
    body {  
      font-family: Arial, sans-serif;  
      background: linear-gradient(to right, #004e92, #000428);  
      margin: 0;  
      padding: 0;  
    }  
    .registration-container {  
      max-width: 500px;  
      margin: 60px auto;  
      background-color: #fff;  
      padding: 30px;  
      border-radius: 10px;  
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);  
    }  
    .registration-container h2 {  
      text-align: center;  
      margin-bottom: 20px;  
      color: #004e92;  
    }  
    .form-group {  
      margin-bottom: 15px;  
    }  
    .form-group label {  
      display: block;  
      margin-bottom: 5px;  
      font-weight: bold;  
    }  
    .form-group input,  
    .form-group select,  
    .form-group textarea {  
      width: 95%;  
      padding: 10px;  
      border: 1px solid #ccc;  
      border-radius: 6px;  
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
    .btn-home {  
      display: inline-block;  
      text-align: center;  
      margin-top: 10px;  
      background-color: #777;  
      color: white;  
      padding: 10px 20px;  
      border-radius: 6px;  
      text-decoration: none;  
      font-size: 14px;  
      transition: 0.3s;  
    }  
    .btn-home:hover {  
      background-color: #555;  
    }  
    .error {  
      color: red;  
      font-size: 14px;  
    }  
    p a {  
      color: #004e92;  
      text-decoration: none;  
    }  
    p a:hover {  
      text-decoration: underline;  
    }  
    .password-info {  
      font-size: 13px;  
      color: #444;  
      background-color: #f4f4f4;  
      padding: 8px;  
      border-left: 4px solid #004e92;  
      border-radius: 5px;  
      margin-top: -5px;  
      margin-bottom: 10px;  
    }  
  </style> 
</head> 
<body>  

<div class="registration-container">  
  <h2>Bank Account Registration</h2>  
  <form id="registrationForm" action="register" method="post">  

    <div class="form-group">  
      <label for="surname">Surname</label>  
      <input type="text" id="surname" name="surname" required>  
    </div>  

    <div class="form-group">  
      <label for="firstname">First Name</label>  
      <input type="text" id="firstname" name="firstname" required>  
    </div>  

    <div class="form-group">  
      <label for="lastname">Last Name</label>  
      <input type="text" id="lastname" name="lastname" required>  
    </div>  

    <div class="form-group">  
      <label for="dob">Date of Birth</label>  
      <input type="date" id="dob" name="dob" required>  
    </div>  

    <div class="form-group">  
      <label for="address">Address</label>  
      <textarea id="address" name="address" rows="3" required></textarea>  
    </div>  

    <div class="form-group">  
      <label for="accountType">Account Type</label>  
      <select id="accountType" name="accountType" required>  
        <option value="">-- Select Account Type --</option>  
        <option value="savings">Savings Account</option>  
        <option value="student">Student Account</option>  
        <option value="business">Business Account</option>  
      </select>  
    </div>  

    <div class="form-group">  
      <label for="idProof">ID Proof Number</label>  
      <input type="text" id="idProof" name="idProof" placeholder="Aadhar / Passport / Driving License" required>  
    </div>  

    <div class="form-group">  
      <label for="email">Email</label>  
      <input type="email" id="email" name="email" required>  
    </div>  

    <div class="form-group">  
      <label for="phone">Phone Number</label>  
      <input type="tel" id="phone" name="phone" required pattern="[0-9]{10}">  
    </div>  

    <div class="form-group">  
      <label for="password">Password</label>  
      <input type="password" id="password" name="password" required>  
      <p class="password-info">
        Password must be 8–16 characters long and include at least one uppercase letter, 
        one lowercase letter, one number, and one special character (e.g., @, #, $, %).
      </p>
    </div>  

    <div class="form-group">  
      <label for="confirm_password">Confirm Password</label>  
      <input type="password" id="confirm_password" name="confirm_password" required>  
      <span class="error" id="passwordError"></span>  
    </div>  

    <div class="form-group">  
      <input type="submit" value="Register">  
    </div>  

    <span class="error" id="formError"></span>  
    <p><a href="login.jsp">Already Registered? Login</a></p>  
  </form>  

  <!-- Home Page Button -->  
  <div style="text-align:center;">  
    <a href="index.html" class="btn-home">🏦 Go to Home Page</a>  
  </div>  
</div>  

<script>  
document.getElementById('registrationForm').addEventListener('submit', function(e) {  
  let password = document.getElementById('password').value.trim();  
  let confirmPassword = document.getElementById('confirm_password').value.trim();  
  let passwordError = document.getElementById('passwordError');  
  passwordError.textContent = '';  

  if (password !== confirmPassword) {  
    e.preventDefault();  
    passwordError.textContent = 'Passwords do not match!';  
  }  
});  
</script>  
</body> 
</html>
