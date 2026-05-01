<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Đăng nhập - Laptopshop</title>
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
                <h2>Chào mừng trở lại!</h2>
                <p>Đăng nhập để tiếp tục mua sắm những chiếc laptop chính hãng với giá tốt nhất thị trường.</p>
                <ul class="ls-auth__list">
                    <li><i class="bi bi-check"></i> Theo dõi đơn hàng dễ dàng</li>
                    <li><i class="bi bi-check"></i> Tích điểm đổi quà hấp dẫn</li>
                    <li><i class="bi bi-check"></i> Ưu đãi thành viên độc quyền</li>
                    <li><i class="bi bi-check"></i> Bảo hành & hỗ trợ 24/7</li>
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
                <h1>Đăng nhập</h1>
                <p class="lead">Nhập email và mật khẩu để tiếp tục</p>

                <c:if test="${param.error != null}">
                    <div class="ui-alert ui-alert--danger" style="margin-bottom: var(--space-4);">
                        <i class="bi bi-exclamation-triangle"></i>
                        <div>Email hoặc mật khẩu không chính xác. Vui lòng thử lại.</div>
                    </div>
                </c:if>
                <c:if test="${param.logout != null}">
                    <div class="ui-alert ui-alert--success" style="margin-bottom: var(--space-4);">
                        <i class="bi bi-check-circle"></i>
                        <div>Bạn đã đăng xuất thành công.</div>
                    </div>
                </c:if>
                <c:if test="${param.registerSuccess != null}">
                    <div class="ui-alert ui-alert--success" style="margin-bottom: var(--space-4);">
                        <i class="bi bi-check-circle"></i>
                        <div>Đăng ký thành công! Hãy đăng nhập bằng tài khoản vừa tạo.</div>
                    </div>
                </c:if>

                <form method="post" action="/login" autocomplete="on">
                    <div class="mb-3">
                        <label class="form-label" for="loginEmail">Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <input id="loginEmail" class="form-control" type="email" name="username"
                                placeholder="your@email.com" required autofocus />
                        </div>
                    </div>

                    <div class="mb-3">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <label class="form-label" for="loginPassword" style="margin: 0;">Mật khẩu</label>
                            <a href="/#lien-he" style="font-size: 0.8125rem; color: var(--brand-600); text-decoration: none; font-weight: 500;">Cần hỗ trợ?</a>
                        </div>
                        <div class="input-group" data-password>
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input id="loginPassword" class="form-control" type="password" name="password"
                                placeholder="Nhập mật khẩu" required />
                            <button type="button" class="btn btn-outline-secondary" data-password-toggle aria-label="Hiện/ẩn mật khẩu">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-check mb-4">
                        <input class="form-check-input" type="checkbox" name="remember-me" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                    </div>

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <button type="submit" class="ui-btn ui-btn--lg ui-btn--block">
                        <i class="bi bi-box-arrow-in-right"></i>
                        Đăng nhập
                    </button>
                </form>

                <p style="text-align: center; margin-top: var(--space-6); color: var(--text-muted); font-size: 0.9375rem;">
                    Chưa có tài khoản?
                    <a href="/register" style="color: var(--brand-600); font-weight: 600; text-decoration: none;">Đăng ký ngay</a>
                </p>
            </div>
        </section>
    </div>

    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
</body>

</html>
