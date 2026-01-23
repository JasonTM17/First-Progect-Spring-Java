<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Quản lý tài khoản - Admin</title>
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

                                <h1 class="mt-4">Quản lý tài khoản</h1>

                                <form:form method="post" action="/admin/account/change-password"
                                    modelAttribute="changePasswordDTO" style="max-width: 400px;">

                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu cũ</label>
                                        <form:password path="oldPassword" class="form-control" />
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu mới</label>
                                        <form:password path="newPassword" class="form-control" />
                                    </div>

                                    <button class="btn btn-primary">
                                        Cập nhật mật khẩu
                                    </button>

                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger mt-3">${error}</div>
                                    </c:if>

                                    <c:if test="${not empty success}">
                                        <div class="alert alert-success mt-3">${success}</div>
                                    </c:if>

                                </form:form>

                            </div>
                        </main>

                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>

            </body>

            </html>