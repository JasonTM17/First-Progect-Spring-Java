<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <title>403 - Access Denied</title>

            <link href="/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        </head>

        <body class="bg-primary">

            <div class="container vh-100 d-flex align-items-center justify-content-center">
                <div class="card shadow-lg border-0" style="max-width: 520px; width: 100%;">
                    <div class="card-body text-center p-5">

                        <div class="mb-4">
                            <i class="fas fa-ban fa-4x text-danger"></i>
                        </div>

                        <h1 class="fw-bold text-danger">403</h1>
                        <h4 class="mb-3">Truy cập bị từ chối</h4>

                        <p class="text-muted mb-4">
                            Bạn không có quyền truy cập vào tài nguyên này.<br />
                            Vui lòng quay lại hoặc liên hệ quản trị viên.
                        </p>

                        <div class="d-flex justify-content-center gap-3">
                            <a href="/" class="btn btn-success">
                                <i class="fas fa-home me-1"></i> Trang chủ
                            </a>
                            <a href="/login" class="btn btn-outline-secondary">
                                <i class="fas fa-sign-in-alt me-1"></i> Đăng nhập
                            </a>
                        </div>

                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="/js/scripts.js"></script>
        </body>

        </html>