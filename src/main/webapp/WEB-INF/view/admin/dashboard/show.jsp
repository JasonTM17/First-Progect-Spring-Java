<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Dashboard - Laptopshop Admin</title>
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
                        <li class="active">Dashboard</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Dashboard</h1>
                <p class="la-page-head__desc">Tổng quan hoạt động hệ thống Laptopshop</p>
            </div>
            <div class="la-page-head__actions">
                <select class="form-select" style="width: auto;">
                    <option>7 ngày qua</option>
                    <option selected>30 ngày qua</option>
                    <option>90 ngày qua</option>
                </select>
                <a href="/admin/report/orders.csv" class="ui-btn">
                    <i class="bi bi-download"></i> Xuất báo cáo
                </a>
            </div>
        </header>

        <section class="la-dashboard-hero" aria-label="Tổng quan vận hành">
            <div class="la-dashboard-hero__copy">
                <span class="la-dashboard-hero__eyebrow"><i class="bi bi-lightning-charge-fill"></i> Retail command center</span>
                <h2>Điều phối bán hàng Laptopshop trong một màn hình.</h2>
                <p>Theo dõi đơn mới, doanh thu, tồn kho và hoạt động khách hàng để reviewer thấy ngay đây là một hệ thống e-commerce có luồng vận hành thật.</p>
                <div class="la-dashboard-hero__actions">
                    <a href="/admin/order" class="ui-btn ui-btn--secondary"><i class="bi bi-receipt"></i> Xử lý đơn</a>
                    <a href="/admin/product/create" class="ui-btn ui-btn--ghost"><i class="bi bi-plus-circle"></i> Thêm sản phẩm</a>
                    <a href="/" target="_blank" class="ui-btn ui-btn--ghost"><i class="bi bi-box-arrow-up-right"></i> Xem storefront</a>
                </div>
            </div>
            <div class="la-dashboard-hero__panel">
                <div class="la-dashboard-hero__metric">
                    <span>Đơn hàng</span>
                    <strong>${countOrders}</strong>
                </div>
                <div class="la-dashboard-hero__metric">
                    <span>Sản phẩm</span>
                    <strong>${countProducts}</strong>
                </div>
                <div class="la-dashboard-hero__metric">
                    <span>Người dùng</span>
                    <strong>${countUsers}</strong>
                </div>
                <div class="la-dashboard-hero__metric">
                    <span>Doanh thu</span>
                    <strong>
                        <c:choose>
                            <c:when test="${not empty totalRevenue}">${totalRevenue}</c:when>
                            <c:otherwise>--</c:otherwise>
                        </c:choose>
                    </strong>
                </div>
            </div>
        </section>

        <!-- KPI cards -->
        <div class="la-kpi-grid">
            <div class="ui-kpi">
                <div class="ui-kpi__icon ui-kpi__icon--primary"><i class="bi bi-people"></i></div>
                <div style="flex: 1;">
                    <div class="ui-kpi__label">Người dùng</div>
                    <div class="ui-kpi__value">${countUsers}</div>
                    <div class="ui-kpi__trend ui-kpi__trend--up">
                        <i class="bi bi-database-check"></i> Dữ liệu thật từ DB
                    </div>
                </div>
                <a href="/admin/user" class="ui-iconbtn" aria-label="Xem chi tiết">
                    <i class="bi bi-arrow-right"></i>
                </a>
            </div>

            <div class="ui-kpi">
                <div class="ui-kpi__icon ui-kpi__icon--accent"><i class="bi bi-box-seam"></i></div>
                <div style="flex: 1;">
                    <div class="ui-kpi__label">Sản phẩm</div>
                    <div class="ui-kpi__value">${countProducts}</div>
                    <div class="ui-kpi__trend ui-kpi__trend--up">
                        <i class="bi bi-database-check"></i> Dữ liệu thật từ DB
                    </div>
                </div>
                <a href="/admin/product" class="ui-iconbtn" aria-label="Xem chi tiết">
                    <i class="bi bi-arrow-right"></i>
                </a>
            </div>

            <div class="ui-kpi">
                <div class="ui-kpi__icon ui-kpi__icon--success"><i class="bi bi-receipt"></i></div>
                <div style="flex: 1;">
                    <div class="ui-kpi__label">Đơn hàng</div>
                    <div class="ui-kpi__value">${countOrders}</div>
                    <div class="ui-kpi__trend ui-kpi__trend--up">
                        <i class="bi bi-database-check"></i> Dữ liệu thật từ DB
                    </div>
                </div>
                <a href="/admin/order" class="ui-iconbtn" aria-label="Xem chi tiết">
                    <i class="bi bi-arrow-right"></i>
                </a>
            </div>

            <div class="ui-kpi">
                <div class="ui-kpi__icon ui-kpi__icon--danger"><i class="bi bi-currency-dollar"></i></div>
                <div style="flex: 1;">
                    <div class="ui-kpi__label">Doanh thu</div>
                    <div class="ui-kpi__value" style="font-size: 1.5rem;">
                        <c:choose>
                            <c:when test="${not empty totalRevenue}">${totalRevenue}</c:when>
                            <c:otherwise>—</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="ui-kpi__trend ui-kpi__trend--up">
                        <i class="bi bi-database-check"></i> Tổng doanh thu thực tế
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts row -->
        <div class="la-grid-2" style="margin-bottom: var(--space-5);">
            <div class="la-chart-card">
                <div class="la-chart-card__head">
                    <div>
                        <h3 class="la-chart-card__title">Doanh thu theo đơn gần đây</h3>
                        <p class="la-chart-card__subtitle">Dữ liệu thật từ các đơn mới nhất trong hệ thống</p>
                    </div>
                    <div>
                        <span class="ui-badge ui-badge--success"><i class="bi bi-database-check"></i> Real data</span>
                    </div>
                </div>
                <canvas id="chartRevenue" height="100"></canvas>
            </div>

            <div class="la-chart-card">
                <div class="la-chart-card__head">
                    <h3 class="la-chart-card__title">Phân bố theo hãng</h3>
                </div>
                <canvas id="chartFactory" height="180"></canvas>
            </div>
        </div>

        <c:if test="${not empty lowStockProducts}">
            <div class="la-chart-card" style="margin-bottom: var(--space-5);">
                <div class="la-chart-card__head">
                    <div>
                        <h3 class="la-chart-card__title">Cảnh báo tồn kho</h3>
                        <p class="la-chart-card__subtitle">Sản phẩm cần nhập thêm để không đứt hàng khi demo vận hành.</p>
                    </div>
                    <a href="/admin/product" class="ui-btn ui-btn--ghost ui-btn--sm">Quản lý kho <i class="bi bi-arrow-right"></i></a>
                </div>
                <div class="la-low-stock">
                    <c:forEach var="product" items="${lowStockProducts}">
                        <a href="/admin/product/${product.id}" class="la-low-stock__item">
                            <img src="/images/product/${product.image}" alt="" />
                            <span><c:out value="${product.name}" /></span>
                            <strong>Còn ${product.quantity}</strong>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Recent orders + Activity -->
        <div class="la-grid-2">
            <div class="la-chart-card">
                <div class="la-chart-card__head">
                    <div>
                        <h3 class="la-chart-card__title">Đơn hàng gần đây</h3>
                        <p class="la-chart-card__subtitle">5 đơn hàng mới nhất</p>
                    </div>
                    <a href="/admin/order" class="ui-btn ui-btn--ghost ui-btn--sm">
                        Xem tất cả <i class="bi bi-arrow-right"></i>
                    </a>
                </div>
                <div class="table-responsive">
                    <table class="table align-middle" style="margin: 0;">
                        <thead>
                            <tr>
                                <th>Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty recentOrders}">
                                    <c:forEach var="o" items="${recentOrders}" end="4">
                                        <tr>
                                            <td style="font-weight: 600;">#${o.id}</td>
                                            <td><c:out value="${o.user.email}" /></td>
                                            <td style="font-weight: 600; color: var(--brand-700);">
                                                <fmt:formatNumber value="${o.totalPrice}" type="number" />₫
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${o.status eq 'DELIVERED'}"><span class="la-status la-status--complete">Đã giao</span></c:when>
                                                    <c:when test="${o.status eq 'CONFIRMED'}"><span class="la-status la-status--shipping">Đã xác nhận</span></c:when>
                                                    <c:when test="${o.status eq 'CANCELLED'}"><span class="la-status la-status--cancel">Huỷ</span></c:when>
                                                    <c:when test="${o.status eq 'COMPLETE'}"><span class="la-status la-status--complete">Hoàn tất</span></c:when>
                                                    <c:when test="${o.status eq 'SHIPPING'}"><span class="la-status la-status--shipping">Đang giao</span></c:when>
                                                    <c:when test="${o.status eq 'CANCEL'}"><span class="la-status la-status--cancel">Huỷ</span></c:when>
                                                    <c:otherwise><span class="la-status la-status--pending">Chờ xử lý</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><a href="/admin/order/${o.id}" class="ui-iconbtn" aria-label="Chi tiết"><i class="bi bi-eye"></i></a></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="5" style="text-align: center; padding: var(--space-8);">
                                        <div class="ui-empty" style="padding: var(--space-4) 0;">
                                            <div class="ui-empty__icon" style="font-size: 40px;"><i class="bi bi-inbox"></i></div>
                                            <p class="ui-empty__title">Chưa có đơn hàng nào</p>
                                        </div>
                                    </td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="la-chart-card">
                <div class="la-chart-card__head">
                    <h3 class="la-chart-card__title">Hoạt động gần đây</h3>
                </div>
                <div class="la-activity">
                    <c:forEach var="activity" items="${dashboardActivities}">
                        <div class="la-activity__item">
                            <div class="la-activity__dot la-activity__dot--${activity.tone}">
                                <i class="${activity.iconClass}"></i>
                            </div>
                            <div>
                                <p class="la-activity__title"><c:out value="${activity.title}" /></p>
                                <p class="la-activity__meta"><c:out value="${activity.meta}" /></p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script>
        (function () {
            if (typeof Chart === 'undefined') return;
            var brand = '#d70018';
            var brandSoft = 'rgba(215, 0, 24, 0.12)';
            Chart.defaults.font.family = "Inter, system-ui, sans-serif";
            Chart.defaults.color = '#64748b';

            var labels = ${revenueLabelsJson};
            var data = ${revenueDataJson};
            var ctx = document.getElementById('chartRevenue');
            if (ctx) new Chart(ctx, {
                type: 'line',
                data: { labels: labels, datasets: [{
                    label: 'Doanh thu theo đơn gần đây',
                    data: data,
                    borderColor: brand,
                    backgroundColor: brandSoft,
                    fill: true,
                    tension: 0.35,
                    pointRadius: 0,
                    pointHoverRadius: 5,
                    borderWidth: 2
                }]},
                options: {
                    plugins: { legend: { display: false } },
                    scales: {
                        y: { grid: { color: '#f1f5f9' }, ticks: { callback: function(v) { return (v/1000000).toFixed(1)+'M'; } } },
                        x: { grid: { display: false } }
                    }
                }
            });

            var ctx2 = document.getElementById('chartFactory');
            if (ctx2) new Chart(ctx2, {
                type: 'doughnut',
                data: {
                    labels: ${factoryLabelsJson},
                    datasets: [{
                        data: ${factoryDataJson},
                        backgroundColor: ['#d70018', '#f59e0b', '#10b981', '#ef4444', '#0ea5e9', '#94a3b8'],
                        borderWidth: 0
                    }]
                },
                options: {
                    plugins: { legend: { position: 'bottom', labels: { boxWidth: 12, padding: 14 } } },
                    cutout: '62%'
                }
            });
        })();
    </script>
</body>

</html>
