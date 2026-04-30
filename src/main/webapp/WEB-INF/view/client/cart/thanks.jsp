<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Đặt hàng thành công - Laptopshop</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client">
    <jsp:include page="../layout/header.jsp" />

    <main>
        <section style="padding: var(--space-8) 0 var(--space-4); background: var(--bg-muted); border-bottom: 1px solid var(--border);">
            <div class="ui-container">
                <div class="ui-stepper" role="list" style="margin: 0;">
                    <div class="ui-stepper__step is-done"><div class="ui-stepper__dot"><i class="bi bi-check"></i></div><div class="ui-stepper__label"><div class="ui-stepper__label-main">Giỏ hàng</div></div></div>
                    <div class="ui-stepper__bar" style="background: var(--success-500);"></div>
                    <div class="ui-stepper__step is-done"><div class="ui-stepper__dot"><i class="bi bi-check"></i></div><div class="ui-stepper__label"><div class="ui-stepper__label-main">Giao hàng</div></div></div>
                    <div class="ui-stepper__bar" style="background: var(--success-500);"></div>
                    <div class="ui-stepper__step is-done"><div class="ui-stepper__dot"><i class="bi bi-check"></i></div><div class="ui-stepper__label"><div class="ui-stepper__label-main">Thanh toán</div></div></div>
                    <div class="ui-stepper__bar" style="background: var(--success-500);"></div>
                    <div class="ui-stepper__step is-active"><div class="ui-stepper__dot" style="background: var(--success-500);"><i class="bi bi-check"></i></div><div class="ui-stepper__label"><div class="ui-stepper__label-main">Hoàn tất</div></div></div>
                </div>
            </div>
        </section>

        <section style="padding: var(--space-12) 0;">
            <div class="ui-container" style="max-width: 720px;">
                <div class="ui-card ui-slide-up" style="padding: var(--space-12) var(--space-8); text-align: center;">
                    <div style="width: 120px; height: 120px; border-radius: 50%; background: linear-gradient(135deg, #d1fae5, #a7f3d0); display: inline-flex; align-items: center; justify-content: center; font-size: 56px; color: var(--success-600); margin-bottom: var(--space-5); box-shadow: 0 0 0 12px rgba(16, 185, 129, 0.12);">
                        <i class="bi bi-check2"></i>
                    </div>
                    <h1 style="font-size: 2rem; font-weight: 800; margin: 0 0 var(--space-3); color: var(--text);">Đặt hàng thành công!</h1>
                    <p style="font-size: 1rem; color: var(--text-muted); max-width: 480px; margin: 0 auto var(--space-6); line-height: 1.6;">
                        Cảm ơn bạn đã mua hàng tại <strong style="color: var(--text);">Laptopshop</strong>.
                        Đơn hàng của bạn đã được ghi nhận và sẽ được xử lý trong vòng 30 phút.
                        Chúng tôi sẽ liên hệ với bạn sớm nhất.
                    </p>
                    <div style="display: flex; gap: var(--space-3); justify-content: center; flex-wrap: wrap;">
                        <a href="/" class="ui-btn ui-btn--secondary ui-btn--lg">
                            <i class="bi bi-arrow-left"></i>
                            Về trang chủ
                        </a>
                        <a href="/order-history" class="ui-btn ui-btn--lg">
                            <i class="bi bi-receipt"></i>
                            Xem đơn hàng
                        </a>
                    </div>

                    <div style="margin-top: var(--space-8); padding-top: var(--space-5); border-top: 1px dashed var(--border); display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: var(--space-4); text-align: left;">
                        <div class="ui-row" style="align-items: flex-start;">
                            <div class="ui-iconbtn ui-iconbtn--primary"><i class="bi bi-telephone"></i></div>
                            <div>
                                <div style="font-weight: 600; font-size: 0.875rem;">Xác nhận đơn hàng</div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Chúng tôi sẽ gọi bạn trong 30'</div>
                            </div>
                        </div>
                        <div class="ui-row" style="align-items: flex-start;">
                            <div class="ui-iconbtn ui-iconbtn--warn"><i class="bi bi-box-seam"></i></div>
                            <div>
                                <div style="font-weight: 600; font-size: 0.875rem;">Đóng gói cẩn thận</div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Kiểm tra kỹ trước khi giao</div>
                            </div>
                        </div>
                        <div class="ui-row" style="align-items: flex-start;">
                            <div class="ui-iconbtn ui-iconbtn--success"><i class="bi bi-truck"></i></div>
                            <div>
                                <div style="font-weight: 600; font-size: 0.875rem;">Giao hàng nhanh</div>
                                <div style="font-size: 0.75rem; color: var(--text-muted);">Trong vòng 2h nội thành</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
</body>

</html>
