<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Cập nhật người dùng - Laptopshop Admin</title>
    <jsp:include page="/WEB-INF/view/fragments/head-admin.jsp" />
</head>

<body class="ls-admin">
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main class="la-main">
        <header class="la-page-head">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="ui-breadcrumb" style="margin-bottom: 4px;">
                        <li><a href="/admin">Admin</a></li>
                        <li><a href="/admin/user">Người dùng</a></li>
                        <li class="active">Cập nhật</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Cập nhật người dùng</h1>
                <p class="la-page-head__desc">Chỉnh sửa thông tin người dùng</p>
            </div>
            <div class="la-page-head__actions">
                <a href="/admin/user" class="ui-btn ui-btn--ghost">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <form:form method="post" action="/admin/user/update" modelAttribute="newUser">
            <form:input type="hidden" path="id" />
            <div class="la-form-layout">
                <div>
                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Thông tin tài khoản</h3>
                        <p class="la-form-section__desc">Email không thể thay đổi</p>
                        <label class="form-label">Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <form:input type="email" class="form-control" path="email" disabled="true" />
                        </div>
                    </section>

                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Thông tin cá nhân</h3>
                        <p class="la-form-section__desc">Cập nhật họ tên, số điện thoại và địa chỉ</p>
                        <div class="la-form-row">
                            <div>
                                <label class="form-label">Họ và tên</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <form:input type="text" class="form-control" path="fullName" />
                                </div>
                            </div>
                            <div>
                                <label class="form-label">Số điện thoại</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                    <form:input type="text" class="form-control" path="phone" />
                                </div>
                            </div>
                        </div>
                        <div style="margin-top: var(--space-3);">
                            <label class="form-label">Địa chỉ</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                                <form:input type="text" class="form-control" path="address" />
                            </div>
                        </div>
                    </section>
                </div>

                <div>
                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Trạng thái</h3>
                        <p class="la-form-section__desc">Thông tin cập nhật sẽ áp dụng ngay</p>
                        <div style="display: flex; align-items: center; gap: var(--space-3); padding: var(--space-3); background: var(--brand-50); border-radius: var(--radius); color: var(--brand-700); font-size: 0.875rem;">
                            <i class="bi bi-info-circle"></i>
                            <span>Chỉ thông tin cá nhân được cho phép chỉnh sửa.</span>
                        </div>
                    </section>
                </div>
            </div>

            <div class="la-form-actions">
                <a href="/admin/user" class="ui-btn ui-btn--secondary">Huỷ</a>
                <button type="submit" class="ui-btn">
                    <i class="bi bi-check2"></i> Lưu thay đổi
                </button>
            </div>
        </form:form>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
</body>

</html>
