<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Chi tiết người dùng - Laptopshop Admin</title>
    <jsp:include page="/WEB-INF/view/fragments/head-admin.jsp" />
</head>

<body class="ls-admin">
    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/sidebar.jsp" />

    <main class="la-main">
        <header class="la-page-head">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="ui-breadcrumb" style="margin-bottom: 4px;">
                        <li><a href="/admin">Admin</a></li>
                        <li><a href="/admin/user">Người dùng</a></li>
                        <li class="active">Chi tiết</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Chi tiết người dùng #${id}</h1>
                <p class="la-page-head__desc">Thông tin chi tiết của người dùng trong hệ thống</p>
            </div>
            <div class="la-page-head__actions">
                <a href="/admin/user" class="ui-btn ui-btn--ghost"><i class="bi bi-arrow-left"></i> Quay lại</a>
                <a href="/admin/user/update/${user.id}" class="ui-btn"><i class="bi bi-pencil"></i> Chỉnh sửa</a>
            </div>
        </header>

        <div class="la-form-layout">
            <div class="ui-card" style="padding: var(--space-6);">
                <div style="display:flex; align-items:center; gap: var(--space-4); padding-bottom: var(--space-4); border-bottom: 1px solid var(--border); margin-bottom: var(--space-4);">
                    <div style="width: 72px; height: 72px; border-radius: 999px; background: var(--brand-100); color: var(--brand-700); display:flex; align-items:center; justify-content:center; font-weight: 700; font-size: 1.5rem;">
                        <c:choose>
                            <c:when test="${not empty user.avatar}">
                                <img src="/images/avatar/${fn:escapeXml(user.avatar)}" alt="" style="width:100%; height:100%; border-radius: 999px; object-fit: cover;" />
                            </c:when>
                            <c:otherwise>${fn:toUpperCase(fn:substring(user.fullName, 0, 1))}</c:otherwise>
                        </c:choose>
                    </div>
                    <div>
                        <h2 style="margin: 0; font-size: 1.25rem;"><c:out value="${user.fullName}" /></h2>
                        <p class="ui-muted" style="margin: 0;"><c:out value="${user.email}" /></p>
                    </div>
                </div>
                <dl style="display: grid; grid-template-columns: 160px 1fr; gap: var(--space-3) var(--space-5); margin: 0;">
                    <dt class="ui-muted">ID</dt><dd style="margin:0; font-weight:600;">#${user.id}</dd>
                    <dt class="ui-muted">Vai trò</dt>
                    <dd style="margin:0;">
                        <c:choose>
                            <c:when test="${user.role.name eq 'ADMIN'}"><span class="ui-badge ui-badge--primary">ADMIN</span></c:when>
                            <c:otherwise><span class="ui-badge ui-badge--muted">USER</span></c:otherwise>
                        </c:choose>
                    </dd>
                    <dt class="ui-muted">Email</dt><dd style="margin:0;"><c:out value="${user.email}" /></dd>
                    <dt class="ui-muted">Số điện thoại</dt><dd style="margin:0;"><c:out value="${user.phone}" default="—" /></dd>
                    <dt class="ui-muted">Địa chỉ</dt><dd style="margin:0;"><c:out value="${user.address}" default="—" /></dd>
                </dl>
            </div>

            <div>
                <section class="la-form-section">
                    <h3 class="la-form-section__title">Hành động</h3>
                    <div style="display:flex; flex-direction:column; gap: var(--space-2);">
                        <a href="/admin/user/update/${user.id}" class="ui-btn ui-btn--secondary"><i class="bi bi-pencil"></i> Chỉnh sửa thông tin</a>
                        <a href="/admin/user" class="ui-btn ui-btn--ghost"><i class="bi bi-arrow-left"></i> Quay lại danh sách</a>
                    </div>
                </section>
            </div>
        </div>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
</body>

</html>
