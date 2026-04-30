<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="__path" value="${requestScope['javax.servlet.forward.request_uri']}" />

<header class="ls-header ls-header--retail" id="lsHeader">
    <div class="ls-benefit-strip" aria-label="Cam kết mua hàng">
        <div class="ui-container ls-benefit-strip__inner">
            <span><i class="bi bi-patch-check-fill"></i> Chính hãng - Xuất VAT</span>
            <span><i class="bi bi-truck"></i> Giao nhanh 2h nội thành</span>
            <span><i class="bi bi-arrow-repeat"></i> Thu cũ đổi mới</span>
            <span><i class="bi bi-credit-card"></i> Trả góp 0%</span>
        </div>
    </div>

    <div class="ls-header__top">
        <div class="ls-header__inner">
            <button type="button" class="ls-category-trigger" data-category-toggle aria-label="Mở danh mục">
                <i class="bi bi-list"></i>
                <span>Danh mục</span>
            </button>

            <a href="/" class="ls-brand" aria-label="Laptopshop - Trang chủ">
                <span class="ls-brand__icon"><i class="bi bi-laptop"></i></span>
                <span>Laptopshop</span>
            </a>

            <button type="button" class="ls-location" aria-label="Khu vực mua hàng">
                <i class="bi bi-geo-alt-fill"></i>
                <span>
                    <small>Xem giá tại</small>
                    Hà Nội
                </span>
            </button>

            <form action="/products" method="get" class="ls-search" role="search">
                <i class="bi bi-search ls-search__icon" aria-hidden="true"></i>
                <input type="search" name="name" value="${fn:escapeXml(param.name)}" placeholder="Bạn cần tìm laptop gì hôm nay?" aria-label="Tìm kiếm sản phẩm" autocomplete="off" data-search-suggest-input />
                <button type="submit" class="ls-search__submit" aria-label="Tìm kiếm"><i class="bi bi-arrow-right"></i></button>
                <div class="ls-search-suggest" data-search-suggest hidden></div>
            </form>

            <div class="ls-header__actions">
                <a href="/#lien-he" class="ls-action-pill d-none d-xl-inline-flex">
                    <i class="bi bi-telephone-fill"></i>
                    <span>
                        <small>Gọi mua hàng</small>
                        0988 888 888
                    </span>
                </a>
                <a href="/order-history" class="ls-action-pill d-none d-lg-inline-flex">
                    <i class="bi bi-receipt-cutoff"></i>
                    <span>
                        <small>Tra cứu</small>
                        Đơn hàng
                    </span>
                </a>

                <c:choose>
                    <c:when test="${not empty pageContext.request.userPrincipal}">
                        <a href="/cart" class="ls-cart-btn" aria-label="Giỏ hàng">
                            <i class="bi bi-bag fs-5"></i>
                            <span>Giỏ hàng</span>
                            <strong class="ls-cart-btn__badge" id="sumCart">${empty sessionScope.sum ? 0 : sessionScope.sum}</strong>
                        </a>

                        <div class="ls-user-wrap" data-dd>
                            <button type="button" class="ls-user" data-dd-toggle aria-haspopup="true" aria-expanded="false">
                                <img class="ls-user__avatar" src="/images/avatar/${sessionScope.avatar}" alt="" onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.fullName}&background=d70018&color=fff'" />
                                <span class="d-none d-md-inline"><c:out value="${sessionScope.fullName}" /></span>
                                <i class="bi bi-chevron-down small"></i>
                            </button>
                            <div class="ls-user-dropdown" role="menu">
                                <div class="ls-user-card">
                                    <img src="/images/avatar/${sessionScope.avatar}" alt="" onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.fullName}&background=d70018&color=fff&size=144'" />
                                    <div class="ls-user-card__name"><c:out value="${sessionScope.fullName}" /></div>
                                    <span>Thành viên Laptopshop</span>
                                </div>
                                <a href="/account" class="ui-menu__item"><i class="bi bi-person-gear"></i>Quản lý tài khoản</a>
                                <a href="/order-history" class="ui-menu__item"><i class="bi bi-receipt"></i>Lịch sử mua hàng</a>
                                <a href="/cart" class="ui-menu__item"><i class="bi bi-bag"></i>Giỏ hàng</a>
                                <div class="ui-menu__divider"></div>
                                <form method="post" action="/logout" style="margin:0;">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="ui-menu__item ui-menu__item--danger"><i class="bi bi-box-arrow-right"></i>Đăng xuất</button>
                                </form>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="/login" class="ls-login-btn">
                            <i class="bi bi-person-circle"></i>
                            <span>Đăng nhập</span>
                        </a>
                    </c:otherwise>
                </c:choose>

                <button type="button" class="ls-mobile-toggle" data-category-toggle aria-label="Mở menu" aria-expanded="false">
                    <i class="bi bi-list fs-4"></i>
                </button>
            </div>
        </div>
    </div>

    <div class="ls-header__catbar">
        <div class="ui-container ls-header__catbar-inner">
            <nav class="ls-nav" id="lsPrimaryNav" aria-label="Primary">
                <a href="/" class="ls-nav__link ${__path eq '/' ? 'is-active' : ''}"><i class="bi bi-house"></i>Trang chủ</a>
                <a href="/products" class="ls-nav__link ${fn:startsWith(__path, '/product') ? 'is-active' : ''}"><i class="bi bi-grid"></i>Sản phẩm</a>
                <a href="/products?factory=APPLE" class="ls-nav__link">MacBook</a>
                <a href="/products?target=GAMING" class="ls-nav__link">Laptop Gaming</a>
                <a href="/products?target=SINHVIEN-VANPHONG" class="ls-nav__link">Văn phòng</a>
                <a href="/products?target=THIET-KE-DO-HOA" class="ls-nav__link">Đồ họa</a>
                <a href="/products?price=duoi-10-trieu&price=10-toi-15-trieu" class="ls-nav__link">Dưới 15 triệu</a>
                <a href="/about" class="ls-nav__link ${__path eq '/about' ? 'is-active' : ''}">About</a>
            </nav>
            <a href="/#lien-he" class="ls-catbar-support"><i class="bi bi-headset"></i>Hỗ trợ 24/7</a>
        </div>
    </div>

    <div class="ls-category-backdrop" data-category-close hidden></div>
    <aside class="ls-category-drawer" id="lsCategoryDrawer" aria-label="Danh mục nhanh" aria-hidden="true">
        <div class="ls-category-drawer__head">
            <strong>Danh mục sản phẩm</strong>
            <button type="button" class="ui-iconbtn" data-category-close aria-label="Đóng danh mục"><i class="bi bi-x-lg"></i></button>
        </div>
        <div class="ls-category-drawer__quick" aria-label="Liên kết tài khoản nhanh">
            <a href="/cart"><i class="bi bi-bag"></i><span>Giỏ hàng</span></a>
            <a href="/order-history"><i class="bi bi-receipt"></i><span>Tra cứu đơn</span></a>
            <c:choose>
                <c:when test="${not empty pageContext.request.userPrincipal}">
                    <a href="/account"><i class="bi bi-person-gear"></i><span>Tài khoản</span></a>
                </c:when>
                <c:otherwise>
                    <a href="/login"><i class="bi bi-person-circle"></i><span>Đăng nhập</span></a>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="ls-category-drawer__body">
            <a href="/products?factory=APPLE"><i class="bi bi-apple"></i><span>MacBook</span><small>Pin bền, mỏng nhẹ</small></a>
            <a href="/products?factory=ASUS"><i class="bi bi-laptop"></i><span>Laptop Asus</span><small>Gaming và văn phòng</small></a>
            <a href="/products?factory=DELL"><i class="bi bi-pc-display"></i><span>Laptop Dell</span><small>Bền bỉ, doanh nghiệp</small></a>
            <a href="/products?factory=LENOVO"><i class="bi bi-display"></i><span>Lenovo</span><small>ThinkPad, IdeaPad</small></a>
            <a href="/products?target=GAMING"><i class="bi bi-controller"></i><span>Laptop Gaming</span><small>RTX, màn 144Hz</small></a>
            <a href="/products?target=SINHVIEN-VANPHONG"><i class="bi bi-briefcase"></i><span>Văn phòng - học tập</span><small>Nhẹ, pin tốt</small></a>
            <a href="/products?target=THIET-KE-DO-HOA"><i class="bi bi-brush"></i><span>Đồ họa - kỹ thuật</span><small>Màn đẹp, cấu hình mạnh</small></a>
            <a href="/products?price=duoi-10-trieu"><i class="bi bi-tags"></i><span>Dưới 10 triệu</span><small>Tiết kiệm ngân sách</small></a>
        </div>
    </aside>
</header>
