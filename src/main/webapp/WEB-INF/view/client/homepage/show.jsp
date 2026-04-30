<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Laptopshop - Laptop chính hãng, giá tốt mỗi ngày</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client">
    <jsp:include page="../layout/header.jsp" />

    <main>
        <jsp:include page="../layout/banner.jsp" />

        <section class="ls-deal-shortcuts" aria-label="Ưu đãi nhanh">
            <div class="ui-container">
                <a href="/products" class="ls-deal-shortcut">
                    <i class="bi bi-lightning-charge-fill"></i>
                    <span>Deal sốc hôm nay</span>
                    <small>Giá tốt, số lượng có hạn</small>
                </a>
                <a href="/products?target=SINHVIEN-VANPHONG" class="ls-deal-shortcut">
                    <i class="bi bi-mortarboard-fill"></i>
                    <span>Ưu đãi sinh viên</span>
                    <small>Máy học tập, pin bền</small>
                </a>
                <a href="/about#doi-tra" class="ls-deal-shortcut">
                    <i class="bi bi-arrow-repeat"></i>
                    <span>Thu cũ đổi mới</span>
                    <small>Đổi máy, tối ưu chi phí</small>
                </a>
                <a href="/products?target=DOANH-NHAN" class="ls-deal-shortcut">
                    <i class="bi bi-buildings-fill"></i>
                    <span>Khách hàng doanh nghiệp</span>
                    <small>Xuất VAT, tư vấn cấu hình</small>
                </a>
                <a href="/account" class="ls-deal-shortcut">
                    <i class="bi bi-person-heart"></i>
                    <span>Thành viên Laptopshop</span>
                    <small>Theo dõi đơn và ưu đãi</small>
                </a>
            </div>
        </section>

        <section class="ls-quick-cats" aria-labelledby="hm-brands">
            <div class="ui-container">
                <div class="ls-retail-section-head">
                    <div>
                        <span>Danh mục nổi bật</span>
                        <h2 id="hm-brands">Mua nhanh theo nhu cầu</h2>
                    </div>
                    <a href="/products">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                </div>
                <div class="ls-cat-grid">
                    <a href="/products?factory=APPLE" class="ls-cat">
                        <div class="ls-cat__icon"><i class="bi bi-apple"></i></div>
                        <span class="ls-cat__name">MacBook</span>
                        <small>Pin bền, mỏng nhẹ</small>
                    </a>
                    <a href="/products?target=GAMING" class="ls-cat">
                        <div class="ls-cat__icon"><i class="bi bi-controller"></i></div>
                        <span class="ls-cat__name">Gaming</span>
                        <small>RTX, màn 144Hz</small>
                    </a>
                    <a href="/products?target=SINHVIEN-VANPHONG" class="ls-cat">
                        <div class="ls-cat__icon"><i class="bi bi-briefcase"></i></div>
                        <span class="ls-cat__name">Văn phòng</span>
                        <small>Gọn nhẹ, giá tốt</small>
                    </a>
                    <a href="/products?target=THIET-KE-DO-HOA" class="ls-cat">
                        <div class="ls-cat__icon"><i class="bi bi-brush"></i></div>
                        <span class="ls-cat__name">Đồ họa</span>
                        <small>Màn đẹp, hiệu năng</small>
                    </a>
                    <a href="/products?price=duoi-10-trieu" class="ls-cat">
                        <div class="ls-cat__icon"><i class="bi bi-tags"></i></div>
                        <span class="ls-cat__name">Dưới 10 triệu</span>
                        <small>Tiết kiệm ngân sách</small>
                    </a>
                    <a href="/products?price=tren-20-trieu" class="ls-cat">
                        <div class="ls-cat__icon"><i class="bi bi-stars"></i></div>
                        <span class="ls-cat__name">Cao cấp</span>
                        <small>Mạnh và bền</small>
                    </a>
                </div>
            </div>
        </section>

        <section class="ls-flash-zone" id="san-pham-noi-bat">
            <div class="ui-container">
                <div class="ls-flash-head">
                    <div>
                        <span class="ls-flash-head__badge"><i class="bi bi-lightning-fill"></i> Flash Sale</span>
                        <h2>Laptop nổi bật hôm nay</h2>
                    </div>
                    <div class="ls-flash-clock" aria-label="Ưu đãi trong ngày">
                        <span>Ưu đãi kết thúc sau</span>
                        <strong>02</strong><b>:</b><strong>18</strong><b>:</b><strong>45</strong>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty featuredProducts}">
                        <div class="ui-empty">
                            <div class="ui-empty__icon"><i class="bi bi-box-seam"></i></div>
                            <p class="ui-empty__title">Chưa có sản phẩm</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="ls-prod-grid">
                            <c:forEach var="p" items="${featuredProducts}">
                                <c:set var="product" value="${p}" scope="request" />
                                <jsp:include page="/WEB-INF/view/fragments/product-card.jsp" />
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section class="ls-retail-product-section">
            <div class="ui-container">
                <div class="ls-retail-section-head">
                    <div>
                        <span>Apple chính hãng</span>
                        <h2>MacBook nổi bật</h2>
                    </div>
                    <div class="ls-section-chips">
                        <a href="/products?factory=APPLE">Tất cả MacBook</a>
                        <a href="/products?factory=APPLE&price=tren-20-trieu">Cao cấp</a>
                    </div>
                </div>
                <div class="ls-prod-grid">
                    <c:forEach var="p" items="${empty macbookProducts ? products : macbookProducts}">
                        <c:set var="product" value="${p}" scope="request" />
                        <jsp:include page="/WEB-INF/view/fragments/product-card.jsp" />
                    </c:forEach>
                </div>
            </div>
        </section>

        <section class="ls-retail-product-section">
            <div class="ui-container">
                <div class="ls-retail-section-head">
                    <div>
                        <span>Hiệu năng mạnh</span>
                        <h2>Laptop gaming</h2>
                    </div>
                    <div class="ls-section-chips">
                        <a href="/products?target=GAMING">Gaming</a>
                        <a href="/products?target=GAMING&sort=gia-tang-dan">Giá tốt</a>
                    </div>
                </div>
                <div class="ls-prod-grid">
                    <c:forEach var="p" items="${empty gamingProducts ? products : gamingProducts}">
                        <c:set var="product" value="${p}" scope="request" />
                        <jsp:include page="/WEB-INF/view/fragments/product-card.jsp" />
                    </c:forEach>
                </div>
            </div>
        </section>

        <section class="ls-retail-product-section">
            <div class="ui-container">
                <div class="ls-retail-section-head">
                    <div>
                        <span>Học tập - công việc</span>
                        <h2>Laptop văn phòng</h2>
                    </div>
                    <div class="ls-section-chips">
                        <a href="/products?target=SINHVIEN-VANPHONG">Văn phòng</a>
                        <a href="/products?price=duoi-10-trieu&price=10-toi-15-trieu">Dưới 15 triệu</a>
                    </div>
                </div>
                <div class="ls-prod-grid">
                    <c:forEach var="p" items="${empty officeProducts ? products : officeProducts}">
                        <c:set var="product" value="${p}" scope="request" />
                        <jsp:include page="/WEB-INF/view/fragments/product-card.jsp" />
                    </c:forEach>
                </div>
            </div>
        </section>

        <section class="ls-retail-product-section">
            <div class="ui-container">
                <div class="ls-retail-section-head">
                    <div>
                        <span>Tiết kiệm ngân sách</span>
                        <h2>Laptop giá tốt</h2>
                    </div>
                    <div class="ls-section-chips">
                        <a href="/products?price=duoi-10-trieu">Dưới 10 triệu</a>
                        <a href="/products?sort=gia-tang-dan">Giá thấp đến cao</a>
                    </div>
                </div>
                <div class="ls-prod-grid">
                    <c:forEach var="p" items="${empty budgetProducts ? products : budgetProducts}">
                        <c:set var="product" value="${p}" scope="request" />
                        <jsp:include page="/WEB-INF/view/fragments/product-card.jsp" />
                    </c:forEach>
                </div>
            </div>
        </section>

        <section class="ls-brand-wall">
            <div class="ui-container">
                <div class="ls-retail-section-head">
                    <div>
                        <span>Thương hiệu laptop</span>
                        <h2>Chọn hãng bạn yêu thích</h2>
                    </div>
                </div>
                <div class="ls-brand-grid">
                    <a href="/products?factory=APPLE">Apple</a>
                    <a href="/products?factory=ASUS">Asus</a>
                    <a href="/products?factory=DELL">Dell</a>
                    <a href="/products?factory=LENOVO">Lenovo</a>
                    <a href="/products?factory=ACER">Acer</a>
                    <a href="/products?factory=LG">LG</a>
                </div>
            </div>
        </section>

        <jsp:include page="../layout/feature.jsp" />

        <section id="gioi-thieu" class="ui-section ls-about-teaser-section">
            <div class="ui-container">
                <div class="ls-about-teaser ls-about-teaser--compact">
                    <div class="ls-about-teaser__copy">
                        <span class="ui-kicker">About Laptopshop</span>
                        <h2>Hệ thống bán laptop chính hãng với tư vấn, giao hàng và hậu mãi rõ ràng.</h2>
                        <p>Laptopshop giúp khách hàng chọn đúng máy theo nhu cầu học tập, văn phòng, thiết kế, lập trình, gaming và doanh nghiệp nhỏ.</p>
                        <div class="ls-about-teaser__actions">
                            <a href="/about" class="ui-btn"><i class="bi bi-building-check"></i>Tìm hiểu thêm</a>
                            <a href="/products" class="ui-btn ui-btn--secondary"><i class="bi bi-laptop"></i>Xem laptop phù hợp</a>
                        </div>
                    </div>
                    <div class="ls-about-mini-grid">
                        <div><strong>100%</strong><span>hàng chính hãng</span></div>
                        <div><strong>30'</strong><span>xác nhận đơn</span></div>
                        <div><strong>24/7</strong><span>tiếp nhận hỗ trợ</span></div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
    <script src="/client/js/main.js"></script>
</body>

</html>
