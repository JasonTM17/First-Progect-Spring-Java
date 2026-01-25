(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);


    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow');
            } else {
                $('.fixed-top').removeClass('shadow');
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow').css('top', 0);
            } else {
                $('.fixed-top').removeClass('shadow').css('top', 0);
            }
        }
    });



    // Back to top button
    let isScrollingToTop = false;

    $(window).scroll(function () {
        if (isScrollingToTop) return;

        const scrollTop = $(this).scrollTop();
        const $btn = $('.back-to-top');

        if (scrollTop > 300) {
            if (!$btn.is(':visible')) {
                $btn.stop(true, true).fadeIn(250);
            }
        } else {
            if ($btn.is(':visible')) {
                $btn.stop(true, true).fadeOut(250);
            }
        }
    });

    $('.back-to-top').click(function () {
        isScrollingToTop = true;
        const $btn = $(this);
        $btn.stop(true, true).fadeOut(200);
        $('html, body').stop(true).animate(
            { scrollTop: 0 },
            1000,
            'swing',
            function () {
                isScrollingToTop = false;
            }
        );

        return false;
    });





    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 1
            },
            992: {
                items: 2
            },
            1200: {
                items: 2
            }
        }
    });


    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });


    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $('.btn-play').click(function () {
            $videoSrc = $(this).data("src");
        });
        console.log($videoSrc);

        $('#videoModal').on('shown.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
        })

        $('#videoModal').on('hide.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc);
        })

        const navElement = $("#navbarCollapse");
        const currentUrl = window.location.pathname;

        navElement.find("a.nav-link").each(function () {
            const link = $(this);
            const href = link.attr("href");

            if (href === currentUrl) {
                link.addClass("active");
            } else {
                link.removeClass("active");
            }
        });
    });


    $('.quantity button').on('click', function () {
        let change = 0;

        var button = $(this);
        var oldValue = button.parent().parent().find('input').val();
        let newVal;

        if (button.hasClass('btn-plus')) {
            newVal = parseFloat(oldValue) + 1;
            change = 1;
        } else {
            if (oldValue > 1) {
                newVal = parseFloat(oldValue) - 1;
                change = -1;
            } else {
                newVal = 1;
            }
        }

        const input = button.parent().parent().find('input');
        input.val(newVal);

        // set form index
        const index = input.attr("data-cart-detail-index");
        const el = document.getElementById(`cartDetails${index}.quantity`);
        $(el).val(newVal);


        // get price & id
        const price = input.attr("data-cart-detail-price");
        const id = input.attr("data-cart-detail-id");

        // update item price
        const priceElement = $(`p[data-cart-detail-id='${id}']`);
        if (priceElement) {
            const newPrice = (+price) * newVal;
            priceElement.text(formatCurrency(newPrice.toFixed(2)) + " đ");
        }

        // update total cart price
        const totalPriceElement = $('p[data-cart-total-price]');

        if (totalPriceElement && totalPriceElement.length) {
            const currentTotal = totalPriceElement.first().attr("data-cart-total-price");
            let newTotal = +currentTotal;
            if (change === 0) {
                newTotal = +currentTotal;
            } else {
                newTotal = change * (+price) + (+currentTotal);
            }

            // reset change
            change = 0;
            // update all total price elements
            totalPriceElement?.each(function (index, element) {
                // update text
                $(totalPriceElement[index]).text(formatCurrency(newTotal.toFixed(2)) + " đ");

                // update data attribute
                $(totalPriceElement[index]).attr("data-cart-total-price", newTotal);
            });
        }


    });


    function formatCurrency(value) {
        // Use the 'vi-VN' locale to format the number according to Vietnamese currency format
        // and 'VND' as the currency type for Vietnamese đồng
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'decimal',
            minimumFractionDigits: 0, // No decimal part for whole numbers
        });

        let formatted = formatter.format(value);
        // Replace dots with commas for thousands separator
        formatted = formatted.replace(/\./g, ',');
        return formatted;
    }

    // handle filter products
    $('#btnFilter').click(function (event) {
        event.preventDefault();

        const params = new URLSearchParams(window.location.search);


        params.set('page', '1');


        params.delete('factory');
        $('#factoryFilter .form-check-input:checked').each(function () {
            params.append('factory', $(this).val());
        });


        params.delete('target');
        $('#targetFilter .form-check-input:checked').each(function () {
            params.append('target', $(this).val());
        });


        params.delete('price');
        $('#priceFilter .form-check-input:checked').each(function () {
            params.append('price', $(this).val());
        });


        const sort = $('input[name="radio-sort"]:checked').val();
        if (sort) {
            params.set('sort', sort);
        } else {
            params.delete('sort');
        }


        window.location.href = window.location.pathname + '?' + params.toString();
    });


    $(function () {

        const params = new URLSearchParams(window.location.search);


        const factories = params.getAll('factory');
        $('#factoryFilter .form-check-input').each(function () {
            if (factories.includes($(this).val())) {
                $(this).prop('checked', true);
            }
        });


        const targets = params.getAll('target');
        $('#targetFilter .form-check-input').each(function () {
            if (targets.includes($(this).val())) {
                $(this).prop('checked', true);
            }
        });


        const prices = params.getAll('price');
        $('#priceFilter .form-check-input').each(function () {
            if (prices.includes($(this).val())) {
                $(this).prop('checked', true);
            }
        });


        const sort = params.get('sort');
        if (sort) {
            $('input[name="radio-sort"][value="' + sort + '"]')
                .prop('checked', true);
        }
    });


    function isLogin() {
        const navElement = $("#navbarCollapse");
        const childLogin = navElement.find("a.a-login");
        if (childLogin.length > 0) {
            return false;
        }
        return true;
    }

    $(document).on("click", ".btnAddToCartHomepage", function (event) {
        event.preventDefault();

        if (!isLogin()) {
            $.toast({
                heading: "Lỗi thao tác",
                text: "Bạn cần đăng nhập tài khoản",
                position: "top-right",
                icon: "error"
            });
            return;
        }

        const productId = $(this).attr("data-product-id");
        const token = $('meta[name="_csrf"]').attr("content");
        const header = $('meta[name="_csrf_header"]').attr("content");

        $.ajax({
            url: `${window.location.origin}/api/add-product-to-cart`,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                productId: productId,
                quantity: 1
            }),
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function (response) {
                const sum = +response;
                $("#sumCart").text(sum);

                $.toast({
                    heading: "Giỏ hàng",
                    text: "Thêm sản phẩm vào giỏ hàng thành công",
                    position: "top-right",
                    icon: "success"
                });
            },
            error: function (response) {
                alert("Có lỗi xảy ra, check code đi ba :v");
                console.log("error:", response);
            }
        });
    });


    $(document).on("click", ".btnAddToCartDetail", function (event) {
        event.preventDefault();

        if (!isLogin()) {
            $.toast({
                heading: "Lỗi thao tác",
                text: "Bạn cần đăng nhập tài khoản",
                position: "top-right",
                icon: "error"
            });
            return;
        }

        const productId = $(this).attr("data-product-id");
        const quantity = $("#cartDetails0\\.quantity").val();
        const token = $('meta[name="_csrf"]').attr("content");
        const header = $('meta[name="_csrf_header"]').attr("content");

        $.ajax({
            url: `${window.location.origin}/api/add-product-to-cart`,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                productId: productId,
                quantity: quantity
            }),
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function (response) {
                const sum = +response;
                $("#sumCart").text(sum);

                $.toast({
                    heading: "Giỏ hàng",
                    text: "Thêm sản phẩm vào giỏ hàng thành công",
                    position: "top-right",
                    icon: "success"
                });
            },
            error: function (response) {
                alert("Có lỗi xảy ra, check code đi ba :v");
                console.log("error:", response);
            }
        });
    });

})(jQuery);

