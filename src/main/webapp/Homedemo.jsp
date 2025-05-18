<%-- 
    Document   : Homedemo
    Created on : May 18, 2025, 6:47:23 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Healthy Food Shop</title>
  <link rel="stylesheet" href="CSS/styleHome.css">
  <!-- Bootstrap 5 CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Font Awesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

 
</head>

<body>
  <!-- Navbar -->
  <nav class="navbar fixed-top navbar-expand-lg navbar-light shadow-sm">
    <div class="container">
      <!-- Toggle button -->
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarHealthyFood"
        aria-controls="navbarHealthyFood"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <i class="fas fa-bars"></i>
      </button>

      <!-- Brand -->
      <a class="navbar-brand" href="#">
          <img src="img/logo/logo.png" alt="Healthy Logo" style="width: 100px ; height: 100px" />
      </a>

      <!-- Collapsible content -->
      <div class="collapse navbar-collapse" id="navbarHealthyFood">
        <!-- Nav links -->
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" href="#">Trang chủ</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Sản phẩm</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Bài viết sức khỏe</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Liên hệ</a>
          </li>
        </ul>
      </div>

      <!-- Right elements -->
      <div class="d-flex align-items-center">
        <a class="nav-link me-3" href="#">
          <i class="fas fa-shopping-cart"></i>
          <span class="badge rounded-pill badge-notification bg-success">2</span>
        </a>
        <a class="nav-link me-2" href="#"><i class="fab fa-facebook-f"></i></a>
        <a class="nav-link me-2" href="#"><i class="fab fa-instagram"></i></a>
        <a class="nav-link me-2" href="https://github.com/Phamduy10/SWP391_HealthyFood" target="_blank">
        <i class="fab fa-github"></i>
        </a>
        <a class="btn btn-success btn-sm" href="#">Đăng nhập</a>
      </div>
    </div>
  </nav>

  <!-- Dummy Content -->
  <div class="container mt-5">

  </div><!--    <h1>Chào mừng đến với Healthy Food!</h1>
    <p>Trang web bán thực phẩm tốt cho sức khỏe, giao hàng nhanh chóng và uy tín.</p>-->

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
