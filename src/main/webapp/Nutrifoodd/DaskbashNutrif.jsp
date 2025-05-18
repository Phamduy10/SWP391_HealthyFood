<%-- 
    Document   : DaskbashNutrif
    Created on : May 18, 2025, 5:02:44 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/CSS/style.css">
</head>
<body>
    <div class="sidebar" id="sidebar">
        <div class="toggle-btn" onclick="toggleSidebar()">≡</div>
        <h2 class="sidebar-text">Admin Panel</h2>
        <ul>
            <li onclick="toggleSubmenu(this)">
                <span class="sidebar-text">Account</span>
                <ul class="submenu">
                    <li>Profile</li>
                    <li>Settings</li>
                </ul>
            </li>
            <li onclick="toggleSubmenu(this)">
                <span class="sidebar-text">Blog</span>
                <ul class="submenu">
                    <li>New Post</li>
                    <li>Manage Posts</li>
                </ul>
            </li>
            <li onclick="toggleSubmenu(this)">
                <span class="sidebar-text">Food</span>
                <ul class="submenu">
                    <li>Recipes</li>
                    <li>Reviews</li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="main-content">
        <h1>Welcome, Blogger!</h1>
        <p>This is your dashboard.</p>
    </div>

    <script>
        function toggleSubmenu(element) {
            element.classList.toggle("active");
        }

        function toggleSidebar() {
            const sidebar = document.getElementById("sidebar");
            sidebar.classList.toggle("collapsed");
        }
    </script>
</body>
</html>

