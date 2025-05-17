<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
<div class="profile-container">
    <h2 class="text-center mb-4">User Profile</h2>
    <% User user = (User) session.getAttribute("user"); %>
        <form action="profile" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" value="<%= user.getUsername() %>" disabled>
            </div>
            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName" value="<%= user.getFullName() != null ? user.getFullName() : "" %>">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
            </div>
            <div class="mb-3">
                <label for="gender" class="form-label">Gender</label>
                <select class="form-select" id="gender" name="gender">
                    <option value="" <%= user.getGender() == null ? "selected" : "" %>>Select Gender</option>
                    <option value="Male" <%= "Male".equals(user.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(user.getGender()) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(user.getGender()) ? "selected" : "" %>>Other</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="birthDate" class="form-label">Birth Date</label>
                <input type="date" class="form-control" id="birthDate" name="birthDate" value="<%= user.getBirthDate() != null ? user.getBirthDate().toString() : "" %>">
            </div>
            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-primary">Update Profile</button>
                <a href="logout" class="btn btn-danger">Logout</a>
            </div>
        </form>
   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>