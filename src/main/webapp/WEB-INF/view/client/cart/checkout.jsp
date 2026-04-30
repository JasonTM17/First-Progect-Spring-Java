<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Thanh toán - Laptopshop</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client">
    <jsp:include page="../layout/header.jsp" />

    <main class="ls-checkout-page">
        <section class="ls-checkout-head">
            <div class="ui-container">
                <nav aria-label="breadcrumb">
                    <ol class="ui-breadcrumb">
                        <li><a href="/">Trang chủ</a></li>
                        <li><a href="/cart">Giỏ hàng</a></li>
                        <li class="active">Thanh toán</li>
                    </ol>
                </nav>
                <div class="ui-stepper" role="list">
                    <div class="ui-stepper__step is-done"><div class="ui-stepper__dot"><i class="bi bi-check"></i></div><div class="ui-stepper__label"><div class="ui-stepper__label-main">Giỏ hàng</div></div></div>
                    <div class="ui-stepper__bar"></div>
                    <div class="ui-stepper__step is-active"><div class="ui-stepper__dot">2</div><div class="ui-stepper__label"><div class="ui-stepper__label-main">Giao hàng</div></div></div>
                    <div class="ui-stepper__bar"></div>
                    <div class="ui-stepper__step"><div class="ui-stepper__dot">3</div><div class="ui-stepper__label"><div class="ui-stepper__label-main">Thanh toán</div></div></div>
                    <div class="ui-stepper__bar"></div>
                    <div class="ui-stepper__step"><div class="ui-stepper__dot">4</div><div class="ui-stepper__label"><div class="ui-stepper__label-main">Hoàn tất</div></div></div>
                </div>
            </div>
        </section>

        <section class="ls-checkout-body">
            <div class="ui-container">
                <c:if test="${not empty error}">
                    <div class="ui-alert ui-alert--danger" style="margin-bottom: var(--space-4);">
                        <i class="bi bi-exclamation-triangle"></i>
                        <div>${error}</div>
                    </div>
                </c:if>
                <c:choose>
                    <c:when test="${empty cartDetails}">
                        <div class="ui-empty"><p class="ui-empty__title">Không có sản phẩm để thanh toán</p>
                            <a href="/products" class="ui-btn">Tiếp tục mua sắm</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <form:form action="/place-order" method="post" modelAttribute="checkoutDTO">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <div class="ls-checkout">
                                <div class="ls-checkout__main">
                                    <div class="ui-card ls-checkout-card">
                                        <h3>
                                            <i class="bi bi-geo-alt"></i>
                                            Thông tin người nhận
                                        </h3>
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="ui-label">Họ và tên <span>*</span></label>
                                                <form:input class="ui-input" path="receiverName" placeholder="Nguyễn Văn A" required="true" />
                                                <form:errors path="receiverName" cssClass="text-danger small" />
                                            </div>
                                            <div class="col-md-6">
                                                <label class="ui-label">Số điện thoại <span>*</span></label>
                                                <form:input class="ui-input" path="receiverPhone" type="tel" placeholder="0988 888 888" pattern="[0-9]{9,11}" required="true" />
                                                <form:errors path="receiverPhone" cssClass="text-danger small" />
                                            </div>
                                            <div class="col-12">
                                                <label class="ui-label">Địa chỉ nhận hàng <span>*</span></label>
                                                <form:input class="ui-input" path="receiverAddress" placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố" required="true" />
                                                <form:errors path="receiverAddress" cssClass="text-danger small" />
                                                <p class="ui-help">Địa chỉ sẽ dùng để giao hàng, hãy điền đầy đủ nhé.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="ui-card ls-checkout-card">
                                        <h3>
                                            <i class="bi bi-credit-card"></i>
                                            Phương thức thanh toán
                                        </h3>
                                        <div class="ls-payment-tiles">
                                            <label class="ls-payment-tile is-active">
                                                <form:radiobutton path="paymentMethod" value="COD" class="form-check-input" />
                                                <div>
                                                    <strong>Thanh toán khi nhận hàng</strong>
                                                    <span>COD - Trả tiền mặt khi nhận</span>
                                                </div>
                                            </label>
                                            <label class="ls-payment-tile">
                                                <form:radiobutton path="paymentMethod" value="BANK" class="form-check-input" />
                                                <div>
                                                    <strong>Chuyển khoản ngân hàng</strong>
                                                    <span>Nhân viên xác nhận thông tin sau khi đặt</span>
                                                </div>
                                            </label>
                                        </div>
                                        <form:errors path="paymentMethod" cssClass="text-danger small" />
                                    </div>

                                    <div class="ls-checkout-back">
                                        <a href="/cart" class="ui-btn ui-btn--ghost"><i class="bi bi-arrow-left"></i> Quay lại giỏ hàng</a>
                                    </div>
                                </div>

                                <div class="ls-checkout__side">
                                    <aside class="ls-cart-summary">
                                        <h3>Đơn hàng của bạn</h3>
                                        <div class="ls-checkout-items">
                                            <c:forEach var="cd" items="${cartDetails}">
                                                <div class="ls-checkout-item">
                                                    <img src="/images/product/${cd.product.image}" alt="" />
                                                    <div>
                                                        <strong>
                                                            <c:out value="${cd.product.name}" />
                                                        </strong>
                                                        <span>x${cd.quantity}</span>
                                                    </div>
                                                    <b>
                                                        <fmt:formatNumber type="number" value="${cd.product.price * cd.quantity}" />₫
                                                    </b>
                                                </div>
                                            </c:forEach>
                                        </div>

                                        <div class="ls-cart-voucher">
                                            <input type="text" value="LAPTOPSHOP" aria-label="Mã ưu đãi" />
                                            <button type="button">Áp dụng</button>
                                        </div>

                                        <div class="ls-cart-summary__row"><span>Tạm tính</span><strong><fmt:formatNumber type="number" value="${totalPrice}" />₫</strong></div>
                                        <div class="ls-cart-summary__row"><span>Vận chuyển</span><strong class="text-success">Miễn phí</strong></div>
                                        <div class="ls-cart-summary__total">
                                            <span>Tổng cộng</span>
                                            <strong><fmt:formatNumber type="number" value="${totalPrice}" />₫</strong>
                                        </div>

                                        <button type="submit" class="ui-btn ui-btn--lg ui-btn--block" style="margin-top: var(--space-4);">
                                            <i class="bi bi-lock-fill"></i>
                                            Đặt hàng
                                        </button>
                                        <div class="ls-cart-policy">
                                            <div><i class="bi bi-shield-check"></i><span>Thông tin đơn hàng được bảo mật.</span></div>
                                            <div><i class="bi bi-truck"></i><span>Giao nhanh nội thành, kiểm tra trước khi nhận.</span></div>
                                            <div><i class="bi bi-receipt"></i><span>Hỗ trợ xuất VAT và theo dõi đơn hàng.</span></div>
                                        </div>
                                    </aside>
                                </div>
                            </div>
                        </form:form>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
</body>

</html>
