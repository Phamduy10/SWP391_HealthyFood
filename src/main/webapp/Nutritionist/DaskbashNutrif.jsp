<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Nutritionist Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            display: flex;
            height: 100vh;
            background-color: #f4f4f4;
        }

        .sidebar {
            width: 250px;
            background-color: #e6f4ea;
            padding: 20px;
            display: flex;
            flex-direction: column;
        }

        .logo-section {
            text-align: center;
            margin-bottom: 20px;
        }

        .logo-section img {
            max-width: 100%;
            height: auto;
        }

        .nav-section {
            margin-top: auto;
            display: flex;
            flex-direction: column;
        }

        .sidebar h2 {
            color: #2e7d32;
            margin-bottom: 20px;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 10px 0;
            color: #333;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
        }

        .sidebar a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .sidebar a:hover, .sidebar a.active {
            color: #2e7d32;
            font-weight: bold;
        }

        .account-section {
            margin-top: 30px;
            display: flex;
            flex-direction: column;
        }

        .account-sub {
            margin-left: 10px;
            padding-top: 5px;
            display: flex;
            flex-direction: column;
        }

        .main-content {
            flex-grow: 1;
            padding: 30px;
            background-color: #f9f9f9;
            overflow-y: auto;
        }

        /* Card styles for dashboard home */
        .card-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-gap: 30px;
        }

        .card {
            background-color: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: 0.3s;
            text-decoration: none;
            color: #333;
        }

        .card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .card h3 {
            font-size: 20px;
            margin-bottom: 15px;
        }

        .card p {
            font-size: 28px;
            font-weight: bold;
            color: #2e7d32;
        }

        .card-img {
            width: 80px;
            height: 80px;
            object-fit: contain;
            margin: 10px auto;
            display: block;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <!-- Logo -->
        <div class="logo-section">
            <img src="https://cdn-icons-png.flaticon.com/512/1046/1046784.png" alt="Shop Logo" />
        </div>

        <!-- Navigation -->
        <div class="nav-section">
            <h2>Nutritionist Panel</h2>
            <a class="nav-link active" data-page="home"><i class="fas fa-home"></i> Home</a>
            <a class="nav-link" data-page="foods"><i class="fas fa-carrot"></i> Foods</a>
            <a class="nav-link" data-page="food-drafts"><i class="fas fa-hamburger"></i> Manage Food Drafts</a>
            <a class="nav-link" data-page="blogs"><i class="fas fa-pen-nib"></i> Manage Blogs</a>
            <a class="nav-link" data-page="notifications"><i class="fas fa-bell"></i> Notifications</a>

            <div class="account-section">
                <strong>Account</strong>
                <div class="account-sub">
                    <a href="/settings"><i class="fas fa-cog"></i> Settings</a>
                    <a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content" id="mainContent">
        <!-- Nội dung mặc định là Home dashboard -->
        <div id="homePage">
            <div class="card-container">
                <a href="#" class="card">
                    <h3><i class="fas fa-pen-nib"></i> Total Blogs</h3>
                    <img src="https://cdn-icons-png.flaticon.com/128/3135/3135715.png" alt="Blogs Image" class="card-img" />
                    <p id="blogCount">0</p>
                </a>
                <a href="#" class="card">
                    <h3><i class="fas fa-utensils"></i> Total Food Drafts</h3>
                    <img src="https://cdn-icons-png.flaticon.com/128/1046/1046784.png" alt="Food Drafts Image" class="card-img" />
                    <p id="draftCount">0</p>
                </a>
                <a href="#" class="card">
                    <h3><i class="fas fa-envelope-open-text"></i> Total Requests</h3>
                    <img src="https://cdn-icons-png.flaticon.com/128/561/561127.png" alt="Requests Image" class="card-img" />
                    <p id="requestCount">0</p>
                </a>
                <a href="#" class="card">
                    <h3><i class="fas fa-bell"></i> New Notifications</h3>
                    <img src="https://cdn-icons-png.flaticon.com/128/1827/1827392.png" alt="Notifications Image" class="card-img" />
                    <p id="notificationCount">0</p>
                </a>
            </div>
        </div>
    </div>

    <script>
        const nutritionistId = 123;

        const mockData = {
            123: {
                blogs: 8,
                drafts: 5,
                requests: 2,
                notifications: 4,
            },
        };

        function loadDashboardData(id) {
            const data = mockData[id] || { blogs: 0, drafts: 0, requests: 0, notifications: 0 };
            document.getElementById("blogCount").textContent = data.blogs;
            document.getElementById("draftCount").textContent = data.drafts;
            document.getElementById("requestCount").textContent = data.requests;
            document.getElementById("notificationCount").textContent = data.notifications;
        }

        loadDashboardData(nutritionistId);

        // Nội dung cho từng trang giả lập (bạn có thể thay bằng fetch hoặc server-side rendering)
        const pages = {
            home: `
                <div id="homePage">
                    <div class="card-container">
                        <a href="#" class="card">
                            <h3><i class="fas fa-pen-nib"></i> Total Blogs</h3>
                            <img src="https://cdn-icons-png.flaticon.com/128/3135/3135715.png" alt="Blogs Image" class="card-img" />
                            <p>${mockData[nutritionistId].blogs}</p>
                        </a>
                        <a href="#" class="card">
                            <h3><i class="fas fa-utensils"></i> Total Food Drafts</h3>
                            <img src="https://cdn-icons-png.flaticon.com/128/1046/1046784.png" alt="Food Drafts Image" class="card-img" />
                            <p>${mockData[nutritionistId].drafts}</p>
                        </a>
                        <a href="#" class="card">
                            <h3><i class="fas fa-envelope-open-text"></i> Total Requests</h3>
                            <img src="https://cdn-icons-png.flaticon.com/128/561/561127.png" alt="Requests Image" class="card-img" />
                            <p>${mockData[nutritionistId].requests}</p>
                        </a>
                        <a href="#" class="card">
                            <h3><i class="fas fa-bell"></i> New Notifications</h3>
                            <img src="https://cdn-icons-png.flaticon.com/128/1827/1827392.png" alt="Notifications Image" class="card-img" />
                            <p>${mockData[nutritionistId].notifications}</p>
                        </a>
                    </div>
                </div>
            `,
            foods: `<h2><i class="fas fa-carrot"></i> Foods Page</h2><p>Content for Foods goes here.</p>`,
            "food-drafts": `<h2><i class="fas fa-hamburger"></i> Manage Food Drafts</h2><p>Content for Food Drafts management.</p>`,
            blogs: `<h2><i class="fas fa-pen-nib"></i> Manage Blogs</h2><p>Content for Blogs management.</p>`,
            notifications: `<h2><i class="fas fa-bell"></i> Notifications</h2><p>Content for Notifications.</p>`,
        };

        // Hàm chuyển trang (thay đổi nội dung main-content)
        function navigateTo(page) {
            const mainContent = document.getElementById("mainContent");
            if (pages[page]) {
                mainContent.innerHTML = pages[page];
            } else {
                mainContent.innerHTML = `<p>Page not found.</p>`;
            }

            // Cập nhật active class sidebar
            document.querySelectorAll(".sidebar a.nav-link").forEach((el) => {
                el.classList.toggle("active", el.getAttribute("data-page") === page);
            });
        }

        // Gán sự kiện click cho các link sidebar
        document.querySelectorAll(".sidebar a.nav-link").forEach((link) => {
            link.addEventListener("click", (e) => {
                const page = e.currentTarget.getAttribute("data-page");
                navigateTo(page);
            });
        });

        // Mặc định đang ở Home rồi, nên không cần gọi navigateTo('home') nữa
    </script>
</body>
</html>
