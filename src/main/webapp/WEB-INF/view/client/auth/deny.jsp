<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>403 - Truy cập bị từ chối</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client" style="padding-top: 0; min-height: 100vh; display: flex; align-items: center; justify-content: center; background: radial-gradient(1200px 500px at 10% 0%, #fee2e2 0%, transparent 60%), radial-gradient(900px 400px at 90% 100%, #fff1d6 0%, transparent 60%), linear-gradient(180deg, #fafbff 0%, #fff 100%);">
    <div class="ui-container" style="max-width: 640px; padding: var(--space-8) var(--space-4);">
        <div class="ui-card ui-slide-up" style="padding: var(--space-12) var(--space-8); text-align: center;">
            <div style="width: 120px; height: 120px; border-radius: 50%; background: linear-gradient(135deg, #fee2e2, #fecaca); display: inline-flex; align-items: center; justify-content: center; font-size: 56px; color: var(--danger-600); margin-bottom: var(--space-5); box-shadow: 0 0 0 12px rgba(239, 68, 68, 0.12);">
                <i class="bi bi-shield-exclamation"></i>
            </div>
            <div style="font-size: 4rem; font-weight: 900; line-height: 1; color: var(--danger-600); margin-bottom: var(--space-2); font-family: var(--font-display);">403</div>
            <h1 style="font-size: 1.5rem; font-weight: 700; margin: 0 0 var(--space-3); color: var(--text);">Truy cập bị từ chối</h1>
            <p style="color: var(--text-muted); max-width: 420px; margin: 0 auto var(--space-6); line-height: 1.6;">
                Bạn không có quyền truy cập vào tài nguyên này. Vui lòng quay lại hoặc liên hệ quản trị viên nếu bạn nghĩ đây là nhầm lẫn.
            </p>
            <div style="display: flex; gap: var(--space-3); justify-content: center; flex-wrap: wrap;">
                <a href="/" class="ui-btn ui-btn--lg">
                    <i class="bi bi-house"></i>
                    Về trang chủ
                </a>
                <a href="/login" class="ui-btn ui-btn--secondary ui-btn--lg">
                    <i class="bi bi-box-arrow-in-right"></i>
                    Đăng nhập
                </a>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
</body>

</html>
