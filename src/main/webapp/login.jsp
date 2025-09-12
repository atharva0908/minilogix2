<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login - MiniLogix</title>
  <style>
    * {
      margin: 0; padding: 0; box-sizing: border-box;
      font-family: 'Segoe UI', sans-serif;
    }
    body {
      display: flex;
      height: 100vh;
      background: linear-gradient(-45deg, #0f2027, #203a43, #2c5364, #1b2735);
      background-size: 400% 400%;
      animation: gradientBG 10s ease infinite;
      overflow: hidden;
    }
    /* Animated background */
    @keyframes gradientBG {
      0% {background-position: 0% 50%;}
      50% {background-position: 100% 50%;}
      100% {background-position: 0% 50%;}
    }

    .left-panel {
      flex: 1;
      color: #fff;
      display: flex; flex-direction: column;
      justify-content: center; align-items: center;
      padding: 40px;
      backdrop-filter: blur(6px);
      animation: fadeInLeft 1.2s ease;
    }
    .left-panel img {
      width: 120px; margin-bottom: 20px;
      animation: float 4s ease-in-out infinite;
    }
    .left-panel h2 {
      font-size: 28px; margin-bottom: 10px;
    }
    .left-panel p {
      text-align: center; max-width: 300px;
      line-height: 1.5; opacity: 0.9;
    }

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
      width: 80%; max-width: 400px;
    }
    form h2 {
      text-align: center; color: #203a43;
      margin-bottom: 20px;
    }
    .form-group {
      margin-bottom: 15px;
    }
    label {
      font-weight: bold; color: #203a43;
      display: block; margin-bottom: 5px;
    }
    input {
      width: 100%; padding: 10px 12px;
      border: 1px solid #aaa; border-radius: 8px;
      transition: all 0.3s ease;
    }
    input:focus {
      border-color: #2c5364;
      box-shadow: 0 0 8px rgba(44,83,100,0.4);
      outline: none;
      transform: scale(1.02);
    }
    .forgot-password {
      display: block;
      text-align: right;
      font-size: 14px;
      margin-bottom: 20px;
      color: #2c5364;
      text-decoration: none;
      transition: color 0.3s ease;
    }
    .forgot-password:hover {
      color: #0f2027;
      text-decoration: underline;
    }
    button {
      width: 100%; padding: 12px;
      background: linear-gradient(135deg, #2c5364, #203a43);
      border: none; border-radius: 8px;
      color: #fff; font-size: 16px; font-weight: bold;
      cursor: pointer;
      transition: transform 0.2s ease;
    }
    button:hover {
      transform: scale(1.05);
      animation: pulse 1s infinite;
    }
    @keyframes pulse {
      0%,100% {box-shadow: 0 0 0 0 rgba(44,83,100,0.6);}
      50% {box-shadow: 0 0 15px 5px rgba(44,83,100,0.3);}
    }
    /* Panel animations */
    @keyframes fadeInLeft {
      from {opacity: 0; transform: translateX(-50px);}
      to {opacity: 1; transform: translateX(0);}
    }
    @keyframes fadeInRight {
      from {opacity: 0; transform: translateX(50px);}
      to {opacity: 1; transform: translateX(0);}
    }
    @keyframes float {
      0%,100% {transform: translateY(0);}
      50% {transform: translateY(-10px);}
    }
  </style>
</head>
<body>
  <!-- Left Section -->
  <div class="left-panel">
    <img src="images/back.png" alt="MiniLogix Logo">
    <h2>Welcome Back!</h2>
    <p>Streamline your logistics operations effortlessly. Log in to manage shipments, track deliveries, and keep your business moving forward.</p>
  </div>

  <!-- Right Section -->
  <div class="right-panel">
    <form action="LoginServlet" method="post">
      <h2>Login</h2>

      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
      </div>

      <a href="forgotPassword.jsp" class="forgot-password">Forgot Password?</a>

      <button type="submit">Login</button>
    </form>
  </div>
</body>
</html>
