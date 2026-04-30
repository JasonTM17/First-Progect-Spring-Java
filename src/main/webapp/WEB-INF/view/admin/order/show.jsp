<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Đơn hàng - Laptopshop Admin</title>
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
                        <li class="active">Đơn hàng</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Đơn hàng</h1>
                <p class="la-page-head__desc">Theo dõi và xử lý các đơn hàng đã tạo</p>
            </div>
        </header>

        <div class="ui-card" style="padding: 0;">
            <form method="get" action="/admin/order" style="padding: var(--space-4) var(--space-5); border-bottom: 1px solid var(--border); display: flex; gap: var(--space-3); flex-wrap: wrap; align-items: center;">
                <div style="flex: 1; min-width: 240px; position: relative;">
                    <i class="bi bi-search" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                    <input type="search" class="form-control" name="q" value="${fn:escapeXml(query)}" placeholder="Tìm theo mã, khách hàng..." style="padding-left: 36px;" id="orderSearch" />
                </div>
                <select class="form-select" name="status" style="width: auto; min-width: 160px;" id="statusFilter">
                    <option value="">Tất cả trạng thái</option>
                    <option value="PENDING" ${statusFilter eq 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                    <option value="CONFIRMED" ${statusFilter eq 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                    <option value="SHIPPING" ${statusFilter eq 'SHIPPING' ? 'selected' : ''}>Đang giao</option>
                    <option value="DELIVERED" ${statusFilter eq 'DELIVERED' ? 'selected' : ''}>Đã giao</option>
                    <option value="CANCELLED" ${statusFilter eq 'CANCELLED' ? 'selected' : ''}>Đã huỷ</option>
                </select>
                <button class="ui-btn ui-btn--secondary" type="submit"><i class="bi bi-filter"></i> Lọc</button>
                <c:if test="${not empty query or not empty statusFilter}">
                    <a class="ui-btn ui-btn--ghost" href="/admin/order">Xoá lọc</a>
                </c:if>
            </form>

            <div class="table-responsive">
                <table class="table align-middle" style="margin: 0;">
                    <thead>
                        <tr>
                            <th style="width: 80px;">Mã đơn</th>
                            <th>Khách hàng</th>
                            <th style="width: 180px;">Tổng tiền</th>
                            <th style="width: 160px;">Trạng thái</th>
                            <th style="width: 180px; text-align: right;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty orders}">
                                <tr><td colspan="5" style="padding: var(--space-10) 0;">
                                    <div class="ui-empty">
                                        <div class="ui-empty__icon"><i class="bi bi-receipt"></i></div>
                                        <p class="ui-empty__title">Chưa có đơn hàng</p>
                                        <p class="ui-empty__desc">Đơn hàng sẽ hiển thị tại đây khi khách đặt mua.</p>
                                    </div>
                                </td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td style="font-weight: 700;">#${order.id}</td>
                                        <td>
                                            <div style="font-weight: 500;"><c:out value="${order.user.fullName}" /></div>
                                            <div style="font-size: 0.75rem; color: var(--text-muted);"><c:out value="${order.user.email}" /></div>
                                        </td>
                                        <td style="font-weight: 700; color: var(--brand-700);">
                                            <fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true" />₫
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status eq 'DELIVERED'}"><span class="la-status la-status--complete">Đã giao</span></c:when>
                                                <c:when test="${order.status eq 'CONFIRMED'}"><span class="la-status la-status--shipping">Đã xác nhận</span></c:when>
                                                <c:when test="${order.status eq 'CANCELLED'}"><span class="la-status la-status--cancel">Huỷ</span></c:when>
                                                <c:when test="${order.status eq 'COMPLETE'}"><span class="la-status la-status--complete">Hoàn tất</span></c:when>
                                                <c:when test="${order.status eq 'SHIPPING'}"><span class="la-status la-status--shipping">Đang giao</span></c:when>
                                                <c:when test="${order.status eq 'CANCEL'}"><span class="la-status la-status--cancel">Huỷ</span></c:when>
                                                <c:otherwise><span class="la-status la-status--pending">Chờ xử lý</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="text-align: right;">
                                            <div style="display: inline-flex; gap: 4px;">
                                                <a href="/admin/order/${order.id}" class="ui-iconbtn" title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="/admin/order/update/${order.id}" class="ui-iconbtn ui-iconbtn--warn" title="Cập nhật">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <form method="post" action="/admin/order/delete" style="display:inline;"
                                                      data-confirm-title="Xoá đơn hàng"
                                                      data-confirm="Bạn chắc chắn muốn xoá đơn hàng #${order.id}?">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <input type="hidden" name="id" value="${order.id}" />
                                                    <button type="submit" class="ui-iconbtn" style="color: var(--danger-600); background: #fee2e2;" title="Xoá">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <c:if test="${not empty orders and totalPages > 1}">
                <div style="padding: var(--space-4) var(--space-5); border-top: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: var(--space-3);">
                    <div style="font-size: var(--fs-sm); color: var(--text-muted);">Trang ${currentPage} / ${totalPages}</div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination" style="margin: 0;">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="/admin/order?page=${currentPage - 1}${filterQuery}"><i class="bi bi-chevron-left"></i></a>
                            </li>
                            <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                <li class="page-item ${loop.index + 1 == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="/admin/order?page=${loop.index + 1}${filterQuery}">${loop.index + 1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="/admin/order?page=${currentPage + 1}${filterQuery}"><i class="bi bi-chevron-right"></i></a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
    <script>
        (function () {
            var filter = document.getElementById('statusFilter');
            if (filter && filter.form) {
                filter.addEventListener('change', function () {
                    filter.form.submit();
                });
            }
        })();
    </script>
</body>

</html>
