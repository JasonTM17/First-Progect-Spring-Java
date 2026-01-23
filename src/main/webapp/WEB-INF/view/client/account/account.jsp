<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="utf-8">
                <title>Quản lý tài khoản - Laptopshop</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">

                <!-- Google Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">


                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />


                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">


                <link href="/client/css/bootstrap.min.css" rel="stylesheet">


                <link href="/client/css/style.css" rel="stylesheet">
            </head>

            <body>


                <jsp:include page="../layout/header.jsp" />


                <div class="container-fluid py-5">
                    <div class="container py-5">


                        <nav aria-label="breadcrumb" class="mb-4">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="/">Home</a>
                                </li>
                                <li class="breadcrumb-item active">
                                    Quản lý tài khoản
                                </li>
                            </ol>
                        </nav>

                        <div class="row justify-content-center">
                            <div class="col-md-8">

                                <h3 class="mb-4">Đổi mật khẩu</h3>


                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <c:if test="${not empty success}">
                                    <div class="alert alert-success">${success}</div>
                                </c:if>


                                <form:form method="post" action="/account/change-password"
                                    modelAttribute="changePasswordDTO">

                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="text" class="form-control"
                                            value="${pageContext.request.userPrincipal.name}" readonly>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu cũ</label>
                                        <form:password path="oldPassword" class="form-control" required="true" />
                                    </div>

                                    <div class="mb-4">
                                        <label class="form-label">Mật khẩu mới</label>
                                        <form:password path="newPassword" class="form-control" required="true" />
                                    </div>

                                    <button type="submit" class="btn btn-success rounded-pill px-4">
                                        Cập nhật mật khẩu
                                    </button>
                                </form:form>

                            </div>
                        </div>
                    </div>
                </div>

                <!-- FOOTER -->
                <jsp:include page="../layout/footer.jsp" />


                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/js/main.js"></script>

            </body>

            </html>