<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .social-login .btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-size: 16px;
            padding: 10px;
            border-radius: 5px;
        }
        .btn-google {
            background-color: #ffffff;
            color: #333;
            border: 1px solid #ccc;
        }
        .btn-google:hover {
            background-color: #f1f1f1;
        }
        .btn-github {
            background-color: #24292e;
            color: #ffffff;
            border: none;
        }
        .btn-github:hover {
            background-color: #1a1e22;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2 class="text-center mb-4">Login</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">${error}</div>
    </c:if>
    <c:if test="${not empty param.success}">
        <div class="alert alert-success" role="alert">${param.success}</div>
    </c:if>
    <form action="login" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>
    </form>
    <div class="social-login text-center mt-4">
        <p>Or login with:</p>
        <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile&redirect_uri=https://abc123.ngrok.io/GoogleLoginServlet&response_type=code&client_id=595131855100-pe7h7bnm3ukanad9uu8027st616rb6ei.apps.googleusercontent.com&approval_prompt=force" class="btn btn-google w-100 mb-2">
            <i class="fab fa-google"></i> Sign in with Google
        </a>
        <a href="https://github.com/login/oauth/authorize?client_id=Ov23li5L7N0QU8WL62FR&redirect_uri=https://abc123.ngrok.io/GitHubLoginServlet&scope=user:email" class="btn btn-github w-100">
            <i class="fab fa-github"></i> Sign in with GitHub
        </a>
    </div>
    <p class="text-center mt-3">
        Don't have an account? <a href="register.jsp">Register</a>
    </p>
    <p class="text-center mt-3">
        Forget your password? <a href="forgetpassword.jsp">Forget Password</a>
    </p>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>