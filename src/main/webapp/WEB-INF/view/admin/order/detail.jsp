<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Admin - Laptop Shop" />
                <title>Order Detail | Admin</title>

                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">

                <jsp:include page="../layout/header.jsp" />

                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">

                                <h1 class="mt-4">Order Detail</h1>

                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item">
                                        <a href="/admin">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item">
                                        <a href="/admin/order">Orders</a>
                                    </li>
                                    <li class="breadcrumb-item active">Detail</li>
                                </ol>

                                <div class="container mt-4">
                                    <div class="row">
                                        <div class="col-12 mx-auto">

                                            <h3>Order detail (ID = ${id})</h3>
                                            <hr />

                                            <!-- Order information -->
                                            <div class="card mb-4" style="max-width: 700px;">
                                                <div class="card-header fw-bold">
                                                    Order Information
                                                </div>

                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">
                                                        <strong>Order ID:</strong> ${order.id}
                                                    </li>
                                                    <li class="list-group-item">
                                                        <strong>User:</strong> ${order.user.fullName}
                                                    </li>
                                                    <li class="list-group-item">
                                                        <strong>Status:</strong> ${order.status}
                                                    </li>
                                                    <li class="list-group-item">
                                                        <strong>Total Price:</strong>
                                                        <fmt:formatNumber value="${order.totalPrice}" type="number"
                                                            groupingUsed="true" /> ₫
                                                    </li>
                                                </ul>
                                            </div>

                                            <!-- Order items -->
                                            <div class="card" style="max-width: 1000px;">
                                                <div class="card-header fw-bold">
                                                    Order Items
                                                </div>

                                                <table class="table table-bordered align-middle mb-0">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th style="width: 120px;">Image</th>
                                                            <th>Product</th>
                                                            <th style="width: 150px;">Price</th>
                                                            <th style="width: 120px;">Quantity</th>
                                                            <th style="width: 180px;">Total</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="detail" items="${orderDetails}">
                                                            <tr>
                                                                <!-- Image -->
                                                                <td class="text-center">
                                                                    <img src="/images/product/${detail.product.image}"
                                                                        alt="product image" style="
                                                            width: 80px;
                                                            height: 80px;
                                                            object-fit: cover;
                                                            border-radius: 8px;
                                                         ">
                                                                </td>

                                                                <!-- Product name -->
                                                                <td>
                                                                    <a href="/admin/product/${detail.product.id}"
                                                                        class="text-decoration-none fw-semibold">
                                                                        ${detail.product.name}
                                                                    </a>
                                                                </td>


                                                                <!-- Price -->
                                                                <td>
                                                                    <fmt:formatNumber value="${detail.price}"
                                                                        type="number" groupingUsed="true" /> ₫
                                                                </td>

                                                                <!-- Quantity -->
                                                                <td>${detail.quantity}</td>

                                                                <!-- Total -->
                                                                <td>
                                                                    <fmt:formatNumber
                                                                        value="${detail.price * detail.quantity}"
                                                                        type="number" groupingUsed="true" /> ₫
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <a href="/admin/order" class="btn btn-success mt-3">
                                                Back to Orders
                                            </a>


                                        </div>
                                    </div>
                                </div>

                            </div>
                        </main>

                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>

            </body>

            </html>