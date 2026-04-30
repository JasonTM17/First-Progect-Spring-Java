<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Chi tiết sản phẩm - Laptopshop Admin</title>
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
                        <li class="active">Chi tiết</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Chi tiết sản phẩm #${product.id}</h1>
                <p class="la-page-head__desc">Thông tin sản phẩm hiển thị tại cửa hàng</p>
            </div>
            <div class="la-page-head__actions">
                <a href="/admin/product" class="ui-btn ui-btn--ghost"><i class="bi bi-arrow-left"></i> Quay lại</a>
                <a href="/admin/product/update/${product.id}" class="ui-btn"><i class="bi bi-pencil"></i> Chỉnh sửa</a>
            </div>
        </header>

        <div class="la-form-layout">
            <div class="ui-card" style="padding: var(--space-6);">
                <div style="display:flex; gap: var(--space-5); flex-wrap: wrap;">
                    <div style="flex: 0 0 240px;">
                        <div style="background: var(--bg-muted); border-radius: var(--radius); overflow: hidden; padding: var(--space-3); display:flex; align-items:center; justify-content:center;">
                            <img src="/images/product/${product.image}" alt="${product.name}" style="max-width: 100%; max-height: 260px; object-fit: contain;" />
                        </div>
                    </div>
                    <div style="flex: 1; min-width: 260px;">
                        <h2 style="margin: 0 0 var(--space-2); font-size: 1.25rem;"><c:out value="${product.name}" /></h2>
                        <div style="font-size: 1.5rem; font-weight: 800; color: var(--brand-700); margin-bottom: var(--space-4);">
                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" />₫
                        </div>
                        <dl style="display: grid; grid-template-columns: 140px 1fr; gap: var(--space-3) var(--space-4); margin: 0;">
                            <dt class="ui-muted">ID</dt><dd style="margin:0; font-weight:600;">#${product.id}</dd>
                            <dt class="ui-muted">Hãng</dt><dd style="margin:0;"><span class="ui-badge ui-badge--muted">${product.factory}</span></dd>
                            <dt class="ui-muted">Mục đích</dt><dd style="margin:0;">${product.target}</dd>
                            <dt class="ui-muted">Số lượng</dt><dd style="margin:0;">${product.quantity}</dd>
                            <dt class="ui-muted">Mô tả ngắn</dt><dd style="margin:0;"><c:out value="${product.shortDesc}" default="—" /></dd>
                        </dl>
                    </div>
                </div>
                <c:if test="${not empty product.detailDesc}">
                    <hr style="margin: var(--space-5) 0; border: 0; border-top: 1px solid var(--border);" />
                    <h3 style="font-size: 1rem; margin: 0 0 var(--space-2);">Mô tả chi tiết</h3>
                    <p style="color: var(--text-subtle); line-height: 1.7; white-space: pre-line;"><c:out value="${product.detailDesc}" /></p>
                </c:if>
            </div>

            <div>
                <section class="la-form-section">
                    <h3 class="la-form-section__title">Hành động nhanh</h3>
                    <div style="display:flex; flex-direction:column; gap: var(--space-2);">
                        <a href="/admin/product/update/${product.id}" class="ui-btn ui-btn--secondary"><i class="bi bi-pencil"></i> Chỉnh sửa</a>
                        <a href="/product/${product.id}" target="_blank" class="ui-btn ui-btn--ghost"><i class="bi bi-box-arrow-up-right"></i> Xem trên cửa hàng</a>
                    </div>
                </section>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
</body>

</html>
