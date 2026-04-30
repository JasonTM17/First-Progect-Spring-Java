<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="la-topbar">
    <a class="la-brand" href="/admin">
        <span class="la-brand__mark"><i class="bi bi-laptop"></i></span>
        <span>Laptopshop</span>
    </a>

    <button class="la-sidebar-toggle" id="adminSidebarToggle" aria-label="Toggle sidebar">
        <i class="bi bi-list"></i>
    </button>

    <form class="la-topbar__search" action="/admin/product" method="get" role="search">
        <i class="bi bi-search"></i>
        <input type="search" name="q" placeholder="Tìm nhanh sản phẩm..." aria-label="Tìm nhanh sản phẩm trong admin" />
        <button type="submit" aria-label="Tìm kiếm"><i class="bi bi-arrow-right"></i></button>
    </form>

    <div class="la-topbar__actions">
        <button type="button" class="la-sidebar-toggle" aria-label="Thông báo" data-dd>
            <i class="bi bi-bell"></i>
            <span style="position:absolute; top:4px; right:4px; width:8px; height:8px; background: var(--danger-500); border-radius:50%; border: 2px solid var(--surface);"></span>
        </button>
        <div data-dd>
            <button type="button" class="la-userpill" data-dd-toggle>
                <img class="la-userpill__avatar" src="/images/avatar/default.png"
                     onerror="this.onerror=null;this.src='data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 40 40%22><rect fill=%22%23d70018%22 width=%2240%22 height=%2240%22 rx=%228%22/><text x=%2220%22 y=%2226%22 font-size=%2218%22 text-anchor=%22middle%22 fill=%22white%22 font-family=%22sans-serif%22>A</text></svg>';" alt="" />
                <span class="la-userpill__name d-none d-md-inline">
                    <c:out value="${pageContext.request.userPrincipal.name}" default="Admin" />
                </span>
                <i class="bi bi-chevron-down" style="font-size: 12px; color: var(--text-muted);"></i>
            </button>
            <div class="ui-dropdown" role="menu" style="min-width: 220px;">
                <a class="ui-dropdown__item" href="/admin/account"><i class="bi bi-person"></i> Quản lý tài khoản</a>
                <a class="ui-dropdown__item" href="/admin/account"><i class="bi bi-shield-lock"></i> Đổi mật khẩu</a>
                <a class="ui-dropdown__item" href="/" target="_blank"><i class="bi bi-box-arrow-up-right"></i> Xem site</a>
                <div class="ui-dropdown__divider"></div>
                <form method="post" action="/logout" style="margin: 0;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="ui-dropdown__item" style="width:100%; border:0; background:transparent; text-align:left; color: var(--danger-600);">
                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                    </button>
                </form>
            </div>
        </div>
    </div>
</header>
