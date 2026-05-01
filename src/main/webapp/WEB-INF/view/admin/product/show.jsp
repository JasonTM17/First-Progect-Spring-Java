<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Sản phẩm - Laptopshop Admin</title>
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
                        <li class="active">Sản phẩm</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Sản phẩm</h1>
                <p class="la-page-head__desc">Quản lý danh mục sản phẩm, giá và tồn kho</p>
            </div>
            <div class="la-page-head__actions">
                <a href="/admin/product/create" class="ui-btn">
                    <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                </a>
            </div>
        </header>

        <div class="ui-card" style="padding: 0;">
            <form method="get" action="/admin/product" style="padding: var(--space-4) var(--space-5); border-bottom: 1px solid var(--border); display: flex; gap: var(--space-3); flex-wrap: wrap; align-items: center;">
                <div style="flex: 1; min-width: 240px; position: relative;">
                    <i class="bi bi-search" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                    <input type="search" class="form-control" name="q" value="${fn:escapeXml(query)}" placeholder="Tìm theo tên, hãng..." style="padding-left: 36px;" id="prodSearch" />
                </div>
                <select class="form-select" name="factory" style="width: auto; min-width: 160px;" id="factoryFilter">
                    <option value="">Tất cả hãng</option>
                    <option value="APPLE" ${factoryFilter eq 'APPLE' ? 'selected' : ''}>APPLE</option>
                    <option value="ASUS" ${factoryFilter eq 'ASUS' ? 'selected' : ''}>ASUS</option>
                    <option value="LENOVO" ${factoryFilter eq 'LENOVO' ? 'selected' : ''}>LENOVO</option>
                    <option value="DELL" ${factoryFilter eq 'DELL' ? 'selected' : ''}>DELL</option>
                    <option value="LG" ${factoryFilter eq 'LG' ? 'selected' : ''}>LG</option>
                    <option value="ACER" ${factoryFilter eq 'ACER' ? 'selected' : ''}>ACER</option>
                </select>
                <button class="ui-btn ui-btn--secondary" type="submit"><i class="bi bi-filter"></i> Lọc</button>
                <c:if test="${not empty query or not empty factoryFilter}">
                    <a class="ui-btn ui-btn--ghost" href="/admin/product">Xoá lọc</a>
                </c:if>
            </form>

            <div class="table-responsive">
                <table class="table align-middle" style="margin: 0;">
                    <thead>
                        <tr>
                            <th style="width: 60px;">ID</th>
                            <th style="width: 72px;">Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th style="width: 160px;">Giá</th>
                            <th style="width: 120px;">Hãng</th>
                            <th style="width: 180px; text-align: right;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty products}">
                                <tr><td colspan="6" style="padding: var(--space-10) 0;">
                                    <div class="ui-empty">
                                        <div class="ui-empty__icon"><i class="bi bi-box-seam"></i></div>
                                        <p class="ui-empty__title">Chưa có sản phẩm</p>
                                        <p class="ui-empty__desc">Thêm sản phẩm đầu tiên để hiển thị lên website.</p>
                                        <a href="/admin/product/create" class="ui-btn" style="margin-top: var(--space-3);">
                                            <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                                        </a>
                                    </div>
                                </td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="product" items="${products}">
                                    <tr>
                                        <td style="font-weight: 600; color: var(--text-muted);">#${product.id}</td>
                                        <td>
                                            <div style="width: 52px; height: 52px; border-radius: var(--radius); background: var(--slate-50); padding: 4px; border: 1px solid var(--border);">
                                                <img src="/images/product/${fn:escapeXml(product.image)}" alt="" style="width:100%;height:100%;object-fit:contain;" onerror="this.style.display='none';" />
                                            </div>
                                        </td>
                                        <td>
                                            <div style="font-weight: 600;"><c:out value="${product.name}" /></div>
                                            <div style="font-size: 0.75rem; color: var(--text-muted);"><c:out value="${product.target}" /></div>
                                        </td>
                                        <td style="font-weight: 700; color: var(--brand-700);">
                                            <fmt:formatNumber type="number" value="${product.price}" />₫
                                        </td>
                                        <td><span class="ui-badge ui-badge--muted"><c:out value="${product.factory}" /></span></td>
                                        <td style="text-align: right;">
                                            <div style="display: inline-flex; gap: 4px;">
                                                <a href="/admin/product/${product.id}" class="ui-iconbtn" title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="/admin/product/update/${product.id}" class="ui-iconbtn ui-iconbtn--warn" title="Chỉnh sửa">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <form method="post" action="/admin/product/delete" style="display:inline;"
                                                      data-confirm-title="Xoá sản phẩm"
                                                      data-confirm="Bạn chắc chắn muốn xoá sản phẩm ${fn:escapeXml(product.name)}? Hành động này không thể hoàn tác.">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <input type="hidden" name="id" value="${product.id}" />
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

            <c:if test="${not empty products and totalPages > 1}">
                <div style="padding: var(--space-4) var(--space-5); border-top: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: var(--space-3);">
                    <div style="font-size: var(--fs-sm); color: var(--text-muted);">Trang ${currentPage} / ${totalPages}</div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination" style="margin: 0;">
                            <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                                <a class="page-link" href="/admin/product?page=${currentPage - 1}${filterQuery}" aria-label="Trước"><i class="bi bi-chevron-left"></i></a>
                            </li>
                            <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                <li class="page-item ${loop.index + 1 == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="/admin/product?page=${loop.index + 1}${filterQuery}">${loop.index + 1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="/admin/product?page=${currentPage + 1}${filterQuery}" aria-label="Sau"><i class="bi bi-chevron-right"></i></a>
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
            var filter = document.getElementById('factoryFilter');
            if (filter && filter.form) {
                filter.addEventListener('change', function () {
                    filter.form.submit();
                });
            }
        })();
    </script>
</body>

</html>
