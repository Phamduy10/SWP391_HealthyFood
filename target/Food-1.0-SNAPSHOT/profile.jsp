<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.servlet.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #e0e7ff, #f9e2af);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }
        .profile-container {
            max-width: 800px;
            margin: 40px auto;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }
        .profile-header {
            background: #4f46e5;
            color: white;
            padding: 2rem;
            text-align: center;
            border-bottom: 4px solid #4338ca;
        }
        .avatar-container {
            position: relative;
            margin: -80px auto 20px;
            width: 120px;
            height: 120px;
        }
        .avatar-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .avatar-input {
            display: none;
        }
        .avatar-label {
            position: absolute;
            bottom: 0;
            right: 0;
            background: #4f46e5;
            color: white;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background 0.3s;
        }
        .avatar-label:hover {
            background: #4338ca;
        }
        .profile-body {
            padding: 2rem;
        }
        .form-section {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
        }
        .form-label {
            font-weight: 500;
            color: #1f2937;
        }
        .form-control, .form-select {
            border-radius: 8px;
            border: 1px solid #d1d5db;
            padding: 0.75rem;
            transition: border-color 0.3s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }
        .btn-primary {
            background: #4f46e5;
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            transition: background 0.3s;
        }
        .btn-primary:hover {
            background: #4338ca;
        }
        .btn-danger {
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
        }
        .btn-warning {
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
        }
        .modal-content {
            border-radius: 12px;
            border: none;
            box-shadow: 0 4px 24px rgba(0, 0, 0, 0.2);
        }
        .modal-header {
            background: #4f46e5;
            color: white;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }
        .modal-title {
            font-weight: 600;
        }
        @media (max-width: 576px) {
            .profile-container {
                margin: 20px;
            }
            .profile-header {
                padding: 1.5rem;
            }
            .profile-body {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="profile-container">
    <div class="profile-header">
        <h2>User Profile</h2>
    </div>
    <div class="profile-body">
        <% User user = (User) session.getAttribute("user"); %>
        <form action="profile" method="post" enctype="multipart/form-data">
            <div class="avatar-container">
                <img src="<%= user.getImage() != null ? user.getImage() : "default-avatar.png" %>" alt="Avatar" class="avatar-img">
                <label for="image" class="avatar-label"><i class="fas fa-camera"></i></label>
                <input type="file" class="avatar-input" id="image" name="image" accept="image/*">
            </div>
            <div class="form-section">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" value="<%= user.getUsername() %>" disabled>
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() != null ? user.getName() : "" %>">
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
                </div>
            </div>
            <div class="form-section">
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
            </div>
            <div class="d-flex justify-content-between flex-wrap gap-2">
                <button type="submit" class="btn btn-primary">Update Profile</button>
                <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#changePasswordModal">Change Password</button>
                <a href="logout" class="btn btn-danger">Logout</a>
            </div>
        </form>
    </div>
</div>

<!-- Change Password Modal -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="changePassword" method="post">
                    <div class="mb-3">
                        <label for="oldPassword" class="form-label">Old Password</label>
                        <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
                    </div>
                    <div class="mb-3">
                        <label for="newPassword" class="form-label">New Password</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm New Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <div class="d-flex justify-content-end">
                        <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-warning">Change Password</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('image').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.querySelector('.avatar-img').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>