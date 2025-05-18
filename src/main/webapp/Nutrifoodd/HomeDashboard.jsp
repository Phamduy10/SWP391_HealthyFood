<%-- 
    Document   : HomeDashboard
    Created on : May 18, 2025, 10:11:42 PM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog Admin Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/CSS/style.css">
    <style>
        body {
            display: flex;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }

        .sidebar {
            width: 280px;
            background-color: #343a40; /* Màu nền tối cho sidebar */
            color: #fff;
            padding: 20px;
            border-right: 1px solid rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .sidebar-text {
            margin-top: 1rem;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            font-weight: bold;
            color: #fff;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            width: 100%;
        }

        .sidebar li {
            padding: 12px 16px;
            cursor: pointer;
            border-radius: 0.25rem;
            margin-bottom: 0.75rem;
            transition: background-color 0.3s ease;
        }

        .sidebar li:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .sidebar li.active {
            background-color: #007bff;
            color: #fff;
        }

        .sidebar .submenu {
            list-style: none;
            padding-left: 1.5rem;
            margin-top: 0.5rem;
            display: none;
        }

        .sidebar li.active > .submenu {
            display: block;
        }

        .sidebar .submenu li {
            padding: 10px 16px;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .main-content {
            flex-grow: 1;
            padding: 30px;
            background-color: #fff; /* Màu nền sáng cho nội dung chính */
        }

        .main-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #dee2e6;
        }

        .account-info {
            /* Thêm style cho thông tin tài khoản nếu cần */
            font-size: 1rem;
            color: #495057;
        }

        .total-items {
            font-size: 1rem;
            color: #495057;
            font-weight: bold;
        }

        .filter input[type="text"] {
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
        }

        .content-area {
            /* Khu vực chứa danh sách và form */
        }

        .item-list {
            margin-bottom: 30px;
        }

        .add-button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 0.25rem;
            cursor: pointer;
            margin-bottom: 15px;
            transition: background-color 0.3s ease;
        }

        .add-button:hover {
            background-color: #0056b3;
        }

        /* Style cho bảng (có thể tùy chỉnh thêm) */
        .table {
            margin-bottom: 20px;
        }

        .pagination {
            display: flex;
            justify-content: center;
        }

        .pagination .page-item .page-link {
            padding: 0.5rem 0.75rem;
            margin: 0 5px;
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
            color: #495057;
            text-decoration: none;
        }

        .pagination .page-item.active .page-link {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }

        .pagination .page-item .page-link:hover {
            background-color: #e9ecef;
        }

        /* Modal style (từ code trước) */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal {
            background-color: #fff;
            padding: 20px;
            border-radius: 0.25rem;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: 80%;
            max-width: 600px;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #dee2e6;
        }

        .modal-header h2 {
            margin: 0;
            font-size: 1.25rem;
        }

        .modal-header button {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #495057;
        }

        .form-group input[type="text"],
        .form-group textarea,
        .form-group input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 0.25rem;
            box-sizing: border-box;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-actions {
            text-align: right;
        }

        .form-actions button {
            padding: 10px 20px;
            border: none;
            border-radius: 0.25rem;
            cursor: pointer;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }

        .form-actions button.save {
            background-color: #28a745;
            color: white;
        }

        .form-actions button.save:hover {
            background-color: #1e7e34;
        }

        .form-actions button.cancel {
            background-color: #6c757d;
            color: white;
            margin-left: 10px;
        }

        .form-actions button.cancel:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2 class="sidebar-text">Admin Panel</h2>
        <ul>
            <li onclick="toggleSubmenu(this)">
                <span class="sidebar-text">Account</span>
                <ul class="submenu">
                    <li>Profile</li>
                    <li>Settings</li>
                </ul>
            </li>
            <li class="active" onclick="toggleSubmenu(this)">
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
        <header class="main-header">
            <div class="account-info">
                <span>Tài khoản</span>
            </div>
            <div class="total-items">
                Tổng: <span id="total-count"></span>
            </div>
            <div class="filter">
                <input type="text" id="filter-input" class="form-control form-control-sm" placeholder="Lọc theo tên...">
            </div>
        </header>

        <div class="content-area">
            <div id="blog-list" class="item-list active">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2>Danh sách Blog</h2>
                    <button class="add-button" id="openAddBlogModal">Thêm Blog</button>
                </div>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Ảnh</th>
                            <th>Tiêu đề</th>
                            <th>Ngày tạo</th>
                            <th>Trạng thái</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="blog-table-body">
                        </tbody>
                </table>
                <nav aria-label="Blog pagination">
                    <ul class="pagination" id="blog-pagination">
                        <li class="page-item disabled"><a class="page-link" href="#">Trước</a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">Sau</a></li>
                    </ul>
                </nav>
            </div>

            <div id="addBlogModal" class="modal-overlay" style="display: none;">
                <div class="modal">
                    <div class="modal-header">
                        <h2 class="modal-title">Thêm Blog Mới</h2>
                        <button type="button" class="btn-close" id="closeModalBtn" aria-label="Close">&times;</button>
                    </div>
                    <form id="addBlogForm">
                        <div class="mb-3">
                            <label for="image" class="form-label">Ảnh:</label>
                            <input type="file" class="form-control" id="image" name="image">
                        </div>
                        <div class="mb-3">
                            <label for="title" class="form-label">Tiêu đề:</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Nội dung:</label>
                            <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary save">Lưu</button>
                            <button type="button" class="btn btn-secondary cancel" id="cancelBtn">Hủy</button>
                        </div>
                    </form>
                </div>
            </div>

            <div id="food-list" class="item-list">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2>Danh sách Món Ăn/Sản phẩm</h2>
                    <button class="add-button" id="openAddFoodModal">Thêm Món Ăn/Sản phẩm</button>
                </div>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Ảnh</th>
                            <th>Tên</th>
                            <th>Giá</th>
                            <th>Trạng thái</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="food-table-body">
                        </tbody>
                </table>
                <nav aria-label="Food pagination">
                    <ul class="pagination" id="food-pagination">
                        <li class="page-item disabled"><a class="page-link" href="#">Trước</a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">Sau</a></li>
                    </ul>
                </nav>
            </div>

            <div id="order-list" class="item-list">
                <h2>Đơn Hàng</h2>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Mã Đơn Hàng</th>
                            <th>Khách Hàng</th>
                            <th>Ngày Đặt</th>
                            <th>Tổng Tiền</th>
                            <th>Trạng thái</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#12345</td>
                            <td>Nguyễn Văn A</td>
                            <td>2025-05-18</td>
                            <td>150.000 VNĐ</td>
                            <td>Đang xử lý</td>
                            <td><button class="btn btn-sm btn-info">Xem</button></td>
                        </tr>
                    </tbody>
                </table>
                <nav aria-label="Order pagination">
                    <ul class="pagination">
                        <li class="page-item disabled"><a class="page-link" href="#">Trước</a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">Sau</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const navItems = document.querySelectorAll('.sidebar li');
            const itemLists = document.querySelectorAll('.item-list');
            const totalCountSpan = document.querySelector('.total-items #total-count');
            const filterInput = document.querySelector('.filter input');
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.querySelector('.main-content');
            const modalOverlay = document.getElementById('addBlogModal');
            const closeModalBtn = document.getElementById('closeModalBtn');
            const cancelBtn = document.getElementById('cancelBtn');
            const openAddBlogModal = document.getElementById('openAddBlogModal');
            const openAddFoodModal = document.getElementById('openAddFoodModal');

            function hideAllContents() {
                itemLists.forEach(item => item.classList.remove('active'));
                navItems.forEach(item => item.classList.remove('active'));
                const submenus = document.querySelectorAll('.sidebar .submenu');
                submenus.forEach(submenu => submenu.style.display = 'none');
            }

            function toggleSubmenu(element) {
                const submenu = element.querySelector('.submenu');
                if (submenu) {
                    submenu.style.display = submenu.style.display === 'block' ? 'none' : 'block';
                }
                element.classList.toggle('active');
                // Ẩn các submenu khác khi một submenu được mở
                navItems.forEach(item => {
                    if (item !== element && item.classList.contains('active')) {
                        item.classList.remove('active');
                        const otherSubmenu = item.querySelector('.submenu');
                        if (otherSubmenu) {
                            otherSubmenu.style.display = 'none';
                        }
                    }
                });
            }

            navItems.forEach(item => {
                item.addEventListener('click', function() {
                    if (!this.querySelector('.submenu')) { // Nếu không có submenu thì mới chuyển nội dung
                        hideAllContents();
                        this.classListthis.classList.add('active');
                        const contentId = this.querySelector('span.sidebar-text').textContent.toLowerCase().replace(' ', '-');
                        const contentArea = document.getElementById(contentId + '-list');
                        if (contentArea) {
                            contentArea.classList.add('active');
                            // Cập nhật tổng số (ví dụ: dựa trên số lượng hàng trong bảng đang hiển thị)
                            const activeTableBody = contentArea.querySelector('tbody');
                            totalCountSpan.textContent = activeTableBody ? activeTableBody.rows.length : '0';
                        }
                    } else {
                        toggleSubmenu(this);
                    }
                });
            });

            // Mặc định hiển thị trang Blog khi tải
            const defaultActive = document.querySelector('.sidebar li.active');
            if (defaultActive && !defaultActive.querySelector('.submenu')) {
                defaultActive.click();
            } else if (defaultActive && defaultActive.querySelector('.submenu')) {
                const contentId = defaultActive.querySelector('span.sidebar-text').textContent.toLowerCase().replace(' ', '-');
                document.getElementById(contentId + '-list').classList.add('active');
                const activeTableBody = document.getElementById(contentId + '-list')?.querySelector('tbody');
                totalCountSpan.textContent = activeTableBody ? activeTableBody.rows.length : '0';
            }

            // Lắng nghe sự kiện input trên bộ lọc
            filterInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                const activeTableBody = document.querySelector('.item-list.active tbody');
                if (activeTableBody) {
                    const rows = activeTableBody.querySelectorAll('tr');
                    rows.forEach(row => {
                        const textContent = row.textContent.toLowerCase();
                        row.style.display = textContent.includes(searchTerm) ? '' : 'none';
                    });
                }
            });

            // Logic hiển thị/ẩn modal thêm blog
            if (openAddBlogModal) {
                openAddBlogModal.addEventListener('click', () => modalOverlay.style.display = 'flex');
            }

            if (closeModalBtn) {
                closeModalBtn.addEventListener('click', () => modalOverlay.style.display = 'none');
            }

            if (cancelBtn) {
                cancelBtn.addEventListener('click', () => modalOverlay.style.display = 'none');
            }

            window.addEventListener('click', (event) => {
                if (event.target === modalOverlay) {
                    modalOverlay.style.display = 'none';
                }
            });

            // Logic cho modal thêm food (tương tự modal blog)
            const addFoodModal = document.getElementById('addFoodModal');
            const closeFoodModalBtn = document.getElementById('closeFoodModalBtn');
            const cancelFoodBtn = document.getElementById('cancelFoodBtn');
            if (openAddFoodModal) {
                openAddFoodModal.addEventListener('click', () => {
                    if (addFoodModal) addFoodModal.style.display = 'flex';
                    else alert('Chưa có form thêm Food!');
                });
            }
            if (closeFoodModalBtn && addFoodModal) {
                closeFoodModalBtn.addEventListener('click', () => addFoodModal.style.display = 'none');
            }
            if (cancelFoodBtn && addFoodModal) {
                cancelFoodBtn.addEventListener('click', () => addFoodModal.style.display = 'none');
            }
            window.addEventListener('click', (event) => {
                if (addFoodModal && event.target === addFoodModal) {
                    addFoodModal.style.display = 'none';
                }
            });
        });

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.querySelector('.main-content');
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('sidebar-open');
        }
    </script>

    <div id="addFoodModal" class="modal-overlay" style="display: none;">
        <div class="modal">
            <div class="modal-header">
                <h2 class="modal-title">Thêm Món Ăn/Sản phẩm Mới</h2>
                <button type="button" class="btn-close" id="closeFoodModalBtn" aria-label="Close">&times;</button>
            </div>
            <form id="addFoodForm">
                <div class="mb-3">
                    <label for="foodImage" class="form-label">Ảnh:</label>
                    <input type="file" class="form-control" id="foodImage" name="foodImage">
                </div>
                <div class="mb-3">
                    <label for="foodName" class="form-label">Tên:</label>
                    <input type="text" class="form-control" id="foodName" name="foodName" required>
                </div>
                <div class="mb-3">
                    <label for="foodPrice" class="form-label">Giá:</label>
                    <input type="number" class="form-control" id="foodPrice" name="foodPrice" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary save">Lưu</button>
                    <button type="button" class="btn btn-secondary cancel" id="cancelFoodBtn">Hủy</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>