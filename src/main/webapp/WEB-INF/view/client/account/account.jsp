<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Quản lý tài khoản - Laptopshop</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client">
    <jsp:include page="../layout/header.jsp" />

    <main>
        <section style="padding: var(--space-8) 0 var(--space-4); background: var(--bg-muted); border-bottom: 1px solid var(--border);">
            <div class="ui-container">
                <nav aria-label="breadcrumb">
                    <ol class="ui-breadcrumb">
                        <li><a href="/">Trang chủ</a></li>
                        <li class="active">Quản lý tài khoản</li>
                    </ol>
                </nav>
                <h1 class="ui-section-head__title" style="margin: 0;">Tài khoản của tôi</h1>
                <p class="ui-muted" style="margin-top: 4px;">Quản lý thông tin cá nhân, bảo mật và địa chỉ giao hàng</p>
            </div>
        </section>

        <section style="padding: var(--space-6) 0 var(--space-12);">
            <div class="ui-container">
                <div class="row g-4">
                    <!-- Left: profile card + nav -->
                    <aside class="col-lg-4">
                        <div class="ui-card" style="text-align: center; padding: var(--space-6);">
                            <div style="position: relative; width: 120px; height: 120px; border-radius: 50%; margin: 0 auto var(--space-4); background: linear-gradient(135deg, var(--brand-500), var(--brand-700)); display: flex; align-items: center; justify-content: center; color: #fff; font-size: 3rem; font-weight: 700; box-shadow: var(--shadow-md); overflow: hidden;" data-avatar>
                                <img id="avatarPreview" src="" alt="" style="display:none; width: 100%; height: 100%; object-fit: cover;" />
                                <span id="avatarInitial">
                                    <c:out value="${pageContext.request.userPrincipal.name.substring(0,1).toUpperCase()}" default="U" />
                                </span>
                            </div>
                            <h2 style="font-size: 1.125rem; font-weight: 700; margin: 0 0 4px;">
                                <c:out value="${pageContext.request.userPrincipal.name}" />
                            </h2>
                            <p style="color: var(--text-muted); font-size: 0.875rem; margin: 0 0 var(--space-4);">
                                <i class="bi bi-patch-check" style="color: var(--success-600);"></i>
                                Thành viên Laptopshop
                            </p>
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-2); text-align: center;">
                                <div style="padding: var(--space-3); background: var(--bg-muted); border-radius: var(--radius);">
                                    <div style="font-weight: 700; font-size: 1.25rem; color: var(--brand-700);">0</div>
                                    <div style="font-size: 0.75rem; color: var(--text-muted);">Đơn hàng</div>
                                </div>
                                <div style="padding: var(--space-3); background: var(--bg-muted); border-radius: var(--radius);">
                                    <div style="font-weight: 700; font-size: 1.25rem; color: var(--accent-600);">0</div>
                                    <div style="font-size: 0.75rem; color: var(--text-muted);">Điểm thưởng</div>
                                </div>
                            </div>
                        </div>

                        <nav class="ui-card" style="margin-top: var(--space-4); padding: var(--space-2); display: flex; flex-direction: column; gap: 2px;">
                            <a href="#tab-info" data-account-tab="info" class="ls-acc-tab is-active">
                                <i class="bi bi-person"></i> Thông tin tài khoản
                            </a>
                            <a href="#tab-password" data-account-tab="password" class="ls-acc-tab">
                                <i class="bi bi-shield-lock"></i> Đổi mật khẩu
                            </a>
                            <a href="#tab-address" data-account-tab="address" class="ls-acc-tab">
                                <i class="bi bi-geo-alt"></i> Địa chỉ giao hàng
                            </a>
                            <a href="/order-history" class="ls-acc-tab">
                                <i class="bi bi-receipt"></i> Lịch sử đơn hàng
                            </a>
                            <form action="/logout" method="post" style="margin: 0;">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button type="submit" class="ls-acc-tab" style="width: 100%; border: 0; background: transparent; text-align: left; color: var(--danger-600);">
                                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                                </button>
                            </form>
                        </nav>
                    </aside>

                    <!-- Right: content -->
                    <div class="col-lg-8">
                        <c:if test="${not empty error}">
                            <div class="ui-alert ui-alert--danger" style="margin-bottom: var(--space-4);">
                                <i class="bi bi-exclamation-triangle"></i>
                                <div>${error}</div>
                            </div>
                        </c:if>
                        <c:if test="${not empty success}">
                            <div class="ui-alert ui-alert--success" style="margin-bottom: var(--space-4);">
                                <i class="bi bi-check-circle"></i>
                                <div>${success}</div>
                            </div>
                        </c:if>

                        <!-- Tab: Info -->
                        <div class="ui-card ls-acc-panel is-active" id="tab-info" style="padding: var(--space-6);">
                            <h3 style="font-size: 1.25rem; font-weight: 700; margin: 0 0 var(--space-4);">Thông tin tài khoản</h3>
                            <form:form method="post" action="/account/profile" modelAttribute="profileDTO">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" value="${pageContext.request.userPrincipal.name}" readonly />
                                        <p class="ui-help">Email dùng để đăng nhập nên không chỉnh sửa trực tiếp tại đây.</p>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Họ và tên</label>
                                        <form:input type="text" class="form-control" path="fullName" placeholder="Nguyễn Văn A" required="true" />
                                        <form:errors path="fullName" cssClass="text-danger small" />
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Số điện thoại</label>
                                        <form:input type="tel" class="form-control" path="phone" placeholder="0912345678" />
                                        <form:errors path="phone" cssClass="text-danger small" />
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Địa chỉ giao hàng mặc định</label>
                                        <form:input type="text" class="form-control" path="address" placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành phố" />
                                        <form:errors path="address" cssClass="text-danger small" />
                                    </div>
                                </div>
                                <div style="margin-top: var(--space-4); padding-top: var(--space-4); border-top: 1px solid var(--border); display: flex; justify-content: flex-end; gap: var(--space-2);">
                                    <button type="reset" class="ui-btn ui-btn--secondary">Huỷ</button>
                                    <button type="submit" class="ui-btn">
                                        <i class="bi bi-check2"></i> Lưu thay đổi
                                    </button>
                                </div>
                            </form:form>
                        </div>

                        <!-- Tab: Password -->
                        <div class="ui-card ls-acc-panel" id="tab-password" style="padding: var(--space-6);">
                            <h3 style="font-size: 1.25rem; font-weight: 700; margin: 0 0 var(--space-4);">Đổi mật khẩu</h3>

                            <form:form method="post" action="/account/change-password" modelAttribute="changePasswordDTO">
                                <div class="row g-3">
                                    <div class="col-12">
                                        <label class="form-label">Email</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                            <input type="text" class="form-control" value="${pageContext.request.userPrincipal.name}" readonly />
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Mật khẩu hiện tại</label>
                                        <div class="input-group" data-password>
                                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                            <form:password path="oldPassword" class="form-control" placeholder="Nhập mật khẩu hiện tại" required="true" />
                                            <button type="button" class="btn btn-outline-secondary" data-password-toggle aria-label="Hiện/ẩn mật khẩu">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Mật khẩu mới</label>
                                        <div class="input-group" data-password>
                                            <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                                            <form:password path="newPassword" class="form-control" placeholder="Tối thiểu 6 ký tự" required="true" />
                                            <button type="button" class="btn btn-outline-secondary" data-password-toggle aria-label="Hiện/ẩn mật khẩu">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                        </div>
                                        <small class="ui-help"><i class="bi bi-info-circle"></i> Mật khẩu nên chứa chữ hoa, chữ thường và số để bảo mật tốt hơn.</small>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Xác nhận mật khẩu mới</label>
                                        <div class="input-group" data-password>
                                            <span class="input-group-text"><i class="bi bi-check2-circle"></i></span>
                                            <form:password path="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required="true" />
                                            <button type="button" class="btn btn-outline-secondary" data-password-toggle aria-label="Hiện/ẩn mật khẩu">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: var(--space-5); padding-top: var(--space-4); border-top: 1px solid var(--border); display: flex; justify-content: flex-end; gap: var(--space-2);">
                                    <button type="reset" class="ui-btn ui-btn--secondary">Huỷ</button>
                                    <button type="submit" class="ui-btn">
                                        <i class="bi bi-check2"></i> Cập nhật mật khẩu
                                    </button>
                                </div>
                            </form:form>
                        </div>

                        <!-- Tab: Address -->
                        <div class="ui-card ls-acc-panel" id="tab-address" style="padding: var(--space-6);">
                            <h3 style="font-size: 1.25rem; font-weight: 700; margin: 0 0 var(--space-4);">Địa chỉ giao hàng</h3>
                            <div style="background: var(--bg-muted); border: 1px solid var(--border); border-radius: var(--radius); padding: var(--space-5);">
                                <div class="ui-row" style="align-items: flex-start;">
                                    <div class="ui-iconbtn ui-iconbtn--primary"><i class="bi bi-geo-alt"></i></div>
                                    <div>
                                        <div style="font-weight: 700; margin-bottom: 4px;">Địa chỉ mặc định</div>
                                        <p style="margin: 0; color: var(--text-muted);">
                                            <c:choose>
                                                <c:when test="${not empty user.address}">
                                                    <c:out value="${user.address}" />
                                                </c:when>
                                                <c:otherwise>Bạn chưa thêm địa chỉ giao hàng mặc định.</c:otherwise>
                                            </c:choose>
                                        </p>
                                        <a href="#tab-info" class="ui-btn ui-btn--secondary" style="margin-top: var(--space-3);"
                                           onclick="document.querySelector('[data-account-tab=&quot;info&quot;]').click();">
                                            <i class="bi bi-pencil"></i> Cập nhật trong thông tin tài khoản
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />

    <script>
        (function () {
            var tabs = document.querySelectorAll('[data-account-tab]');
            var panels = document.querySelectorAll('.ls-acc-panel');
            tabs.forEach(function (tab) {
                tab.addEventListener('click', function (e) {
                    e.preventDefault();
                    var target = tab.getAttribute('data-account-tab');
                    tabs.forEach(function (t) { t.classList.remove('is-active'); });
                    panels.forEach(function (p) { p.classList.remove('is-active'); });
                    tab.classList.add('is-active');
                    var panel = document.getElementById('tab-' + target);
                    if (panel) panel.classList.add('is-active');
                });
            });

            // Open tab by hash on load
            var hash = (location.hash || '').replace('#tab-', '');
            if (hash) {
                var tab = document.querySelector('[data-account-tab="' + hash + '"]');
                if (tab) tab.click();
            }
        })();
    </script>
</body>

</html>
