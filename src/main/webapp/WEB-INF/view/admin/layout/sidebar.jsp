<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="__path" value="${requestScope['javax.servlet.forward.request_uri']}" />

<aside class="la-sidebar" id="adminSidebar">
    <div>
        <div class="la-sidebar__section">Tổng quan</div>
        <nav class="la-nav">
            <a class="la-nav__item ${__path eq '/admin' or __path eq '/admin/' ? 'is-active' : ''}" href="/admin">
                <span class="la-nav__icon"><i class="bi bi-speedometer2"></i></span>
                Dashboard
            </a>
        </nav>
    </div>

    <div>
        <div class="la-sidebar__section">Quản lý</div>
        <nav class="la-nav">
            <a class="la-nav__item ${fn:startsWith(__path, '/admin/user') ? 'is-active' : ''}" href="/admin/user">
                <span class="la-nav__icon"><i class="bi bi-people"></i></span>
                Người dùng
            </a>
            <a class="la-nav__item ${fn:startsWith(__path, '/admin/product') ? 'is-active' : ''}" href="/admin/product">
                <span class="la-nav__icon"><i class="bi bi-box-seam"></i></span>
                Sản phẩm
            </a>
            <a class="la-nav__item ${fn:startsWith(__path, '/admin/order') ? 'is-active' : ''}" href="/admin/order">
                <span class="la-nav__icon"><i class="bi bi-receipt"></i></span>
                Đơn hàng
            </a>
        </nav>
    </div>

    <div>
        <div class="la-sidebar__section">Hệ thống</div>
        <nav class="la-nav">
            <a class="la-nav__item ${fn:startsWith(__path, '/admin/account') ? 'is-active' : ''}" href="/admin/account">
                <span class="la-nav__icon"><i class="bi bi-person-gear"></i></span>
                Tài khoản của tôi
            </a>
            <a class="la-nav__item" href="/" target="_blank">
                <span class="la-nav__icon"><i class="bi bi-box-arrow-up-right"></i></span>
                Xem site khách
            </a>
        </nav>
    </div>

    <div class="la-sidebar__foot">
        <strong><c:out value="${pageContext.request.userPrincipal.name}" default="Admin" /></strong>
        <span>Quản trị viên</span>
    </div>
</aside>

<div class="la-sidebar-backdrop" id="adminSidebarBackdrop"></div>
