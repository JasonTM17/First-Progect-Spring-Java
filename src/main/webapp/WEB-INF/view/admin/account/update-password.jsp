<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Đổi mật khẩu - Laptopshop Admin</title>
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
                        <li class="active">Tài khoản</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Đổi mật khẩu</h1>
                <p class="la-page-head__desc">Cập nhật mật khẩu đăng nhập của tài khoản admin</p>
            </div>
        </header>

        <div class="la-form-layout">
            <div>
                <section class="la-form-section">
                    <h3 class="la-form-section__title">Thông tin mật khẩu</h3>
                    <p class="la-form-section__desc">Mật khẩu mới cần tối thiểu 6 ký tự</p>

                    <c:if test="${not empty error}">
                        <div class="ui-alert ui-alert--danger" style="margin-bottom: var(--space-4);">
                            <i class="bi bi-exclamation-circle"></i>
                            <span>${error}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="ui-alert ui-alert--success" style="margin-bottom: var(--space-4);">
                            <i class="bi bi-check-circle"></i>
                            <span>${success}</span>
                        </div>
                    </c:if>

                    <form:form method="post" action="/admin/account/change-password" modelAttribute="changePasswordDTO">
                        <div style="margin-bottom: var(--space-3);">
                            <label class="form-label">Mật khẩu hiện tại</label>
                            <div class="input-group" data-password>
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <form:password path="oldPassword" class="form-control" placeholder="Nhập mật khẩu hiện tại" />
                                <button type="button" class="btn btn-outline-secondary" data-password-toggle><i class="bi bi-eye"></i></button>
                            </div>
                        </div>
                        <div style="margin-bottom: var(--space-4);">
                            <label class="form-label">Mật khẩu mới</label>
                            <div class="input-group" data-password>
                                <span class="input-group-text"><i class="bi bi-key"></i></span>
                                <form:password path="newPassword" class="form-control" placeholder="Nhập mật khẩu mới" />
                                <button type="button" class="btn btn-outline-secondary" data-password-toggle><i class="bi bi-eye"></i></button>
                            </div>
                            <small class="ui-help">Tối thiểu 6 ký tự, nên gồm chữ hoa, chữ thường và số</small>
                        </div>
                        <div style="margin-bottom: var(--space-4);">
                            <label class="form-label">Xác nhận mật khẩu mới</label>
                            <div class="input-group" data-password>
                                <span class="input-group-text"><i class="bi bi-check2-circle"></i></span>
                                <form:password path="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" />
                                <button type="button" class="btn btn-outline-secondary" data-password-toggle><i class="bi bi-eye"></i></button>
                            </div>
                        </div>

                        <div style="display: flex; gap: var(--space-3);">
                            <button type="submit" class="ui-btn"><i class="bi bi-check2"></i> Cập nhật mật khẩu</button>
                            <a href="/admin" class="ui-btn ui-btn--ghost">Huỷ</a>
                        </div>
                    </form:form>
                </section>
            </div>

            <div>
                <section class="la-form-section">
                    <h3 class="la-form-section__title">Bảo mật</h3>
                    <ul class="ui-muted" style="padding-left: 20px; margin: 0; font-size: 0.875rem; line-height: 1.7;">
                        <li>Không dùng chung mật khẩu với tài khoản khác</li>
                        <li>Đổi mật khẩu định kỳ 3-6 tháng</li>
                        <li>Không chia sẻ mật khẩu qua email/tin nhắn</li>
                    </ul>
                </section>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
</body>

</html>
