<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Thêm sản phẩm - Laptopshop Admin</title>
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
                        <li><a href="/admin/product">Sản phẩm</a></li>
                        <li class="active">Thêm mới</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Thêm sản phẩm</h1>
                <p class="la-page-head__desc">Tạo mới sản phẩm trên cửa hàng</p>
            </div>
            <div class="la-page-head__actions">
                <a href="/admin/product" class="ui-btn ui-btn--ghost"><i class="bi bi-arrow-left"></i> Quay lại</a>
            </div>
        </header>

        <form:form method="post" action="/admin/product/create" modelAttribute="newProduct" enctype="multipart/form-data">
            <c:set var="errorName"><form:errors path="name" cssClass="invalid-feedback" /></c:set>
            <c:set var="errorPrice"><form:errors path="price" cssClass="invalid-feedback" /></c:set>
            <c:set var="errorDetailDesc"><form:errors path="detailDesc" cssClass="invalid-feedback" /></c:set>
            <c:set var="errorShortDesc"><form:errors path="shortDesc" cssClass="invalid-feedback" /></c:set>
            <c:set var="errorQuantity"><form:errors path="quantity" cssClass="invalid-feedback" /></c:set>
            <c:set var="errorImage"><form:errors path="image" cssClass="invalid-feedback d-block" /></c:set>

            <div class="la-form-layout">
                <div>
                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Thông tin cơ bản</h3>
                        <p class="la-form-section__desc">Tên, mô tả và thông tin hiển thị cho sản phẩm</p>
                        <div style="margin-bottom: var(--space-3);">
                            <label class="form-label">Tên sản phẩm <span style="color:var(--danger-500)">*</span></label>
                            <form:input type="text" class="form-control ${not empty errorName ? 'is-invalid' : ''}" path="name" placeholder="MacBook Pro 16\" M3 Pro..." />
                            ${errorName}
                        </div>
                        <div style="margin-bottom: var(--space-3);">
                            <label class="form-label">Mô tả ngắn</label>
                            <form:input type="text" class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" path="shortDesc" placeholder="Hiển thị trên danh sách sản phẩm" />
                            ${errorShortDesc}
                        </div>
                        <div>
                            <label class="form-label">Mô tả chi tiết</label>
                            <form:textarea class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" path="detailDesc" rows="6" />
                            ${errorDetailDesc}
                        </div>
                    </section>

                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Giá & kho</h3>
                        <p class="la-form-section__desc">Giá bán và số lượng tồn kho</p>
                        <div class="la-form-row">
                            <div>
                                <label class="form-label">Giá bán <span style="color:var(--danger-500)">*</span></label>
                                <div class="input-group">
                                    <form:input type="number" step="any" class="form-control ${not empty errorPrice ? 'is-invalid' : ''}" path="price" placeholder="0" />
                                    <span class="input-group-text">₫</span>
                                </div>
                                ${errorPrice}
                            </div>
                            <div>
                                <label class="form-label">Số lượng <span style="color:var(--danger-500)">*</span></label>
                                <form:input type="number" class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}" path="quantity" placeholder="0" />
                                ${errorQuantity}
                            </div>
                        </div>
                    </section>
                </div>

                <div>
                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Phân loại</h3>
                        <p class="la-form-section__desc">Hãng sản xuất và mục đích sử dụng</p>
                        <div style="margin-bottom: var(--space-3);">
                            <label class="form-label">Hãng sản xuất</label>
                            <form:select class="form-select" path="factory">
                                <form:option value="APPLE">Apple (MacBook)</form:option>
                                <form:option value="ASUS">Asus</form:option>
                                <form:option value="LENOVO">Lenovo</form:option>
                                <form:option value="DELL">Dell</form:option>
                                <form:option value="LG">LG</form:option>
                                <form:option value="ACER">Acer</form:option>
                            </form:select>
                        </div>
                        <div>
                            <label class="form-label">Mục đích sử dụng</label>
                            <form:select class="form-select" path="target">
                                <form:option value="GAMING">Gaming</form:option>
                                <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng</form:option>
                                <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa</form:option>
                                <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                            </form:select>
                        </div>
                    </section>

                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Ảnh sản phẩm</h3>
                        <p class="la-form-section__desc">PNG, JPG, WEBP hoặc GIF tối đa 5MB</p>
                        <div class="la-uploader">
                            <input type="file" id="avatarFile" accept=".png,.jpg,.jpeg,.webp,.gif" name="hoidanitFile" />
                            <div class="la-uploader__placeholder">
                                <div class="la-uploader__icon"><i class="bi bi-image"></i></div>
                                <p class="la-uploader__title">Kéo & thả ảnh hoặc nhấp để chọn</p>
                                <p class="la-uploader__desc">PNG / JPG / JPEG / WEBP / GIF</p>
                            </div>
                            <img class="la-uploader__preview" id="avatarPreview" alt="" />
                        </div>
                        ${errorImage}
                    </section>
                </div>
            </div>

            <div class="la-form-actions">
                <a href="/admin/product" class="ui-btn ui-btn--secondary">Huỷ</a>
                <button type="submit" class="ui-btn">
                    <i class="bi bi-check2"></i> Tạo sản phẩm
                </button>
            </div>
        </form:form>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
</body>

</html>
