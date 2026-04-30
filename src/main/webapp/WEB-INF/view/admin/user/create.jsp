<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Thêm người dùng - Laptopshop Admin</title>
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
                        <li class="active">Thêm mới</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Thêm người dùng mới</h1>
                <p class="la-page-head__desc">Tạo tài khoản mới cho hệ thống</p>
            </div>
            <div class="la-page-head__actions">
                <a href="/admin/user" class="ui-btn ui-btn--ghost">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </header>

        <form:form method="post" action="/admin/user/create" modelAttribute="newUser" enctype="multipart/form-data" id="userForm">
            <div class="la-form-layout">
                <div>
                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Thông tin tài khoản</h3>
                        <p class="la-form-section__desc">Email và mật khẩu đăng nhập hệ thống</p>
                        <div class="la-form-row">
                            <div>
                                <c:set var="errorEmail"><form:errors path="email" cssClass="invalid-feedback" /></c:set>
                                <label class="form-label">Email <span style="color:var(--danger-500)">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                    <form:input type="email" class="form-control ${not empty errorEmail ? 'is-invalid':''}" path="email" placeholder="user@example.com" />
                                    ${errorEmail}
                                </div>
                            </div>
                            <div>
                                <c:set var="errorPassword"><form:errors path="password" cssClass="invalid-feedback" /></c:set>
                                <label class="form-label">Mật khẩu <span style="color:var(--danger-500)">*</span></label>
                                <div class="input-group" data-password>
                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                    <form:input type="password" class="form-control ${not empty errorPassword ? 'is-invalid':''}" path="password" placeholder="Tối thiểu 6 ký tự" />
                                    <button type="button" class="btn btn-outline-secondary" data-password-toggle><i class="bi bi-eye"></i></button>
                                    ${errorPassword}
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Thông tin cá nhân</h3>
                        <p class="la-form-section__desc">Họ tên, số điện thoại và địa chỉ</p>
                        <div class="la-form-row">
                            <div>
                                <c:set var="errorFullName"><form:errors path="fullName" cssClass="invalid-feedback" /></c:set>
                                <label class="form-label">Họ và tên <span style="color:var(--danger-500)">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <form:input type="text" class="form-control ${not empty errorFullName ? 'is-invalid' : ''}" path="fullName" placeholder="Nguyễn Văn A" />
                                    ${errorFullName}
                                </div>
                            </div>
                            <div>
                                <label class="form-label">Số điện thoại</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                    <form:input type="text" class="form-control" path="phone" placeholder="0912 345 678" />
                                </div>
                            </div>
                        </div>
                        <div style="margin-top: var(--space-3);">
                            <label class="form-label">Địa chỉ</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                                <form:input type="text" class="form-control" path="address" placeholder="Số nhà, đường, quận, tỉnh/thành" />
                            </div>
                        </div>
                    </section>
                </div>

                <div>
                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Phân quyền</h3>
                        <p class="la-form-section__desc">Vai trò của người dùng trong hệ thống</p>
                        <label class="form-label">Vai trò</label>
                        <form:select class="form-select" path="role.name">
                            <form:option value="USER">USER - Khách hàng</form:option>
                            <form:option value="ADMIN">ADMIN - Quản trị viên</form:option>
                        </form:select>
                    </section>

                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Ảnh đại diện</h3>
                        <p class="la-form-section__desc">PNG, JPG tối đa 5MB</p>
                        <div class="la-uploader">
                            <input type="file" id="avatarFile" accept=".png,.jpg,.jpeg" name="hoidanitFile" />
                            <div class="la-uploader__placeholder">
                                <div class="la-uploader__icon"><i class="bi bi-cloud-arrow-up"></i></div>
                                <p class="la-uploader__title">Kéo & thả ảnh hoặc nhấp để chọn</p>
                                <p class="la-uploader__desc">PNG / JPG / JPEG</p>
                            </div>
                            <img class="la-uploader__preview" id="avatarPreview" alt="" />
                        </div>
                    </section>
                </div>
            </div>

            <div class="la-form-actions">
                <a href="/admin/user" class="ui-btn ui-btn--secondary">Huỷ</a>
                <button type="submit" class="ui-btn">
                    <i class="bi bi-check2"></i> Tạo người dùng
                </button>
            </div>
        </form:form>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
</body>

</html>
