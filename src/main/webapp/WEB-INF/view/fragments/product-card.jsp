<%--
    Product card fragment.
    Expects a request-scope attribute named 'product'.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="oldPrice" value="${product.price * 1.08}" />

<article class="ui-pcard ui-pcard--retail">
    <div class="ui-pcard__media">
        <a href="/product/${product.id}" aria-label="Xem chi tiết ${product.name}">
            <img src="/images/product/${product.image}" alt="${product.name}" class="ui-pcard__img" loading="lazy" />
        </a>
        <div class="ui-pcard__badges">
            <span class="ui-pcard__badge">Giảm 8%</span>
            <span class="ui-pcard__installment">Trả góp 0%</span>
        </div>
        <button type="button"
                class="ui-pcard__wish"
                aria-label="Lưu sản phẩm yêu thích"
                data-wishlist-toggle
                data-product-id="${product.id}"
                data-product-name="${product.name}">
            <i class="bi bi-heart"></i>
        </button>
    </div>
    <div class="ui-pcard__body">
        <div class="ui-pcard__meta">
            <c:if test="${not empty product.factory}">
                <span class="ui-pcard__brand">${product.factory}</span>
            </c:if>
            <span class="ui-pcard__stock"><i class="bi bi-check-circle-fill"></i> Còn hàng</span>
        </div>
        <h3 class="ui-pcard__name">
            <a href="/product/${product.id}"><c:out value="${product.name}" /></a>
        </h3>
        <div class="ui-pcard__specs">
            <span>RAM 16GB</span>
            <span>SSD 512GB</span>
            <span>Bảo hành 12T</span>
        </div>
        <div class="ui-pcard__promo">
            <i class="bi bi-gift"></i>
            Tặng balo + vệ sinh máy miễn phí 12 tháng
        </div>
        <div class="ui-pcard__price-row">
            <div class="ui-pcard__prices">
                <div class="ui-pcard__price">
                    <fmt:formatNumber type="number" value="${product.price}" />₫
                </div>
                <div class="ui-pcard__old">
                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${oldPrice}" />₫
                </div>
            </div>
            <button type="button"
                    data-product-id="${product.id}"
                    class="btnAddToCartHomepage ui-iconbtn ui-iconbtn--primary"
                    aria-label="Thêm vào giỏ hàng">
                <i class="bi bi-bag-plus"></i>
            </button>
        </div>
        <div class="ui-pcard__rating" aria-label="Đánh giá 4.8 sao">
            <span class="ui-pcard__stars">
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-half"></i>
            </span>
            <span>4.8 · Đã bán ${product.sold}</span>
        </div>
    </div>
</article>
