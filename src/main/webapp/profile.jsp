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
            background-color: #f0f2f5;
            min-height: 100vh;
        }
        .profile-container {
            max-width: 900px;
            margin: 40px auto;
        }
        .avatar-img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #fff;
        }
        .avatar-container {
            position: relative;
            display: inline-block;
        }
        .avatar-label {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: #0d6efd;
            color: white;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .avatar-input {
            display: none;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .btn-primary, .btn-warning, .btn-danger {
            border-radius: 8px;
            padding: 0.5rem 1.25rem;
        }
        .form-section {
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="profile-container">
    <div class="card">
        <div class="card-header bg-primary text-white text-center py-4">
            <h3 class="mb-0">User Profile</h3>
        </div>
        <div class="card-body p-4">
            <% User user = (User) session.getAttribute("user"); %>
            <% String success = request.getParameter("success"); %>
            <% String error = (String) request.getAttribute("error"); %>
            <% if (user == null) { %>
                <div class="alert alert-danger" role="alert">
                    User session not found. Please <a href="login.jsp" class="alert-link">log in</a>.
                </div>
            <% } else { %>
                <% if (success != null) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <%= success %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                <% if (error != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <% } %>
                <form action="profile" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-4 text-center form-section">
                            <div class="avatar-container">
                                <img src="<%= user.getImage() != null ? user.getImage() + "?t=" + System.currentTimeMillis() : "img/avar/default-avatar.png?t=" + System.currentTimeMillis() %>" alt="Avatar" class="avatar-img">
                                <label for="image" class="avatar-label"><i class="fas fa-camera"></i></label>
                                <input type="file" class="avatar-input" id="image" name="image" accept="image/*">
                            </div>
                        </div>
                        <div class="col-md-8 form-section">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" value="<%= user.getUsername() != null ? user.getUsername() : "" %>" disabled>
                            </div>
                            <div class="mb-3">
                                <label for="name" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() != null ? user.getName() : "" %>">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() != null ? user.getEmail() : "" %>" required>
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
                        </div>
                    </div>
                    <div class="d-flex justify-content-between flex-wrap gap-2 p-3">
                        <button type="submit" class="btn btn-primary">Update Profile</button>
                        <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#changePasswordModal">Change Password</button>
                        <a href="logout" class="btn btn-danger">Logout</a>
                    </div>
                </form>
            <% } %>
        </div>
    </div>
</div>

<!-- Change Password Modal -->
<div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
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
                    <div class="d-flex justify-content-end gap-2">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
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

    // Check if showChangePassword parameter is present
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('showChangePassword') === 'true') {
        const changePasswordModal = new bootstrap.Modal(document.getElementById('changePasswordModal'));
        changePasswordModal.show();
    }
</script>
</body>
</html>