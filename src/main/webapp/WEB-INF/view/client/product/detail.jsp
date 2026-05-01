<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title><c:out value="${product.name}" /> - Laptopshop</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client">
    <jsp:include page="../layout/header.jsp" />

    <main class="ls-product-detail-page">
        <section class="ls-page-head ls-page-head--compact">
            <div class="ui-container">
                <nav aria-label="breadcrumb">
                    <ol class="ui-breadcrumb">
                        <li><a href="/">Trang chủ</a></li>
                        <li><a href="/products">Laptop</a></li>
                        <li class="active"><c:out value="${product.name}" /></li>
                    </ol>
                </nav>
            </div>
        </section>

        <section class="ls-product-detail-wrap">
            <div class="ui-container">
                <div class="ls-pd ls-pd--retail">
                    <div class="ls-pd__gallery">
                        <div class="ls-pd__gallery-head">
                            <span class="ui-badge ui-badge--danger">Giảm 8%</span>
                            <span class="ui-badge ui-badge--warning">Trả góp 0%</span>
                        </div>
                        <img src="/images/product/${fn:escapeXml(product.image)}" alt="${fn:escapeXml(product.name)}" class="ls-pd__main-img" id="pdMainImg" />
                        <div class="ls-pd__thumbs">
                            <img src="/images/product/${fn:escapeXml(product.image)}" alt="" class="ls-pd__thumb is-active" />
                            <img src="/images/product/${fn:escapeXml(product.image)}" alt="" class="ls-pd__thumb" />
                            <img src="/images/product/${fn:escapeXml(product.image)}" alt="" class="ls-pd__thumb" />
                        </div>
                        <div class="ls-pd__commitments">
                            <div><i class="bi bi-patch-check-fill"></i>Hàng chính hãng</div>
                            <div><i class="bi bi-arrow-repeat"></i>Đổi trả 7 ngày</div>
                            <div><i class="bi bi-shield-check"></i>Bảo hành 12 tháng</div>
                        </div>
                    </div>

                    <div class="ls-pd__info">
                        <div class="ls-pd__heading">
                            <span class="ls-pd__brand"><c:out value="${product.factory}" /></span>
                            <h1 class="ls-pd__title"><c:out value="${product.name}" /></h1>
                            <div class="ls-pd__rating">
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i>
                                <i class="bi bi-star-half"></i>
                                <span>4.8 · Đã bán ${product.sold}</span>
                                <span>|</span>
                                <c:choose>
                                    <c:when test="${product.quantity gt 0}">
                                        <span class="ls-stock"><i class="bi bi-check-circle-fill"></i> Còn hàng</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="ls-stock ls-stock--out"><i class="bi bi-x-circle-fill"></i> Hết hàng</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="ls-pd__price-box">
                            <div class="ls-pd__price-line">
                                <div class="ls-pd__price"><fmt:formatNumber type="number" value="${product.price}" />₫</div>
                                <div class="ls-pd__old"><fmt:formatNumber type="number" maxFractionDigits="0" value="${product.price * 1.08}" />₫</div>
                                <span class="ls-pd__discount">Tiết kiệm 8%</span>
                            </div>
                            <div class="ls-pd__price-note">Đã bao gồm VAT - Giá online áp dụng trong hôm nay</div>
                        </div>

                        <div class="ls-pd__promo-box">
                            <h2><i class="bi bi-gift-fill"></i> Khuyến mãi</h2>
                            <ul>
                                <li>Tặng balo Laptopshop và chuột không dây khi đặt hàng online.</li>
                                <li>Giảm thêm 300.000₫ khi thanh toán chuyển khoản.</li>
                                <li>Vệ sinh máy miễn phí 12 tháng tại hệ thống Laptopshop.</li>
                            </ul>
                        </div>

                        <div class="ls-pd__payment-box">
                            <h2><i class="bi bi-credit-card-2-front"></i> Ưu đãi thanh toán</h2>
                            <div>
                                <span>Trả góp 0% qua thẻ tín dụng</span>
                                <span>Miễn phí giao nội thành cho đơn từ 10 triệu</span>
                                <span>Xuất VAT nhanh cho doanh nghiệp</span>
                            </div>
                        </div>

                        <c:if test="${not empty product.shortDesc}">
                            <p class="ls-pd__short"><c:out value="${product.shortDesc}" /></p>
                        </c:if>

                        <div class="ls-pd__specs">
                            <div class="ls-pd__spec"><span class="ls-pd__spec-label"><i class="bi bi-cpu"></i> CPU</span><span class="ls-pd__spec-value">Intel Core i7</span></div>
                            <div class="ls-pd__spec"><span class="ls-pd__spec-label"><i class="bi bi-memory"></i> RAM</span><span class="ls-pd__spec-value">16 GB DDR5</span></div>
                            <div class="ls-pd__spec"><span class="ls-pd__spec-label"><i class="bi bi-hdd"></i> SSD</span><span class="ls-pd__spec-value">512 GB NVMe</span></div>
                            <div class="ls-pd__spec"><span class="ls-pd__spec-label"><i class="bi bi-display"></i> Màn hình</span><span class="ls-pd__spec-value">15.6" FHD</span></div>
                        </div>
                    </div>

                    <aside class="ls-pd__buy-panel" aria-label="Mua sản phẩm">
                        <div class="ls-pd__delivery-box">
                            <h2>Chọn hình thức nhận hàng</h2>
                            <label class="is-active"><input type="radio" name="deliveryMethod" checked /> Giao tận nơi <span>Miễn phí nội thành</span></label>
                            <label><input type="radio" name="deliveryMethod" /> Nhận tại cửa hàng <span>Giữ máy trong 24h</span></label>
                        </div>

                        <div class="ls-buy-box">
                            <div class="ui-qty">
                                <button type="button" class="ui-qty__btn" data-act="minus" aria-label="Giảm số lượng"><i class="bi bi-dash"></i></button>
                                <input type="text" class="ui-qty__input" value="1" data-cart-detail-index="0" id="cartDetails0.quantity" />
                                <button type="button" class="ui-qty__btn" data-act="plus" aria-label="Tăng số lượng"><i class="bi bi-plus"></i></button>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <input type="hidden" value="${product.id}" name="id" />
                            <button type="button" data-product-id="${product.id}" class="btnBuyNowDetail ui-btn ui-btn--danger ui-btn--lg" ${product.quantity le 0 ? 'disabled' : ''}>
                                <i class="bi bi-lightning-charge-fill"></i>
                                Mua ngay
                            </button>
                            <button type="button" data-product-id="${product.id}" class="btnAddToCartDetail ui-btn ui-btn--outline ui-btn--lg" ${product.quantity le 0 ? 'disabled' : ''}>
                                <i class="bi bi-bag-plus"></i>
                                Thêm vào giỏ
                            </button>
                        </div>

                        <div class="ls-pd__support-list">
                            <div><i class="bi bi-truck"></i><strong>Giao nhanh 2h</strong><span>Nội thành Hà Nội</span></div>
                            <div><i class="bi bi-shield-check"></i><strong>Bảo hành 12 tháng</strong><span>Hỗ trợ chính hãng</span></div>
                            <div><i class="bi bi-headset"></i><strong>Tư vấn miễn phí</strong><span>Chọn cấu hình phù hợp</span></div>
                        </div>
                    </aside>
                </div>

                <div class="ls-pd-tabs" data-tabs>
                    <div class="ls-tabs" role="tablist">
                        <button class="ls-tab is-active" data-tab="desc" role="tab">Mô tả</button>
                        <button class="ls-tab" data-tab="specs" role="tab">Thông số</button>
                        <button class="ls-tab" data-tab="reviews" role="tab">Đánh giá</button>
                        <button class="ls-tab" data-tab="warranty" role="tab">Bảo hành</button>
                    </div>
                    <div class="ui-card" data-tab-panel="desc">
                        <div class="ls-rich-text">
                            <c:choose>
                                <c:when test="${not empty product.detailDesc}"><c:out value="${product.detailDesc}" /></c:when>
                                <c:otherwise><em>Chưa có mô tả chi tiết cho sản phẩm này.</em></c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="ui-card" data-tab-panel="specs" hidden>
                        <table class="ui-table">
                            <tbody>
                                <tr><td><strong>Hãng sản xuất</strong></td><td><c:out value="${product.factory}" /></td></tr>
                                <tr><td><strong>Mục đích</strong></td><td><c:out value="${product.target}" /></td></tr>
                                <tr><td><strong>CPU</strong></td><td>Intel Core i7 / AMD Ryzen 7</td></tr>
                                <tr><td><strong>RAM</strong></td><td>16 GB DDR5</td></tr>
                                <tr><td><strong>Ổ cứng</strong></td><td>512 GB NVMe SSD</td></tr>
                                <tr><td><strong>Màn hình</strong></td><td>15.6" FHD 144Hz</td></tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="ui-card" data-tab-panel="reviews" hidden>
                        <div class="ui-empty">
                            <div class="ui-empty__icon"><i class="bi bi-chat-left-text"></i></div>
                            <p class="ui-empty__title">Chưa có đánh giá</p>
                            <p class="ui-empty__desc">Hãy là người đầu tiên đánh giá sản phẩm này!</p>
                        </div>
                    </div>
                    <div class="ui-card" data-tab-panel="warranty" hidden>
                        <ul class="ls-policy-list">
                            <li>Bảo hành chính hãng 12 tháng tại các trung tâm trên toàn quốc.</li>
                            <li>Đổi mới trong 7 ngày nếu có lỗi từ nhà sản xuất.</li>
                            <li>Hỗ trợ kỹ thuật miễn phí trọn đời sản phẩm.</li>
                            <li>1 đổi 1 trong 30 ngày đầu tiên với lỗi phần cứng xác nhận được.</li>
                        </ul>
                    </div>
                </div>

                <c:if test="${not empty relatedProducts}">
                    <section class="ls-related-products" aria-labelledby="related-products-title">
                        <div class="ls-retail-section-head">
                            <div>
                                <span>Gợi ý thêm</span>
                                <h2 id="related-products-title">Sản phẩm tương tự</h2>
                            </div>
                            <a href="/products?factory=${fn:escapeXml(product.factory)}">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                        </div>
                        <div class="ls-prod-grid">
                            <c:forEach var="p" items="${relatedProducts}">
                                <c:set var="product" value="${p}" scope="request" />
                                <jsp:include page="/WEB-INF/view/fragments/product-card.jsp" />
                            </c:forEach>
                        </div>
                    </section>
                </c:if>
            </div>
        </section>
    </main>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
    <script src="/client/js/main.js"></script>
    <script type="application/ld+json">
        ${productJsonLd}
    </script>

    <script>
        document.querySelectorAll('.ls-pd__thumb').forEach(t => {
            t.addEventListener('click', () => {
                document.querySelectorAll('.ls-pd__thumb').forEach(x => x.classList.remove('is-active'));
                t.classList.add('is-active');
                document.getElementById('pdMainImg').src = t.src;
            });
        });
    </script>
</body>

</html>
