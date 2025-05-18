<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .reset-password-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<div class="reset-password-container">
    <h2 class="text-center mb-4">Đặt Lại Mật Khẩu</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">${error}</div>
    </c:if>
    <c:if test="${not empty success}">
        <div class="alert alert-success" role="alert">${success}</div>
    </c:if>
    <form action="/ResetPasswordController" method="post">
        <div class="mb-3">
            <label for="code" class="form-label">Mã Xác Nhận</label>
            <input type="text" class="form-control" id="code" name="code" required>
        </div>
        <div class="mb-3">
            <label for="newPassword" class="form-label">Mật Khẩu Mới</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
        </div>
        <input type="hidden" name="email" value="${email}">
        <button type="submit" class="btn btn-primary w-100">Đặt Lại Mật Khẩu</button>
    </form>
    <p class="text-center mt-3">
        <a href="/ForgotPasswordController">Quay lại</a>
    </p>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>