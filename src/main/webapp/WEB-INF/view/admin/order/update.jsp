<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Cập nhật đơn hàng - Laptopshop Admin</title>
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
                        <li><a href="/admin/order">Đơn hàng</a></li>
                        <li class="active">Cập nhật</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Cập nhật đơn hàng #${newOrder.id}</h1>
                <p class="la-page-head__desc">Thay đổi trạng thái xử lý đơn hàng</p>
            </div>
            <div class="la-page-head__actions">
                <a href="/admin/order" class="ui-btn ui-btn--ghost"><i class="bi bi-arrow-left"></i> Quay lại</a>
            </div>
        </header>

        <c:if test="${not empty error}">
            <div class="ui-alert ui-alert--danger" style="margin-bottom: var(--space-4);">
                <i class="bi bi-exclamation-triangle"></i>
                <div>${error}</div>
            </div>
        </c:if>

        <form:form method="post" action="/admin/order/update" modelAttribute="newOrder">
            <form:input type="hidden" path="id" />
            <div class="la-form-layout">
                <div>
                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Thông tin đơn hàng</h3>
                        <div class="la-form-row">
                            <div>
                                <label class="form-label">Khách hàng</label>
                                <input type="text" class="form-control" value="${newOrder.user.fullName}" readonly />
                            </div>
                            <div>
                                <label class="form-label">Tổng tiền</label>
                                <fmt:formatNumber value="${newOrder.totalPrice}" type="number" groupingUsed="true" var="formattedTotalPrice" />
                                <input type="text" class="form-control" value="${formattedTotalPrice} ₫" readonly />
                            </div>
                        </div>
                    </section>

                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Trạng thái</h3>
                        <p class="la-form-section__desc">Chọn trạng thái phù hợp cho đơn hàng</p>
                        <form:select class="form-select" path="status">
                            <c:forEach var="statusOption" items="${statusOptions}">
                                <form:option value="${statusOption.key}">${statusOption.value}</form:option>
                            </c:forEach>
                        </form:select>
                    </section>
                </div>
                <div>
                    <section class="la-form-section">
                        <h3 class="la-form-section__title">Lưu ý</h3>
                        <div style="display:flex; align-items:center; gap: var(--space-3); padding: var(--space-3); background: #fef3c7; border-radius: var(--radius); color: #92400e; font-size: 0.875rem;">
                            <i class="bi bi-exclamation-triangle"></i>
                            <span>Thay đổi trạng thái sẽ áp dụng ngay và thông báo đến khách hàng.</span>
                        </div>
                    </section>
                </div>
            </div>
            <div class="la-form-actions">
                <a href="/admin/order" class="ui-btn ui-btn--secondary">Huỷ</a>
                <button type="submit" class="ui-btn"><i class="bi bi-check2"></i> Lưu thay đổi</button>
            </div>
        </form:form>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
</body>

</html>
