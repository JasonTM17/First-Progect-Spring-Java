<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Đăng ký - Laptopshop</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client" style="padding-top: 0;">
    <div class="ls-auth ls-auth-shell">
        <!-- Left: illustration / branding -->
        <aside class="ls-auth__hero ls-auth-aside">
            <a href="/" class="ls-auth__brand">
                <i class="bi bi-laptop"></i>
                <span>Laptopshop</span>
            </a>
            <div class="ls-auth__copy">
                <h2>Tạo tài khoản mới</h2>
                <p>Tham gia cộng đồng Laptopshop để nhận nhiều ưu đãi và trải nghiệm mua sắm tuyệt vời.</p>
                <ul class="ls-auth__list">
                    <li><i class="bi bi-check"></i> Voucher chào mừng 500.000đ</li>
                    <li><i class="bi bi-check"></i> Freeship đơn đầu tiên</li>
                    <li><i class="bi bi-check"></i> Tích điểm không giới hạn</li>
                    <li><i class="bi bi-check"></i> Bảo mật thông tin tuyệt đối</li>
                </ul>
            </div>
            <div style="position: relative; font-size: 0.8125rem; opacity: 0.75;">
                &copy; 2026 Laptopshop. All rights reserved.
            </div>
        </aside>

        <!-- Right: form -->
        <section class="ls-auth__form ls-auth-form">
            <div class="ls-auth__form-inner ls-auth-card">
                <div style="margin-bottom: var(--space-5);">
                    <a href="/" style="font-size: 0.875rem; color: var(--text-muted); text-decoration: none;">
                        <i class="bi bi-arrow-left"></i> Về trang chủ
                    </a>
                </div>
                <h1>Đăng ký</h1>
                <p class="lead">Tạo tài khoản chỉ trong vài bước đơn giản</p>

                <form:form method="post" action="/register" modelAttribute="registerUser">
                    <c:set var="errorPassword"><form:errors path="confirmPassword" cssClass="invalid-feedback" /></c:set>
                    <c:set var="errorEmail"><form:errors path="email" cssClass="invalid-feedback" /></c:set>
                    <c:set var="errorFirstName"><form:errors path="firstName" cssClass="invalid-feedback" /></c:set>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Họ</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <form:input class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}"
                                    type="text" placeholder="Nguyễn" path="firstName" />
                                ${errorFirstName}
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Tên</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <form:input class="form-control" type="text" placeholder="Văn A" path="lastName" />
                            </div>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <form:input class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                    type="email" placeholder="your@email.com" path="email" />
                                ${errorEmail}
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Mật khẩu</label>
                            <div class="input-group" data-password>
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <form:input class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                    type="password" placeholder="Mật khẩu mạnh" path="password" />
                                <button type="button" class="btn btn-outline-secondary" data-password-toggle aria-label="Hiện/ẩn mật khẩu">
                                    <i class="bi bi-eye"></i>
                                </button>
                                ${errorPassword}
                            </div>
                            <small class="ui-help"><i class="bi bi-info-circle"></i> Tối thiểu 6 ký tự</small>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Xác nhận mật khẩu</label>
                            <div class="input-group" data-password>
                                <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                                <form:password class="form-control" placeholder="Nhập lại mật khẩu" path="confirmPassword" />
                                <button type="button" class="btn btn-outline-secondary" data-password-toggle aria-label="Hiện/ẩn mật khẩu">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="form-check" style="margin: var(--space-4) 0;">
                        <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                        <label class="form-check-label" for="agreeTerms" style="font-size: 0.875rem;">
                            Tôi đồng ý với
                    <a href="/about#dieu-khoan" style="color: var(--brand-600); font-weight: 500;">Điều khoản dịch vụ</a>
                    và
                    <a href="/about#bao-mat" style="color: var(--brand-600); font-weight: 500;">Chính sách bảo mật</a>
                        </label>
                    </div>

                    <button type="submit" class="ui-btn ui-btn--lg ui-btn--block">
                        <i class="bi bi-person-plus"></i>
                        Tạo tài khoản
                    </button>
                </form:form>

                <p style="text-align: center; margin-top: var(--space-6); color: var(--text-muted); font-size: 0.9375rem;">
                    Đã có tài khoản?
                    <a href="/login" style="color: var(--brand-600); font-weight: 600; text-decoration: none;">Đăng nhập</a>
                </p>
            </div>
        </section>
    </div>

    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
</body>

</html>
