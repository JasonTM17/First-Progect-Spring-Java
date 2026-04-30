<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>About Laptopshop - Hệ thống laptop chính hãng</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client">
    <jsp:include page="../layout/header.jsp" />

    <main>
        <section class="ls-about-hero">
            <div class="ui-container">
                <nav aria-label="breadcrumb">
                    <ol class="ui-breadcrumb">
                        <li><a href="/">Trang chủ</a></li>
                        <li class="active">About</li>
                    </ol>
                </nav>

                <div class="ls-about-hero__grid">
                    <div>
                        <span class="ui-kicker">About Laptopshop</span>
                        <h1>Hệ thống bán laptop chính hãng, tư vấn đúng nhu cầu và hậu mãi rõ ràng.</h1>
                        <p>
                            Laptopshop được xây dựng như một cửa hàng công nghệ hiện đại: giá bán minh bạch,
                            sản phẩm rõ nguồn gốc, quy trình giao hàng chặt chẽ và đội ngũ hỗ trợ đồng hành
                            trong suốt vòng đời thiết bị.
                        </p>
                        <div class="ls-about-hero__actions">
                            <a href="/products" class="ui-btn ui-btn--lg"><i class="bi bi-laptop"></i>Khám phá sản phẩm</a>
                            <a href="/#lien-he" class="ui-btn ui-btn--secondary ui-btn--lg"><i class="bi bi-chat-dots"></i>Liên hệ tư vấn</a>
                        </div>
                    </div>

                    <div class="ls-about-scoreboard" aria-label="Chỉ số vận hành">
                        <div class="ls-about-scoreboard__item"><strong><fmt:formatNumber value="${productCount}" type="number" /></strong><span>Sản phẩm đang quản lý</span></div>
                        <div class="ls-about-scoreboard__item"><strong><fmt:formatNumber value="${orderCount}" type="number" /></strong><span>Đơn hàng đã ghi nhận</span></div>
                        <div class="ls-about-scoreboard__item"><strong><fmt:formatNumber value="${userCount}" type="number" /></strong><span>Tài khoản khách hàng</span></div>
                        <div class="ls-about-scoreboard__item"><strong>30'</strong><span>Thời gian xác nhận đơn mục tiêu</span></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="ui-section">
            <div class="ui-container">
                <div class="ui-section-head">
                    <div>
                        <span class="ui-kicker">Điểm khác biệt</span>
                        <h2 class="ui-section-head__title">Mua laptop theo quy trình rõ ràng, không theo cảm tính.</h2>
                        <p class="ui-section-head__subtitle">
                            Từ tư vấn cấu hình tới bảo hành, mỗi bước đều giúp khách hàng biết mình đang mua gì,
                            vì sao phù hợp và cần hỗ trợ ở đâu sau khi nhận máy.
                        </p>
                    </div>
                </div>

                <div class="ls-about-values">
                    <article>
                        <div class="ui-iconbtn ui-iconbtn--primary"><i class="bi bi-patch-check"></i></div>
                        <h3>Chính hãng và minh bạch</h3>
                        <p>Thông tin cấu hình, giá, tồn kho, ưu đãi và bảo hành được trình bày rõ ràng trước khi khách đặt mua.</p>
                    </article>
                    <article>
                        <div class="ui-iconbtn ui-iconbtn--warn"><i class="bi bi-cpu"></i></div>
                        <h3>Tư vấn theo nhu cầu</h3>
                        <p>Đội ngũ hỗ trợ phân tích nhu cầu học tập, làm việc, đồ họa, lập trình hoặc gaming để đề xuất cấu hình hợp lý.</p>
                    </article>
                    <article>
                        <div class="ui-iconbtn ui-iconbtn--success"><i class="bi bi-shield-check"></i></div>
                        <h3>Kiểm tra trước khi giao</h3>
                        <p>Sản phẩm được kiểm tra ngoại hình, màn hình, bàn phím, pin, cổng kết nối và phụ kiện trước khi bàn giao.</p>
                    </article>
                    <article>
                        <div class="ui-iconbtn"><i class="bi bi-headset"></i></div>
                        <h3>Hậu mãi chủ động</h3>
                        <p>Laptopshop tiếp nhận hỗ trợ bảo hành, đổi trả, nâng cấp và hướng dẫn sử dụng trong suốt vòng đời thiết bị.</p>
                    </article>
                </div>
            </div>
        </section>

        <section class="ui-section">
            <div class="ui-container">
                <div class="ls-about-release">
                    <div class="ls-about-release__copy">
                        <span class="ui-kicker">Portfolio release</span>
                        <h2>Bản showcase v1.0: hoàn thiện trải nghiệm khách hàng, vận hành admin và tài liệu triển khai.</h2>
                        <p>
                            Laptopshop không chỉ là giao diện bán hàng. Dự án được đóng gói như một sản phẩm portfolio có thể demo đầu cuối:
                            dữ liệu mẫu, tài khoản reviewer, luồng mua hàng thật, dashboard vận hành, test tự động, Docker, CI và release notes rõ ràng.
                        </p>
                    </div>
                    <div class="ls-about-release__panel">
                        <div>
                            <strong>Release status</strong>
                            <span class="ls-about-release__status"><i class="bi bi-check-circle-fill"></i> Showcase-ready</span>
                        </div>
                        <ul>
                            <li><i class="bi bi-check2"></i> Storefront retail sắc đỏ, search autocomplete, wishlist local và buy-now thật.</li>
                            <li><i class="bi bi-check2"></i> Cart/checkout có validate số lượng, tồn kho, transactional order và order history.</li>
                            <li><i class="bi bi-check2"></i> Admin có metric thật, search/filter backend, CSV export và trạng thái đơn hàng được validate.</li>
                            <li><i class="bi bi-check2"></i> README, installation, deployment, testing, release notes và reviewer guide sẵn sàng cho GitHub.</li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <section class="ui-section" style="background: var(--bg-muted);">
            <div class="ui-container">
                <div class="ui-section-head">
                    <div>
                        <span class="ui-kicker">Hệ thống bán lẻ</span>
                        <h2 class="ui-section-head__title">Một trải nghiệm mua laptop rõ ràng từ online tới sau bán.</h2>
                        <p class="ui-section-head__subtitle">
                            Laptopshop mô phỏng đầy đủ các điểm chạm quan trọng của một hệ thống bán lẻ công nghệ:
                            tư vấn, giao nhận, xuất hóa đơn, bảo hành và hỗ trợ khách hàng tổ chức.
                        </p>
                    </div>
                </div>

                <div class="ls-about-store-grid">
                    <article>
                        <i class="bi bi-shop"></i>
                        <h3>Online-first</h3>
                        <p>Khách hàng có thể tìm kiếm, lọc sản phẩm, xem khuyến mãi, thêm giỏ hàng và theo dõi đơn ngay trên website.</p>
                    </article>
                    <article>
                        <i class="bi bi-building-check"></i>
                        <h3>Doanh nghiệp & giáo dục</h3>
                        <p>Hỗ trợ nhu cầu mua số lượng, xuất VAT, tư vấn cấu hình theo phòng ban, lớp học hoặc đội ngũ kỹ thuật.</p>
                    </article>
                    <article>
                        <i class="bi bi-tools"></i>
                        <h3>Hậu mãi kỹ thuật</h3>
                        <p>Quy trình tiếp nhận bảo hành, vệ sinh máy, nâng cấp RAM/SSD và tư vấn sử dụng được trình bày rõ ràng.</p>
                    </article>
                </div>
            </div>
        </section>

        <section class="ui-section">
            <div class="ui-container">
                <div class="ui-section-head">
                    <div>
                        <span class="ui-kicker">Dành cho reviewer</span>
                        <h2 class="ui-section-head__title">Những điểm nên kiểm tra khi đánh giá dự án.</h2>
                        <p class="ui-section-head__subtitle">
                            Các điểm dưới đây giúp người xem portfolio nhìn nhanh được phạm vi sản phẩm, chất lượng code và mức độ sẵn sàng triển khai.
                        </p>
                    </div>
                </div>

                <div class="ls-about-review-grid">
                    <article>
                        <i class="bi bi-window-stack"></i>
                        <h3>Product UX</h3>
                        <p>Header retail, catalog filter, product detail, cart, checkout, account và About được thiết kế đồng bộ theo một design system.</p>
                    </article>
                    <article>
                        <i class="bi bi-diagram-3"></i>
                        <h3>Business logic</h3>
                        <p>Luồng cart/order có validate, transaction, cập nhật tồn kho, sold count, API JSON error và clear 404 cho resource không tồn tại.</p>
                    </article>
                    <article>
                        <i class="bi bi-speedometer2"></i>
                        <h3>Admin operations</h3>
                        <p>Dashboard dùng dữ liệu thật, có low-stock list, revenue chart, order CSV, search/filter và validate chuyển trạng thái.</p>
                    </article>
                    <article>
                        <i class="bi bi-rocket-takeoff"></i>
                        <h3>Release readiness</h3>
                        <p>Profile local/prod, env vars, Docker, Render blueprint, health check, docs và automated tests giúp reviewer chạy app nhanh và tin cậy.</p>
                    </article>
                </div>
            </div>
        </section>

        <section class="ui-section" style="background: var(--bg-muted);">
            <div class="ui-container">
                <div class="ls-about-process">
                    <div>
                        <span class="ui-kicker">Quy trình phục vụ</span>
                        <h2>4 bước để một đơn laptop được xử lý chuyên nghiệp.</h2>
                        <p>
                            Quy trình này giúp giảm sai cấu hình, giảm rủi ro tồn kho và giúp khách hàng nhận máy đúng nhu cầu ngay từ lần đầu.
                        </p>
                    </div>
                    <ol>
                        <li><strong>Tiếp nhận nhu cầu</strong><span>Xác định ngân sách, tác vụ chính, yêu cầu màn hình, pin, trọng lượng và bảo hành.</span></li>
                        <li><strong>Đề xuất cấu hình</strong><span>So sánh các lựa chọn theo hiệu năng, độ bền, khả năng nâng cấp và chi phí sở hữu.</span></li>
                        <li><strong>Kiểm tra và đóng gói</strong><span>Rà tình trạng máy, phụ kiện, hóa đơn và thông tin giao hàng trước khi xuất kho.</span></li>
                        <li><strong>Theo dõi sau mua</strong><span>Hỗ trợ cài đặt ban đầu, bảo hành, đổi trả và tư vấn nâng cấp khi khách cần.</span></li>
                    </ol>
                </div>
            </div>
        </section>

        <section class="ui-section" id="chinh-sach">
            <div class="ui-container">
                <div class="ui-section-head">
                    <div>
                        <span class="ui-kicker">Chính sách dịch vụ</span>
                        <h2 class="ui-section-head__title">Các cam kết cốt lõi khi mua hàng tại Laptopshop.</h2>
                        <p class="ui-section-head__subtitle">
                            Những chính sách dưới đây được trình bày để khách hàng hiểu rõ quyền lợi trước khi đặt mua,
                            đồng thời giúp dự án thể hiện đầy đủ một quy trình bán lẻ laptop chuyên nghiệp.
                        </p>
                    </div>
                </div>

                <div class="ls-about-policy-grid">
                    <article id="bao-hanh">
                        <div class="ui-iconbtn ui-iconbtn--primary"><i class="bi bi-shield-check"></i></div>
                        <h3>Chính sách bảo hành</h3>
                        <ul class="ls-policy-list">
                            <li>Bảo hành tiêu chuẩn 12 tháng cho sản phẩm chính hãng theo điều kiện của nhà sản xuất.</li>
                            <li>Hỗ trợ kiểm tra lỗi phần cứng, phần mềm cơ bản và hướng dẫn quy trình gửi bảo hành.</li>
                            <li>Thông tin bảo hành, phụ kiện đi kèm và tình trạng sản phẩm được đối chiếu trước khi giao.</li>
                        </ul>
                    </article>
                    <article id="doi-tra">
                        <div class="ui-iconbtn ui-iconbtn--success"><i class="bi bi-arrow-repeat"></i></div>
                        <h3>Chính sách đổi trả</h3>
                        <ul class="ls-policy-list">
                            <li>Tiếp nhận đổi trả khi sản phẩm giao sai cấu hình, thiếu phụ kiện hoặc phát sinh lỗi theo điều kiện bảo hành.</li>
                            <li>Sản phẩm cần còn đầy đủ hộp, phụ kiện, hóa đơn và không có hư hại do người dùng gây ra.</li>
                            <li>Đội ngũ hỗ trợ sẽ kiểm tra tình trạng thực tế và phản hồi hướng xử lý minh bạch.</li>
                        </ul>
                    </article>
                    <article id="dieu-khoan">
                        <div class="ui-iconbtn ui-iconbtn--warn"><i class="bi bi-file-earmark-text"></i></div>
                        <h3>Điều khoản sử dụng</h3>
                        <ul class="ls-policy-list">
                            <li>Giá, tồn kho và khuyến mãi có thể thay đổi theo thời điểm xác nhận đơn hàng.</li>
                            <li>Khách hàng chịu trách nhiệm cung cấp đúng thông tin nhận hàng, số điện thoại và nhu cầu xuất hóa đơn.</li>
                            <li>Laptopshop có quyền từ chối đơn hàng bất thường, sai thông tin hoặc vượt quá khả năng đáp ứng tồn kho.</li>
                        </ul>
                    </article>
                    <article id="bao-mat">
                        <div class="ui-iconbtn"><i class="bi bi-lock"></i></div>
                        <h3>Chính sách bảo mật</h3>
                        <ul class="ls-policy-list">
                            <li>Thông tin tài khoản, địa chỉ giao hàng và lịch sử mua hàng chỉ dùng cho mục đích xử lý đơn và hỗ trợ khách hàng.</li>
                            <li>Mật khẩu được lưu dưới dạng mã hóa, không hiển thị trong giao diện quản trị hoặc log hệ thống.</li>
                            <li>Khách hàng có thể cập nhật thông tin cá nhân và đổi mật khẩu trong khu vực tài khoản.</li>
                        </ul>
                    </article>
                </div>
            </div>
        </section>

        <section class="ui-section">
            <div class="ui-container">
                <div class="ls-about-cta">
                    <div>
                        <span class="ui-kicker">Sẵn sàng chọn máy?</span>
                        <h2>Bắt đầu từ danh sách sản phẩm hoặc gửi nhu cầu để được tư vấn.</h2>
                        <p>Chúng tôi ưu tiên cấu hình phù hợp, giá hợp lý và trải nghiệm sau mua bền vững.</p>
                    </div>
                    <div class="ls-about-cta__actions">
                        <a href="/products" class="ui-btn ui-btn--lg"><i class="bi bi-grid"></i>Xem sản phẩm</a>
                        <a href="/#lien-he" class="ui-btn ui-btn--secondary ui-btn--lg"><i class="bi bi-telephone"></i>Nhận tư vấn</a>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <jsp:include page="../layout/footer.jsp" />
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
</body>

</html>
