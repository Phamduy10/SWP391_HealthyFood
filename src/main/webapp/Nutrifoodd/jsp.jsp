<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
        }

        #sidebar {
            width: 250px;
            background-color: #f8f9fa;
            border-right: 1px solid #dee2e6;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: margin-left 0.3s ease;
        }

        #sidebar.collapsed {
            margin-left: -250px;
        }

        #sidebar-toggle-btn {
            position: absolute;
            top: 10px;
            left: 10px;
            cursor: pointer;
            z-index: 100;
        }

        #main-content {
            flex-grow: 1;
            padding: 20px;
            transition: margin-left 0.3s ease;
        }

        #main-content.sidebar-collapsed {
            margin-left: 0;
        }

        .navbar-nav {
            flex-grow: 1;
            align-items: stretch;
        }

        .nav-item {
            width: 100%;
        }

        .nav-link {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #dee2e6;
        }

        .nav-link.active {
            background-color: #007bff;
            color: white;
        }

        #total-box {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .pagination .page-link {
            cursor: pointer;
        }
    </style>
</head>
<body>

<button id="sidebar-toggle-btn" class="btn btn-outline-secondary">Ẩn/Hiện Sidebar</button>

<div id="sidebar">
    <img src="logo.png" alt="Logo" class="mb-3" style="max-width: 150px;">
    <nav class="navbar bg-light flex-column">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link active" href="#" data-content="account">Account</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" data-content="food">Food</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" data-content="blog">Blog</a>
            </li>
        </ul>
    </nav>
</div>

