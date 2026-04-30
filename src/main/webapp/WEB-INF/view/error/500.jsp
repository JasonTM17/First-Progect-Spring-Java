<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Có lỗi xảy ra - Laptopshop</title>
    <jsp:include page="/WEB-INF/view/fragments/head-client.jsp" />
</head>

<body class="ls-client" style="padding-top: 0; min-height: 100vh; display: flex; align-items: center; justify-content: center; background: radial-gradient(ellipse at top, #fee2e2 0%, var(--surface) 50%);">
    <div class="ui-container" style="max-width: 720px; padding: var(--space-8) var(--space-4);">
        <div class="ui-card ui-slide-up" style="padding: var(--space-12) var(--space-8); text-align: center;">
            <div style="width: 120px; height: 120px; margin: 0 auto var(--space-5); border-radius: 50%; background: #fee2e2; color: var(--danger-600); display:flex; align-items:center; justify-content:center; font-size: 56px;">
                <i class="bi bi-tools"></i>
            </div>
            <div style="font-size: 4rem; font-weight: 800; background: linear-gradient(135deg, var(--danger-500), var(--danger-700, #b91c1c)); -webkit-background-clip: text; background-clip: text; color: transparent; line-height: 1;">500</div>
            <h1 style="font-size: 1.75rem; margin: var(--space-3) 0 var(--space-2);">Có sự cố đang xảy ra</h1>
            <p style="color: var(--text-subtle); margin-bottom: var(--space-6); max-width: 420px; margin-left: auto; margin-right: auto;">
                Hệ thống gặp lỗi không mong muốn. Đội ngũ kỹ thuật đã được thông báo. Vui lòng thử lại sau ít phút.
            </p>
            <div style="display: flex; gap: var(--space-3); justify-content: center; flex-wrap: wrap;">
                <a href="/" class="ui-btn ui-btn--lg">
                    <i class="bi bi-house"></i> Về trang chủ
                </a>
                <a href="javascript:history.back()" class="ui-btn ui-btn--secondary ui-btn--lg">
                    <i class="bi bi-arrow-left"></i> Quay lại trang trước
                </a>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/view/fragments/scripts-client.jsp" />
</body>

</html>
