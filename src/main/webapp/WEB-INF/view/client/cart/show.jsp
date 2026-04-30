<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Giỏ hàng - Laptopshop</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client">
    <jsp:include page="../layout/header.jsp" />

    <main>
        <section style="padding: var(--space-8) 0 var(--space-4); border-bottom: 1px solid var(--border); background: var(--bg-muted);">
            <div class="ui-container">
                <nav aria-label="breadcrumb">
                    <ol class="ui-breadcrumb">
                        <li><a href="/">Trang chủ</a></li>
                        <li class="active">Giỏ hàng</li>
                    </ol>
                </nav>

                <!-- Stepper -->
                <div class="ui-stepper" role="list">
                    <div class="ui-stepper__step is-active" role="listitem">
                        <div class="ui-stepper__dot">1</div>
                        <div class="ui-stepper__label">
                            <div class="ui-stepper__label-main">Giỏ hàng</div>
                            <div class="ui-stepper__label-sub">Xem lại sản phẩm</div>
                        </div>
                    </div>
                    <div class="ui-stepper__bar"></div>
                    <div class="ui-stepper__step" role="listitem">
                        <div class="ui-stepper__dot">2</div>
                        <div class="ui-stepper__label">
                            <div class="ui-stepper__label-main">Giao hàng</div>
                            <div class="ui-stepper__label-sub">Địa chỉ nhận hàng</div>
                        </div>
                    </div>
                    <div class="ui-stepper__bar"></div>
                    <div class="ui-stepper__step" role="listitem">
                        <div class="ui-stepper__dot">3</div>
                        <div class="ui-stepper__label">
                            <div class="ui-stepper__label-main">Thanh toán</div>
                            <div class="ui-stepper__label-sub">Chọn phương thức</div>
                        </div>
                    </div>
                    <div class="ui-stepper__bar"></div>
                    <div class="ui-stepper__step" role="listitem">
                        <div class="ui-stepper__dot">4</div>
                        <div class="ui-stepper__label">
                            <div class="ui-stepper__label-main">Hoàn tất</div>
                            <div class="ui-stepper__label-sub">Đặt hàng thành công</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section style="padding: var(--space-8) 0;">
            <div class="ui-container">
                <c:if test="${not empty error}">
                    <div class="ui-alert ui-alert--danger" style="margin-bottom: var(--space-4);">
                        <i class="bi bi-exclamation-triangle"></i>
                        <div>${error}</div>
                    </div>
                </c:if>
                <c:choose>
                    <c:when test="${empty cartDetails}">
                        <div class="ui-empty" style="background: var(--surface); border-radius: var(--radius-lg); border: 1px solid var(--border); padding: var(--space-16) var(--space-4);">
                            <div class="ui-empty__icon" style="width: 120px; height: 120px; font-size: 48px;">
                                <i class="bi bi-bag-x"></i>
                            </div>
                            <p class="ui-empty__title">Giỏ hàng của bạn đang trống</p>
                            <p class="ui-empty__desc">Hãy tiếp tục khám phá và thêm sản phẩm vào giỏ nhé!</p>
                            <a href="/products" class="ui-btn ui-btn--lg" style="margin-top: var(--space-3);">
                                <i class="bi bi-arrow-left"></i>
                                Tiếp tục mua sắm
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-4">
                            <div class="col-lg-8">
                                <div class="ui-card" style="padding: 0;">
                                    <div style="padding: var(--space-4) var(--space-5); border-bottom: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center;">
                                        <h2 style="margin: 0; font-size: 1.125rem; font-weight: 700;">
                                            Sản phẩm <span style="color: var(--text-muted); font-weight: 500;">(${cartDetails.size()})</span>
                                        </h2>
                                        <a href="/products" class="ui-btn ui-btn--ghost ui-btn--sm">
                                            <i class="bi bi-plus-circle"></i>
                                            Thêm sản phẩm
                                        </a>
                                    </div>
                                    <div>
                                        <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">
                                            <div class="ls-cart-item">
                                                <img src="/images/product/${cartDetail.product.image}" class="ls-cart-item__img" alt="" />
                                                <div>
                                                    <a href="/product/${cartDetail.product.id}" class="ls-cart-item__name">
                                                        <c:out value="${cartDetail.product.name}" />
                                                    </a>
                                                    <div class="ls-cart-item__meta">
                                                        ${cartDetail.product.factory} · Bảo hành 12 tháng
                                                    </div>
                                                </div>
                                                <div class="ls-cart-item__price">
                                                    <fmt:formatNumber type="number" value="${cartDetail.product.price}" />₫
                                                </div>
                                                <div class="ui-qty">
                                                    <button type="button" class="ui-qty__btn btn-minus" data-act="minus" aria-label="Giảm"><i class="bi bi-dash"></i></button>
                                                    <input type="text"
                                                           class="ui-qty__input"
                                                           value="${cartDetail.quantity}"
                                                           data-cart-detail-id="${cartDetail.id}"
                                                           data-cart-detail-price="${cartDetail.price}"
                                                           data-cart-detail-index="${status.index}" />
                                                    <button type="button" class="ui-qty__btn btn-plus" data-act="plus" aria-label="Tăng"><i class="bi bi-plus"></i></button>
                                                </div>
                                                <div class="ls-cart-item__total" data-cart-detail-id="${cartDetail.id}">
                                                    <fmt:formatNumber type="number" value="${cartDetail.price * cartDetail.quantity}" />₫
                                                </div>
                                                <form method="post" action="/delete-cart-product/${cartDetail.id}" style="margin: 0;">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <button type="submit"
                                                            class="ui-iconbtn ui-iconbtn--danger"
                                                            data-confirm="Bạn có chắc muốn xoá sản phẩm này khỏi giỏ?"
                                                            data-confirm-title="Xoá sản phẩm"
                                                            aria-label="Xoá">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4">
                                <aside class="ls-cart-summary">
                                    <h3>Tổng đơn hàng</h3>

                                    <div class="ls-cart-summary__row">
                                        <span>Tạm tính</span>
                                        <strong data-cart-total-price="${totalPrice}">
                                            <fmt:formatNumber type="number" value="${totalPrice}" />₫
                                        </strong>
                                    </div>
                                    <div class="ls-cart-summary__row">
                                        <span>Phí vận chuyển</span>
                                        <strong style="color: var(--success-600);">Miễn phí</strong>
                                    </div>
                                    <div class="ls-cart-summary__row">
                                        <span>Khuyến mãi</span>
                                        <strong>0₫</strong>
                                    </div>
                                    <div class="ls-cart-voucher">
                                        <input type="text" aria-label="Mã giảm giá" placeholder="Nhập mã giảm giá" />
                                        <button type="button" class="ui-btn ui-btn--outline ui-btn--sm">Áp dụng</button>
                                    </div>
                                    <div class="ls-cart-summary__total">
                                        <span>Tổng cộng</span>
                                        <strong data-cart-total-price="${totalPrice}">
                                            <fmt:formatNumber type="number" value="${totalPrice}" />₫
                                        </strong>
                                    </div>

                                    <form:form action="/confirm-checkout" method="post" modelAttribute="cart" style="margin-top: var(--space-4);">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div style="display: none;">
                                            <c:forEach var="cartDetail" items="${cart.cartDetails}" varStatus="status">
                                                <form:input type="text" value="${cartDetail.id}" path="cartDetails[${status.index}].id" />
                                                <form:input type="text" value="${cartDetail.quantity}" path="cartDetails[${status.index}].quantity" />
                                            </c:forEach>
                                        </div>
                                        <button type="submit" class="ui-btn ui-btn--lg ui-btn--block">
                                            <i class="bi bi-credit-card"></i>
                                            Xác nhận thanh toán
                                        </button>
                                    </form:form>

                                    <div class="ls-cart-policy">
                                        <div><i class="bi bi-shield-check"></i><span>Thanh toán an toàn với SSL 256-bit</span></div>
                                        <div><i class="bi bi-truck"></i><span>Giao hàng miễn phí trong 2h nội thành</span></div>
                                        <div><i class="bi bi-arrow-repeat"></i><span>Đổi trả 7 ngày nếu lỗi nhà sản xuất</span></div>
                                    </div>
                                </aside>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
    <script src="/client/js/main.js"></script>
</body>

</html>
