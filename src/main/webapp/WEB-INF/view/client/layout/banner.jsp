<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="ls-hero">
    <div class="ui-container">
        <div class="ls-retail-hero">
            <aside class="ls-retail-menu" aria-label="Danh mục laptop">
                <a href="/products?factory=APPLE"><i class="bi bi-apple"></i><span>MacBook</span><i class="bi bi-chevron-right"></i></a>
                <a href="/products?factory=ASUS"><i class="bi bi-laptop"></i><span>Laptop Asus</span><i class="bi bi-chevron-right"></i></a>
                <a href="/products?factory=DELL"><i class="bi bi-pc-display"></i><span>Laptop Dell</span><i class="bi bi-chevron-right"></i></a>
                <a href="/products?factory=LENOVO"><i class="bi bi-display"></i><span>Lenovo</span><i class="bi bi-chevron-right"></i></a>
                <a href="/products?target=GAMING"><i class="bi bi-controller"></i><span>Gaming hiệu năng cao</span><i class="bi bi-chevron-right"></i></a>
                <a href="/products?target=SINHVIEN-VANPHONG"><i class="bi bi-briefcase"></i><span>Học tập - văn phòng</span><i class="bi bi-chevron-right"></i></a>
                <a href="/products?target=THIET-KE-DO-HOA"><i class="bi bi-brush"></i><span>Đồ họa - kỹ thuật</span><i class="bi bi-chevron-right"></i></a>
                <a href="/products?price=duoi-10-trieu"><i class="bi bi-tags"></i><span>Laptop giá tốt</span><i class="bi bi-chevron-right"></i></a>
            </aside>

            <div id="lsHeroCarousel" class="carousel slide ls-retail-slider" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <a href="/products" class="ls-promo-slide ls-promo-slide--red">
                            <div>
                                <span class="ls-promo-slide__eyebrow">Laptopshop Sale</span>
                                <h1>Tuần lễ laptop chính hãng</h1>
                                <p>Giảm sốc đến 20%, trả góp 0%, giao nhanh 2h tại nội thành.</p>
                                <span class="ls-promo-slide__cta">Mua ngay <i class="bi bi-arrow-right"></i></span>
                            </div>
                            <img src="/client/img/hero-img-1.png" alt="Laptop khuyến mãi" />
                        </a>
                    </div>
                    <div class="carousel-item">
                        <a href="/products?target=GAMING" class="ls-promo-slide ls-promo-slide--dark">
                            <div>
                                <span class="ls-promo-slide__eyebrow">Gaming Zone</span>
                                <h1>Laptop gaming hiệu năng mạnh</h1>
                                <p>RTX, màn 144Hz, tản nhiệt tốt, sẵn hàng nhiều phân khúc.</p>
                                <span class="ls-promo-slide__cta">Xem cấu hình <i class="bi bi-arrow-right"></i></span>
                            </div>
                            <img src="/client/img/hero-img-3.png" alt="Laptop gaming" />
                        </a>
                    </div>
                    <div class="carousel-item">
                        <a href="/products?factory=APPLE" class="ls-promo-slide ls-promo-slide--gold">
                            <div>
                                <span class="ls-promo-slide__eyebrow">MacBook Deal</span>
                                <h1>MacBook mỏng nhẹ, pin bền</h1>
                                <p>Ưu đãi thêm cho học sinh sinh viên và khách hàng doanh nghiệp.</p>
                                <span class="ls-promo-slide__cta">Xem MacBook <i class="bi bi-arrow-right"></i></span>
                            </div>
                            <img src="/client/img/hero-img-2.png" alt="MacBook ưu đãi" />
                        </a>
                    </div>
                </div>
                <div class="carousel-indicators ls-retail-slider__dots">
                    <button type="button" data-bs-target="#lsHeroCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Khuyến mãi laptop"></button>
                    <button type="button" data-bs-target="#lsHeroCarousel" data-bs-slide-to="1" aria-label="Gaming zone"></button>
                    <button type="button" data-bs-target="#lsHeroCarousel" data-bs-slide-to="2" aria-label="MacBook deal"></button>
                </div>
            </div>

            <aside class="ls-hero-deals" aria-label="Ưu đãi nổi bật">
                <a href="/products?price=duoi-10-trieu&price=10-toi-15-trieu" class="ls-mini-deal">
                    <span>Deal hôm nay</span>
                    <strong>Laptop văn phòng từ 10 triệu</strong>
                    <small>Quà tặng balo + chuột không dây</small>
                </a>
                <a href="/products?target=GAMING" class="ls-mini-deal ls-mini-deal--dark">
                    <span>Trả góp 0%</span>
                    <strong>Gaming laptop sẵn hàng</strong>
                    <small>Duyệt hồ sơ nhanh trong ngày</small>
                </a>
                <a href="/about" class="ls-mini-deal ls-mini-deal--light">
                    <span>Cam kết</span>
                    <strong>Chính hãng, bảo hành rõ ràng</strong>
                    <small>Đổi trả 7 ngày nếu lỗi nhà sản xuất</small>
                </a>
            </aside>
        </div>

        <div class="ls-trust-strip">
            <div><i class="bi bi-patch-check-fill"></i><span>Chính hãng 100%</span></div>
            <div><i class="bi bi-truck"></i><span>Giao nhanh 2h</span></div>
            <div><i class="bi bi-credit-card"></i><span>Trả góp 0%</span></div>
            <div><i class="bi bi-arrow-repeat"></i><span>Đổi trả 7 ngày</span></div>
            <div><i class="bi bi-headset"></i><span>Tư vấn 24/7</span></div>
        </div>
    </div>
</section>
