<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <title>Lịch sử mua hàng - Laptopshop</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">

                <!-- Google Fonts (GIỐNG SITE GỐC) -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <!-- Font Awesome (ICON USER + CART) -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />

                <!-- Bootstrap Icons -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Bootstrap CSS -->
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                <!-- Main Client Style -->
                <link href="/client/css/style.css" rel="stylesheet">
            </head>

            <body>

                <!-- HEADER CLIENT (QUAN TRỌNG) -->
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid py-5">
                    <div class="container py-5">

                        <!-- Breadcrumb -->
                        <nav aria-label="breadcrumb" class="mb-4">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="/" class="text-success">Home</a>
                                </li>
                                <li class="breadcrumb-item active">
                                    Lịch sử mua hàng
                                </li>
                            </ol>
                        </nav>

                        <div class="table-responsive">
                            <table class="table align-middle">

                                <!-- HEADER -->
                                <thead class="table-light">
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Tên</th>
                                        <th>Giá cả</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <c:forEach var="order" items="${orders}">

                                        <!-- ORDER HEADER -->
                                        <tr class="table-secondary fw-bold">
                                            <td colspan="2">
                                                <i class="fa fa-receipt me-2"></i>
                                                Order ID = ${order.id}
                                            </td>

                                            <td colspan="2">
                                                Tổng:
                                                <fmt:formatNumber value="${order.totalPrice}" type="number" /> đ
                                            </td>

                                            <td colspan="2">
                                                <span class="badge 
                                        ${order.status == 'COMPLETE' ? 'bg-success' : 'bg-warning'}">
                                                    ${order.status}
                                                </span>
                                            </td>
                                        </tr>

                                        <!-- ORDER DETAILS -->
                                        <c:forEach var="detail" items="${order.orderDetails}">
                                            <tr>

                                                <td>
                                                    <img src="/images/product/${detail.product.image}"
                                                        class="rounded-circle"
                                                        style="width:80px;height:80px;object-fit:cover;">
                                                </td>

                                                <td>
                                                    <a href="/product/${detail.product.id}" class="text-success fw-bold"
                                                        target="_blank">
                                                        ${detail.product.name}
                                                    </a>
                                                </td>

                                                <td>
                                                    <fmt:formatNumber value="${detail.price}" type="number" /> đ
                                                </td>

                                                <td>
                                                    ${detail.quantity}
                                                </td>

                                                <td>
                                                    <fmt:formatNumber value="${detail.price * detail.quantity}"
                                                        type="number" /> đ
                                                </td>

                                                <td></td>
                                            </tr>
                                        </c:forEach>

                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>

                <!-- FOOTER CLIENT -->
                <jsp:include page="../layout/footer.jsp" />

                <!-- JS (BẮT BUỘC – KHÔNG THIẾU) -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/js/main.js"></script>

            </body>

            </html>