<div id="main-content">
    <h2 id="content-title">Account</h2>

    <div id="total-box">
        <div>Tổng: <span id="total-items">0</span></div>
        <div class="d-flex align-items-center">
            <input type="text" class="form-control form-control-sm me-2" id="filter-input" placeholder="Tìm kiếm theo tên">
            <button class="btn btn-primary btn-sm" id="filter-button">Lọc</button>
        </div>
    </div>

    <button id="add-new-button" class="btn btn-success mb-3">Thêm Mới</button>

    <div id="item-list-container">
        <c:if test="${not empty accountList}">
            <c:forEach var="item" items="${accountList}" varStatus="loop">
                <div class="card mb-2">
                    <div class="card-body">${item.name} - Account ${loop.index + 1}</div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${not empty foodList}">
            <c:forEach var="item" items="${foodList}" varStatus="loop">
                <div class="card mb-2">
                    <div class="card-body">${item.name} - Food ${loop.index + 1}</div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${not empty blogList}">
            <c:forEach var="item" items="${blogList}" varStatus="loop">
                <div class="card mb-2">
                    <div class="card-body">${item.title} - Blog ${loop.index + 1}</div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty accountList && empty foodList && empty blogList}">
            <p>Không có dữ liệu.</p>
        </c:if>
    </div>

    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled"><a class="page-link" href="#">Trước</a></li>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}"><a class="page-link" href="?page=${i}">${i}</a></li>
            </c:forEach>
            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}"><a class="page-link" href="#">Sau</a></li>
        </ul>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const sidebar = document.getElementById('sidebar');
    const mainContent = document.getElementById('main-content');
    const sidebarToggleBtn = document.getElementById('sidebar-toggle-btn');
    const contentTitle = document.getElementById('content-title');
    const totalItemsSpan = document.getElementById('total-items');
    const addNewButton = document.getElementById('add-new-button');
    const itemListContainer = document.getElementById('item-list-container');
    const filterButton = document.getElementById('filter-button');
    const filterInput = document.getElementById('filter-input');
    const navLinks = document.querySelectorAll('#sidebar .nav-link');
    const pagination = document.querySelector('.pagination');

    sidebarToggleBtn.addEventListener('click', () => {
        sidebar.classList.toggle('collapsed');
        mainContent.classList.toggle('sidebar-collapsed');
    });

    navLinks.forEach(link => {
        link.addEventListener('click', (event) => {
            event.preventDefault();
            navLinks.forEach(nl => nl.classList.remove('active'));
            link.classList.add('active');
            const content = link.getAttribute('data-content');
            contentTitle.textContent = content.charAt(0).toUpperCase() + content.slice(1);
            addNewButton.textContent = `Thêm Mới ${content.charAt(0).toUpperCase() + content.slice(1)}`;

            // Cập nhật tổng số (ví dụ: bạn có thể gọi một hàm để lấy tổng số thực tế từ dữ liệu)
            totalItemsSpan.textContent = getTotalItems(content);

            // Gọi hàm để tải dữ liệu cho nội dung tương ứng (ví dụ: loadContent(content, 1));
            loadContent(content, 1); // Mặc định tải trang 1 khi chuyển mục

            // Cập nhật đường dẫn nút "Thêm Mới" (tùy thuộc vào ứng dụng của bạn)
            addNewButton.onclick = () => {
                window.location.href = `/admin/add-${content}`; // Ví dụ đường dẫn
            };
        });
    });

    filterButton.addEventListener('click', () => {
        const searchTerm = filterInput.value;
        const activeContent = document.querySelector('#sidebar .nav-link.active').getAttribute('data-content');
        // Gọi hàm để lọc dữ liệu (ví dụ: filterContent(activeContent, searchTerm));
        filterContent(activeContent, searchTerm);
    });

    function getTotalItems(contentType) {
        // Hàm này nên gọi API hoặc lấy dữ liệu từ server để trả về tổng số mục thực tế
        // Dưới đây chỉ là giá trị mẫu
        if (contentType === 'food') return ${totalFood}; // Giá trị từ JSTL
        if (contentType === 'blog') return ${totalBlog}; // Giá trị từ JSTL
        return ${totalAccount}; // Giá trị từ JSTL
    }

    function loadContent(contentType, page) {
        // Hàm này nên gọi API để tải dữ liệu cho contentType và trang cụ thể
        // Sau đó cập nhật itemListContainer và pagination
        itemListContainer.innerHTML = `<p>Đang tải ${contentType} trang ${page}...</p>`;
        // Ví dụ về tạo pagination (cần điều chỉnh dựa trên tổng số trang thực tế)
        updatePagination(contentType, ${totalPages}, page);
    }

    function filterContent(contentType, searchTerm) {
        // Hàm này nên gọi API để lọc dữ liệu dựa trên searchTerm và contentType
        itemListContainer.innerHTML = `<p>Đang lọc ${contentType} với từ khóa: ${searchTerm}...</p>`;
        // Sau khi lọc xong, có thể cần cập nhật lại pagination
        updatePagination(contentType, 1, 1); // Ví dụ: sau khi lọc có thể chỉ có 1 trang
    }

    function updatePagination(contentType, totalPages, currentPage) {
        pagination.innerHTML = '';
        const prevLi = document.createElement('li');
        prevLi.className = `page-item ${currentPage == 1 ? 'disabled' : ''}`;
        const prevLink = document.createElement('a');
        prevLink.className = 'page-link';
        prevLink.href = '#';
        prevLink.textContent = 'Trước';
        prevLi.appendChild(prevLink);
        pagination.appendChild(prevLi);

        for (let i = 1; i <= totalPages; i++) {
            const pageLi = document.createElement('li');
            pageLi.className = `page-item ${currentPage == i ? 'active' : ''}`;
            const pageLink = document.createElement('a');
            pageLink.className = 'page-link';
            pageLink.href = `?page=${i}&content=${contentType}`; // Điều chỉnh URL nếu cần
            pageLink.textContent = i;
            pageLink.addEventListener('click', (e) => {
                e.preventDefault();
                loadContent(contentType, i);
                // Cập nhật trạng thái active của nút trang
                document.querySelectorAll('.pagination .page-item').forEach(item => item.classList.remove('active'));
                pageLi.classList.add('active');
            });
            pageLi.appendChild(pageLink);
            pagination.appendChild(pageLi);
        }

        const nextLi = document.createElement('li');
        nextLi.className = `page-item ${currentPage == totalPages ? 'disabled' : ''}`;
        const nextLink = document.createElement('a');
        nextLink.className = 'page-link';
        nextLink.href = '#';
        nextLink.textContent = 'Sau';
        nextLi.appendChild(nextLink);
        pagination.appendChild(nextLi);
    }

    // Gọi lần đầu để hiển thị nội dung mặc định (Account)
    loadContent('account', ${currentPage == null ? 1 : currentPage});
    totalItemsSpan.textContent = getTotalItems('account');
</script>

</body>
</html>