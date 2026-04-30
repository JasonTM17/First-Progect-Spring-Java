<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Lịch sử mua hàng - Laptopshop</title>
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
                        <li class="active">Lịch sử mua hàng</li>
                    </ol>
                </nav>
                <h1 class="ui-section-head__title" style="margin: 0;">Đơn hàng của tôi</h1>
                <p class="ui-muted" style="margin-top: 4px;">Theo dõi và quản lý tất cả đơn đặt hàng đã thực hiện</p>
            </div>
        </section>

        <section style="padding: var(--space-8) 0;">
            <div class="ui-container">
                <c:choose>
                    <c:when test="${empty orders}">
                        <div class="ui-empty" style="background: var(--surface); border-radius: var(--radius-lg); border: 1px solid var(--border); padding: var(--space-16) var(--space-4);">
                            <div class="ui-empty__icon"><i class="bi bi-bag-check"></i></div>
                            <p class="ui-empty__title">Bạn chưa có đơn hàng nào</p>
                            <p class="ui-empty__desc">Hãy bắt đầu mua sắm để thấy đơn hàng xuất hiện ở đây.</p>
                            <a href="/products" class="ui-btn" style="margin-top: var(--space-3);">
                                <i class="bi bi-bag-plus"></i>
                                Mua sắm ngay
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="ui-stack" style="gap: var(--space-5);">
                            <c:forEach var="order" items="${orders}">
                                <article class="ui-card" style="padding: 0;">
                                    <!-- Order header -->
                                    <header style="padding: var(--space-4) var(--space-5); border-bottom: 1px solid var(--border); background: var(--slate-50); display: flex; align-items: center; justify-content: space-between; gap: var(--space-3); flex-wrap: wrap;">
                                        <div>
                                            <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.08em; font-weight: 600;">
                                                Mã đơn hàng
                                            </div>
                                            <div style="font-weight: 700; font-size: 1.125rem; color: var(--text);">
                                                #${order.id}
                                            </div>
                                        </div>
                                        <div>
                                            <c:choose>
                                                <c:when test="${order.status eq 'COMPLETE'}">
                                                    <span class="la-status la-status--complete"><i class="bi bi-check-circle"></i> Hoàn tất</span>
                                                </c:when>
                                                <c:when test="${order.status eq 'SHIPPING'}">
                                                    <span class="la-status la-status--shipping"><i class="bi bi-truck"></i> Đang giao</span>
                                                </c:when>
                                                <c:when test="${order.status eq 'CANCEL'}">
                                                    <span class="la-status la-status--cancel"><i class="bi bi-x-circle"></i> Đã huỷ</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="la-status la-status--pending"><i class="bi bi-clock"></i> ${empty order.status ? 'Chờ xử lý' : order.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </header>

                                    <!-- Products -->
                                    <div>
                                        <c:forEach var="detail" items="${order.orderDetails}">
                                            <div style="display: grid; grid-template-columns: 72px 1fr auto auto; gap: var(--space-4); align-items: center; padding: var(--space-3) var(--space-5); border-bottom: 1px solid var(--border);">
                                                <img src="/images/product/${detail.product.image}" alt="" style="width: 72px; height: 72px; object-fit: contain; padding: 6px; background: var(--slate-50); border-radius: var(--radius);" />
                                                <div>
                                                    <a href="/product/${detail.product.id}" target="_blank" style="font-weight: 600; color: var(--text); text-decoration: none;">
                                                        <c:out value="${detail.product.name}" />
                                                    </a>
                                                    <div style="font-size: 0.75rem; color: var(--text-muted); margin-top: 2px;">
                                                        <fmt:formatNumber value="${detail.price}" type="number" />₫ × ${detail.quantity}
                                                    </div>
                                                </div>
                                                <div style="text-align: right; font-size: 0.75rem; color: var(--text-muted);">Thành tiền</div>
                                                <div style="font-weight: 700; color: var(--brand-700);">
                                                    <fmt:formatNumber value="${detail.price * detail.quantity}" type="number" />₫
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <!-- Footer -->
                                    <footer style="padding: var(--space-4) var(--space-5); display: flex; justify-content: space-between; align-items: center; gap: var(--space-3); flex-wrap: wrap; background: var(--bg-muted);">
                                        <div style="display: flex; gap: var(--space-3); align-items: center; font-size: 0.875rem; color: var(--text-muted);">
                                            <i class="bi bi-receipt"></i>
                                            Tổng thanh toán · ${order.paymentMethod eq 'BANK' ? 'Chuyển khoản ngân hàng' : 'Thanh toán khi nhận hàng'}
                                        </div>
                                        <div style="font-weight: 800; font-size: 1.25rem; color: var(--brand-700);">
                                            <fmt:formatNumber value="${order.totalPrice}" type="number" />₫
                                        </div>
                                    </footer>
                                </article>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
</body>

</html>
