<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register - MiniLogix</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', sans-serif;
    }
    body {
      display: flex;
      height: 100vh;
      background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
      overflow: hidden;
    }
    /* Left Panel */
    .left-panel {
      flex: 1;
      background: rgba(255, 255, 255, 0.05);
      backdrop-filter: blur(6px);
      color: #fff;
      padding: 40px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      animation: fadeInLeft 1.2s ease;
    }
    .left-panel img {
      width: 120px;
      margin-bottom: 20px;
      animation: float 4s ease-in-out infinite;
    }
    .left-panel h2 {
      font-size: 28px;
      margin-bottom: 10px;
    }
    .left-panel p {
      text-align: center;
      max-width: 300px;
      line-height: 1.5;
      opacity: 0.9;
    }
    /* Right Panel */
    .right-panel {
      flex: 1.2;
      background: #fff;
      border-radius: 40px 0 0 40px;
      display: flex;
      justify-content: center;
      align-items: center;
      animation: fadeInRight 1.2s ease;
    }
    form {
      width: 80%;
      max-width: 400px;
    }
    form h2 {
      text-align: center;
      color: #203a43;
      margin-bottom: 20px;
    }
    .form-group {
      margin-bottom: 15px;
      position: relative;
    }
    label {
      font-weight: bold;
      color: #203a43;
      display: block;
      margin-bottom: 5px;
    }
    input {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid #aaa;
      border-radius: 8px;
      transition: all 0.3s ease;
    }
    input:focus {
      border-color: #2c5364;
      box-shadow: 0 0 8px rgba(44, 83, 100, 0.4);
      outline: none;
      transform: scale(1.02);
    }
    button {
      width: 100%;
      padding: 12px;
      background: linear-gradient(135deg, #2c5364, #203a43);
      border: none;
      border-radius: 8px;
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      transition: background 0.3s ease, transform 0.2s ease;
    }
    button:hover {
      background: linear-gradient(135deg, #203a43, #0f2027);
      transform: translateY(-3px);
    }
    /* Animations */
    @keyframes fadeInLeft {
      from {opacity: 0; transform: translateX(-50px);}
      to {opacity: 1; transform: translateX(0);}
    }
    @keyframes fadeInRight {
      from {opacity: 0; transform: translateX(50px);}
      to {opacity: 1; transform: translateX(0);}
    }
    @keyframes float {
      0%, 100% {transform: translateY(0);}
      50% {transform: translateY(-10px);}
    }
  </style>
</head>
<body>
  <!-- Left Section -->
  <div class="left-panel">
   		<img src="images/back.png" alt="MiniLogix Logo">
   		
    <h2>Welcome to MiniLogix</h2>
    <p>Your trusted partner in smart logistics solutions. Simplifying deliveries and ensuring speed, safety, and reliability for your business growth.</p>
  </div>

  <!-- Right Section -->
  <div class="right-panel">
    <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
      <h2>Create Your Account</h2>

      <div class="form-group">
        <label for="firstName">First Name</label>
        <input type="text" id="firstName" name="firstName" required>
      </div>

      <div class="form-group">
        <label for="lastName">Last Name</label>
        <input type="text" id="lastName" name="lastName" required>
      </div>

      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>
      </div>

      <div class="form-group">
        <label for="contact">Contact</label>
        <input type="text" id="contact" name="contact" maxlength="10" placeholder="Digits only" required>
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
      </div>

      <button type="submit">Register</button>
    </form>
  </div>

  <script>
    function validateForm() {
      const contact = document.getElementById("contact").value;
      const digitOnly = /^\d+$/;
      if (!digitOnly.test(contact)) {
        alert("Contact must contain digits only!");
        return false;
      }
      return true;
    }
  </script>
</body>
</html>
