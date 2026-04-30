<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Xoá người dùng - Laptopshop Admin</title>
    <jsp:include page="/WEB-INF/view/fragments/head-admin.jsp" />
</head>

<body class="ls-admin">
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main class="la-main">
        <header class="la-page-head">
            <div>
                <h1 class="la-page-head__title">Xoá người dùng #${id}</h1>
                <p class="la-page-head__desc">Xác nhận việc xoá tài khoản khỏi hệ thống</p>
            </div>
        </header>

        <div class="ui-card" style="max-width: 560px; padding: var(--space-6);">
            <div class="ui-alert ui-alert--danger" style="margin-bottom: var(--space-4);">
                <i class="bi bi-exclamation-triangle"></i>
                <span>Bạn chắc chắn muốn xoá người dùng này? Hành động này không thể hoàn tác.</span>
            </div>
            <form:form method="post" action="/admin/user/delete" modelAttribute="newUser">
                <form:input type="hidden" value="${id}" path="id" />
                <div style="display:flex; gap: var(--space-3);">
                    <button type="submit" class="ui-btn ui-btn--danger"><i class="bi bi-trash"></i> Xác nhận xoá</button>
                    <a href="/admin/user" class="ui-btn ui-btn--ghost">Huỷ</a>
                </div>
            </form:form>
        </div>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
</body>

</html>
