<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Chi tiết đơn hàng - Laptopshop Admin</title>
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
                        <li class="active">Chi tiết</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Đơn hàng #${order.id}</h1>
                <p class="la-page-head__desc">Thông tin chi tiết đơn hàng và danh sách sản phẩm</p>
            </div>
            <div class="la-page-head__actions">
                <a href="/admin/order" class="ui-btn ui-btn--ghost"><i class="bi bi-arrow-left"></i> Quay lại</a>
                <a href="/admin/order/update/${order.id}" class="ui-btn"><i class="bi bi-pencil"></i> Cập nhật</a>
            </div>
        </header>

        <div class="la-form-layout">
            <div>
                <section class="la-form-section">
                    <h3 class="la-form-section__title">Sản phẩm trong đơn (${fn:length(orderDetails)})</h3>
                    <p class="la-form-section__desc">Danh sách sản phẩm khách đã đặt</p>
                    <div class="table-responsive">
                        <table class="table align-middle" style="margin: 0;">
                            <thead>
                                <tr>
                                    <th style="width: 80px;">Ảnh</th>
                                    <th>Sản phẩm</th>
                                    <th style="width: 140px;">Đơn giá</th>
                                    <th style="width: 80px; text-align:center;">SL</th>
                                    <th style="width: 160px; text-align: right;">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${orderDetails}">
                                    <tr>
                                        <td>
                                            <img src="/images/product/${detail.product.image}" alt="" style="width: 56px; height: 56px; object-fit: cover; border-radius: var(--radius-sm); border: 1px solid var(--border);" />
                                        </td>
                                        <td>
                                            <a href="/admin/product/${detail.product.id}" style="color: var(--text); font-weight: 500; text-decoration: none;">
                                                <c:out value="${detail.product.name}" />
                                            </a>
                                        </td>
                                        <td><fmt:formatNumber value="${detail.price}" type="number" groupingUsed="true" />₫</td>
                                        <td style="text-align:center;">${detail.quantity}</td>
                                        <td style="text-align: right; font-weight: 700; color: var(--brand-700);">
                                            <fmt:formatNumber value="${detail.price * detail.quantity}" type="number" groupingUsed="true" />₫
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" style="text-align: right; font-weight: 600;">Tổng cộng</td>
                                    <td style="text-align: right; font-weight: 800; color: var(--brand-700); font-size: 1.125rem;">
                                        <fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" />₫
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </section>
            </div>

            <div>
                <section class="la-form-section">
                    <h3 class="la-form-section__title">Thông tin đơn hàng</h3>
                    <dl style="display: grid; grid-template-columns: 110px 1fr; gap: var(--space-2) var(--space-3); margin: 0;">
                        <dt class="ui-muted">Mã đơn</dt><dd style="margin:0; font-weight: 600;">#${order.id}</dd>
                        <dt class="ui-muted">Trạng thái</dt>
                        <dd style="margin:0;">
                            <c:choose>
                                <c:when test="${order.status eq 'DELIVERED'}"><span class="la-status la-status--complete">Đã giao</span></c:when>
                                <c:when test="${order.status eq 'CONFIRMED'}"><span class="la-status la-status--shipping">Đã xác nhận</span></c:when>
                                <c:when test="${order.status eq 'CANCELLED'}"><span class="la-status la-status--cancel">Huỷ</span></c:when>
                                <c:when test="${order.status eq 'COMPLETE'}"><span class="la-status la-status--complete">Hoàn tất</span></c:when>
                                <c:when test="${order.status eq 'SHIPPING'}"><span class="la-status la-status--shipping">Đang giao</span></c:when>
                                <c:when test="${order.status eq 'CANCEL'}"><span class="la-status la-status--cancel">Huỷ</span></c:when>
                                <c:otherwise><span class="la-status la-status--pending">Chờ xử lý</span></c:otherwise>
                            </c:choose>
                        </dd>
                        <dt class="ui-muted">Tổng tiền</dt>
                        <dd style="margin:0; font-weight: 700; color: var(--brand-700);"><fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" />₫</dd>
                        <dt class="ui-muted">Thanh toán</dt>
                        <dd style="margin:0; font-weight: 600;">
                            ${order.paymentMethod eq 'BANK' ? 'Chuyển khoản ngân hàng' : 'Thanh toán khi nhận hàng'}
                        </dd>
                    </dl>
                </section>

                <section class="la-form-section">
                    <h3 class="la-form-section__title">Khách hàng</h3>
                    <div style="display:flex; align-items:center; gap: var(--space-3);">
                        <div style="width: 48px; height: 48px; border-radius: 999px; background: var(--brand-100); color: var(--brand-700); display:flex; align-items:center; justify-content:center; font-weight: 700;">
                            <c:out value="${fn:toUpperCase(fn:substring(order.user.fullName, 0, 1))}" default="U" />
                        </div>
                        <div>
                            <div style="font-weight: 600;"><c:out value="${order.user.fullName}" /></div>
                            <div style="font-size: 0.8125rem; color: var(--text-muted);"><c:out value="${order.user.email}" /></div>
                        </div>
                    </div>
                    <hr style="margin: var(--space-3) 0; border: 0; border-top: 1px solid var(--border);" />
                    <dl style="display: grid; grid-template-columns: 80px 1fr; gap: var(--space-2) var(--space-3); margin: 0; font-size: 0.875rem;">
                        <dt class="ui-muted">SĐT</dt><dd style="margin:0;"><c:out value="${order.user.phone}" default="—" /></dd>
                        <dt class="ui-muted">Địa chỉ</dt><dd style="margin:0;"><c:out value="${order.user.address}" default="—" /></dd>
                    </dl>
                </section>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
</body>

</html>
