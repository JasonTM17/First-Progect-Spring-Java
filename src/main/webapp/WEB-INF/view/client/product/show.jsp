<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="catalogTitle" value="Laptop chính hãng" />
<c:if test="${not empty param.factory}">
    <c:set var="catalogTitle" value="Laptop ${param.factory}" />
</c:if>
<c:if test="${not empty param.name}">
    <c:set var="catalogTitle" value="Kết quả tìm kiếm" />
</c:if>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Sản phẩm - Laptopshop</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client">
    <jsp:include page="../layout/header.jsp" />

    <main class="ls-catalog-page ls-catalog-page--retail">
        <section class="ls-catalog-top">
            <div class="ui-container">
                <nav aria-label="breadcrumb">
                    <ol class="ui-breadcrumb">
                        <li><a href="/">Trang chủ</a></li>
                        <li class="active">Laptop</li>
                    </ol>
                </nav>
                <div class="ls-catalog-titlebar">
                    <div>
                        <h1>${catalogTitle}</h1>
                        <p><strong><fmt:formatNumber type="number" value="${totalProducts}" /></strong> sản phẩm phù hợp · Giá tốt · Giao nhanh · Bảo hành rõ ràng</p>
                    </div>
                    <button type="button" class="ui-btn ui-btn--outline ls-filter-mobile-btn" data-filter-open>
                        <i class="bi bi-funnel"></i>
                        Bộ lọc
                    </button>
                </div>

                <div class="ls-criteria-strip" aria-label="Chọn theo tiêu chí">
                    <span>Chọn theo tiêu chí</span>
                    <a href="/products?factory=APPLE">MacBook</a>
                    <a href="/products?factory=ASUS">Asus</a>
                    <a href="/products?factory=DELL">Dell</a>
                    <a href="/products?target=GAMING">Gaming</a>
                    <a href="/products?target=SINHVIEN-VANPHONG">Văn phòng</a>
                    <a href="/products?price=duoi-10-trieu">Dưới 10 triệu</a>
                    <a href="/products?price=tren-20-trieu">Trên 20 triệu</a>
                    <a href="/products?target=THIET-KE-DO-HOA">Đồ họa</a>
                    <button type="button">RAM 16GB</button>
                    <button type="button">SSD 512GB</button>
                </div>

                <div class="ls-active-filters" aria-label="Bộ lọc đang áp dụng">
                    <c:if test="${not empty param.name}">
                        <span class="ls-filter-chip"><i class="bi bi-search"></i>Từ khóa: <strong><c:out value="${param.name}" /></strong></span>
                    </c:if>
                    <c:forEach var="f" items="${paramValues.factory}">
                        <span class="ls-filter-chip"><i class="bi bi-cpu"></i>Hãng: <strong><c:out value="${f}" /></strong></span>
                    </c:forEach>
                    <c:forEach var="t" items="${paramValues.target}">
                        <span class="ls-filter-chip"><i class="bi bi-person-check"></i>Nhu cầu: <strong><c:out value="${t}" /></strong></span>
                    </c:forEach>
                    <c:forEach var="p" items="${paramValues.price}">
                        <span class="ls-filter-chip"><i class="bi bi-tags"></i>Giá: <strong><c:out value="${p}" /></strong></span>
                    </c:forEach>
                    <c:if test="${not empty param.name or not empty param.factory or not empty param.target or not empty param.price or (not empty sort and sort ne 'gia-nothing')}">
                        <a class="ls-filter-chip ls-filter-chip--reset" href="/products"><i class="bi bi-arrow-counterclockwise"></i>Xóa lọc</a>
                    </c:if>
                </div>
            </div>
        </section>

        <section class="ls-catalog-body">
            <div class="ui-container">
                <div class="ls-catalog-layout">
                    <aside class="ls-catalog-sidebar" aria-label="Bộ lọc sản phẩm">
                        <div class="ls-filter" id="lsCatalogFilter">
                            <div class="ls-filter__head">
                                <div>
                                    <span>Bộ lọc</span>
                                    <strong>Tìm laptop phù hợp</strong>
                                </div>
                                <button type="button" class="ls-filter__close" data-filter-close aria-label="Đóng bộ lọc"><i class="bi bi-x-lg"></i></button>
                                <a href="/products" class="ls-filter__reset" aria-label="Xóa bộ lọc">
                                    <i class="bi bi-arrow-clockwise"></i>
                                </a>
                            </div>

                            <div class="ls-filter__group" id="factoryFilter">
                                <h3 class="ls-filter__title"><i class="bi bi-cpu"></i>Hãng sản xuất</h3>
                                <div class="ls-filter__options">
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="APPLE" /><span>Apple</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="ASUS" /><span>Asus</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="DELL" /><span>Dell</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="LENOVO" /><span>Lenovo</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="ACER" /><span>Acer</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="LG" /><span>LG</span></label>
                                </div>
                            </div>

                            <div class="ls-filter__group" id="targetFilter">
                                <h3 class="ls-filter__title"><i class="bi bi-person-check"></i>Nhu cầu sử dụng</h3>
                                <div class="ls-filter__options">
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="GAMING" /><span>Gaming</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="SINHVIEN-VANPHONG" /><span>Sinh viên - Văn phòng</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="THIET-KE-DO-HOA" /><span>Thiết kế đồ họa</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="MONG-NHE" /><span>Mỏng nhẹ</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="DOANH-NHAN" /><span>Doanh nhân</span></label>
                                </div>
                            </div>

                            <div class="ls-filter__group" id="priceFilter">
                                <h3 class="ls-filter__title"><i class="bi bi-tags"></i>Khoảng giá</h3>
                                <div class="ls-filter__options">
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="duoi-10-trieu" /><span>Dưới 10 triệu</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="10-toi-15-trieu" /><span>10 - 15 triệu</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="15-toi-20-trieu" /><span>15 - 20 triệu</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="checkbox" value="tren-20-trieu" /><span>Trên 20 triệu</span></label>
                                </div>
                            </div>

                            <div class="ls-filter__group">
                                <h3 class="ls-filter__title"><i class="bi bi-sort-down"></i>Sắp xếp</h3>
                                <div class="ls-filter__options">
                                    <label class="ls-filter__opt"><input class="form-check-input" type="radio" name="radio-sort" value="gia-nothing" ${empty sort or sort eq 'gia-nothing' ? 'checked' : ''} /><span>Phổ biến</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="radio" name="radio-sort" value="gia-giam-dan" ${sort eq 'gia-giam-dan' ? 'checked' : ''} /><span>Khuyến mãi HOT</span></label>
                                    <label class="ls-filter__opt"><input class="form-check-input" type="radio" name="radio-sort" value="gia-tang-dan" ${sort eq 'gia-tang-dan' ? 'checked' : ''} /><span>Giá Thấp - Cao</span></label>
                                </div>
                            </div>

                            <button id="btnFilter" class="ui-btn ui-btn--block ls-filter__apply">
                                <i class="bi bi-funnel"></i>
                                Áp dụng bộ lọc
                            </button>
                        </div>
                    </aside>

                    <div class="ls-catalog-results">
                        <div class="ls-sort-toolbar ls-sort-toolbar--retail">
                            <div class="ls-sort-toolbar__count">
                                <span>Đang hiển thị <strong>${empty products ? 0 : products.size()}</strong>/<strong><fmt:formatNumber type="number" value="${totalProducts}" /></strong> sản phẩm</span>
                                <c:if test="${totalPages > 0}">
                                    <small>Trang ${currentPage}/${totalPages}</small>
                                </c:if>
                            </div>
                            <div class="ls-sort-pills" aria-label="Sắp xếp nhanh">
                                <button type="button" class="${empty sort or sort eq 'gia-nothing' ? 'is-active' : ''}" data-sort-value="gia-nothing">Phổ biến</button>
                                <button type="button" class="${sort eq 'gia-giam-dan' ? 'is-active' : ''}" data-sort-value="gia-giam-dan">Khuyến mãi HOT</button>
                                <button type="button" class="${sort eq 'gia-tang-dan' ? 'is-active' : ''}" data-sort-value="gia-tang-dan">Giá Thấp - Cao</button>
                            </div>
                            <div class="ls-view-toggle" role="tablist" aria-label="Chế độ hiển thị">
                                <button type="button" class="is-active" data-view="grid" aria-label="Hiển thị dạng lưới"><i class="bi bi-grid"></i></button>
                                <button type="button" data-view="list" aria-label="Hiển thị dạng danh sách"><i class="bi bi-list-ul"></i></button>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${empty products or totalPages eq 0}">
                                <div class="ls-catalog-empty">
                                    <div class="ui-empty__icon"><i class="bi bi-search"></i></div>
                                    <p class="ui-empty__title">Không tìm thấy sản phẩm phù hợp</p>
                                    <p class="ui-empty__desc">Hãy thử từ khóa khác, bỏ bớt bộ lọc hoặc xem toàn bộ laptop đang bán.</p>
                                    <a href="/products" class="ui-btn ui-btn--outline"><i class="bi bi-arrow-counterclockwise"></i>Xóa bộ lọc</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="ls-prod-grid" id="productGrid">
                                    <c:forEach var="p" items="${products}">
                                        <c:set var="product" value="${p}" scope="request" />
                                        <jsp:include page="/WEB-INF/view/fragments/product-card.jsp" />
                                    </c:forEach>
                                </div>

                                <c:if test="${totalPages > 0}">
                                    <nav class="ui-pagination ls-catalog-pagination" aria-label="Phân trang sản phẩm">
                                        <c:choose>
                                            <c:when test="${currentPage <= 1}">
                                                <span class="page is-disabled" aria-label="Trang trước"><i class="bi bi-chevron-left"></i></span>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/products?page=${currentPage - 1}${queryString}" aria-label="Trang trước"><i class="bi bi-chevron-left"></i></a>
                                            </c:otherwise>
                                        </c:choose>

                                        <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                            <a class="${(loop.index + 1) eq currentPage ? 'is-active' : ''}" href="/products?page=${loop.index + 1}${queryString}">${loop.index + 1}</a>
                                        </c:forEach>

                                        <c:choose>
                                            <c:when test="${currentPage >= totalPages}">
                                                <span class="page is-disabled" aria-label="Trang sau"><i class="bi bi-chevron-right"></i></span>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/products?page=${currentPage + 1}${queryString}" aria-label="Trang sau"><i class="bi bi-chevron-right"></i></a>
                                            </c:otherwise>
                                        </c:choose>
                                    </nav>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>
        <div class="ls-filter-backdrop" data-filter-close hidden></div>
    </main>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
    <script src="/client/js/main.js"></script>
</body>

</html>
