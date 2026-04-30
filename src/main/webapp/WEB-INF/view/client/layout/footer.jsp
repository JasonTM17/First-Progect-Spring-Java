<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="ls-footer" id="lien-he">
    <div class="ui-container">
        <div class="ls-footer-hotline">
            <div>
                <strong>Tư vấn mua laptop</strong>
                <span>Gọi ngay để được chọn cấu hình phù hợp</span>
            </div>
            <a href="tel:0988888888"><i class="bi bi-telephone-fill"></i>0988 888 888</a>
            <a href="/products"><i class="bi bi-grid"></i>Xem sản phẩm</a>
        </div>

        <div class="ls-footer__grid">
            <div>
                <a href="/" class="ls-footer__brand">
                    <span class="ls-brand__icon"><i class="bi bi-laptop"></i></span>
                    Laptopshop
                </a>
                <p class="ls-footer__about">
                    Hệ thống bán laptop chính hãng, giá rõ ràng, tư vấn theo nhu cầu và hậu mãi có trách nhiệm.
                    Laptopshop theo đuổi trải nghiệm mua hàng nhanh, minh bạch và đáng tin cậy.
                </p>
                <div class="ls-footer__social">
                    <a href="/#lien-he" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
                    <a href="/#lien-he" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
                    <a href="/#lien-he" aria-label="Youtube"><i class="bi bi-youtube"></i></a>
                    <a href="/#lien-he" aria-label="Tiktok"><i class="bi bi-tiktok"></i></a>
                </div>
            </div>

            <div>
                <h5>Tổng đài hỗ trợ</h5>
                <ul>
                    <li><a href="/#lien-he">Mua hàng: 0988 888 888</a></li>
                    <li><a href="/#lien-he">Bảo hành: 0988 888 889</a></li>
                    <li><a href="/#lien-he">Kỹ thuật: 0988 888 887</a></li>
                    <li><a href="/order-history">Tra cứu đơn hàng</a></li>
                    <li><a href="/cart">Giỏ hàng của bạn</a></li>
                </ul>
            </div>

            <div>
                <h5>Chính sách</h5>
                <ul>
                    <li><a href="/about">About Laptopshop</a></li>
                    <li><a href="/about#bao-hanh">Chính sách bảo hành</a></li>
                    <li><a href="/about#doi-tra">Chính sách đổi trả</a></li>
                    <li><a href="/about#dieu-khoan">Điều khoản sử dụng</a></li>
                    <li><a href="/about#bao-mat">Chính sách bảo mật</a></li>
                </ul>
            </div>

            <div>
                <h5>Hệ thống cửa hàng</h5>
                <p class="ls-footer__about">Hà Nội, Việt Nam. Hỗ trợ giao nhanh nội thành và vận chuyển toàn quốc.</p>
                <form class="ls-footer__newsletter" data-newsletter-form>
                    <input type="email" name="newsletterEmail" placeholder="Nhập email nhận ưu đãi" aria-label="Email nhận ưu đãi" required />
                    <button type="submit" class="ui-btn"><i class="bi bi-send"></i></button>
                </form>
            </div>
        </div>

        <div class="ls-footer__bottom">
            <div>
                &copy; <c:out value="2026" /> Laptopshop by <a href="https://github.com/JasonTM17" target="_blank" rel="noopener">Nguyễn Sơn</a>. All rights reserved.
            </div>
            <div class="pay">
                Chấp nhận:
                <i class="bi bi-credit-card-2-front"></i>
                <i class="bi bi-paypal"></i>
                <i class="bi bi-wallet2"></i>
                <i class="bi bi-bank"></i>
            </div>
        </div>
    </div>
</footer>

<a href="#lsHeader" class="ui-fab" aria-label="Lên đầu trang"><i class="bi bi-arrow-up"></i></a>
