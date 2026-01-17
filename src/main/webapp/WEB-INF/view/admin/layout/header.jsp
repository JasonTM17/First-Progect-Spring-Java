<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="/admin">Laptopshop</a>

            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>

            <!-- Welcome -->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3">
                <span style="color: white;">
                    Welcome,
                    <c:out value="${pageContext.request.userPrincipal.name}" />
                </span>
            </form>

            <!-- User Dropdown -->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user fa-fw"></i>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="navbarDropdown"
                        style="min-width: 300px;">

                        <!-- Avatar + Username -->
                        <li class="d-flex align-items-center flex-column">
                            <img src="/images/products/171078092373-asus-01.png"
                                style="width:150px;height:150px;border-radius:50%;object-fit:cover;" />
                            <div class="text-center my-3 fw-bold">
                                <c:out value="${pageContext.request.userPrincipal.name}" />
                            </div>
                        </li>

                        <li><a class="dropdown-item" href="#">Quản lý tài khoản</a></li>
                        <li><a class="dropdown-item" href="#">Lịch sử mua hàng</a></li>

                        <li>
                            <hr class="dropdown-divider">
                        </li>

                        <!-- Logout -->
                        <li>
                            <form method="post" action="/logout">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button class="dropdown-item" type="submit">
                                    Đăng xuất
                                </button>
                            </form>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>