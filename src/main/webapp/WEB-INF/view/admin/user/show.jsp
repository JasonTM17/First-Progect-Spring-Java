<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Người dùng - Laptopshop Admin</title>
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
                        <li class="active">Người dùng</li>
                    </ol>
                </nav>
                <h1 class="la-page-head__title">Người dùng</h1>
                <p class="la-page-head__desc">Quản lý tài khoản thành viên và nhân viên hệ thống</p>
            </div>
            <div class="la-page-head__actions">
                <a href="/admin/user/create" class="ui-btn">
                    <i class="bi bi-plus-lg"></i> Thêm người dùng
                </a>
            </div>
        </header>

        <div class="ui-card" style="padding: 0;">
            <form method="get" action="/admin/user" style="padding: var(--space-4) var(--space-5); border-bottom: 1px solid var(--border); display: flex; gap: var(--space-3); flex-wrap: wrap; align-items: center;">
                <div style="flex: 1; min-width: 240px; position: relative;">
                    <i class="bi bi-search" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                    <input type="search" class="form-control" name="q" value="${fn:escapeXml(query)}" placeholder="Tìm theo email, tên..." style="padding-left: 36px;" id="userSearch" />
                </div>
                <select class="form-select" name="role" style="width: auto; min-width: 160px;" id="roleFilter">
                    <option value="">Tất cả vai trò</option>
                    <option value="ADMIN" ${roleFilter eq 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                    <option value="USER" ${roleFilter eq 'USER' ? 'selected' : ''}>USER</option>
                </select>
                <button class="ui-btn ui-btn--secondary" type="submit"><i class="bi bi-filter"></i> Lọc</button>
                <c:if test="${not empty query or not empty roleFilter}">
                    <a class="ui-btn ui-btn--ghost" href="/admin/user">Xoá lọc</a>
                </c:if>
            </form>

            <div class="table-responsive">
                <table class="table align-middle" style="margin: 0;">
                    <thead>
                        <tr>
                            <th style="width: 60px;">ID</th>
                            <th>Email</th>
                            <th>Họ tên</th>
                            <th style="width: 140px;">Vai trò</th>
                            <th style="width: 140px; text-align: right;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty users1}">
                                <tr><td colspan="5" style="padding: var(--space-10) 0;">
                                    <div class="ui-empty">
                                        <div class="ui-empty__icon"><i class="bi bi-people"></i></div>
                                        <p class="ui-empty__title">Chưa có người dùng</p>
                                        <p class="ui-empty__desc">Thêm người dùng đầu tiên để bắt đầu.</p>
                                        <a href="/admin/user/create" class="ui-btn" style="margin-top: var(--space-3);">
                                            <i class="bi bi-plus-lg"></i> Thêm người dùng
                                        </a>
                                    </div>
                                </td></tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="user" items="${users1}">
                                    <tr>
                                        <td style="font-weight: 600; color: var(--text-muted);">#${user.id}</td>
                                        <td>
                                            <div style="display:flex; align-items:center; gap: var(--space-3);">
                                                <div style="width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--brand-500), var(--brand-700)); color: #fff; display: flex; align-items: center; justify-content: center; font-weight: 700; flex-shrink: 0;">
                                                    <c:out value="${user.email.substring(0,1).toUpperCase()}" />
                                                </div>
                                                <div style="font-weight: 500;"><c:out value="${user.email}" /></div>
                                            </div>
                                        </td>
                                        <td><c:out value="${user.fullName}" /></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.role.name eq 'ADMIN'}">
                                                    <span class="ui-badge ui-badge--brand"><i class="bi bi-shield-check"></i> ADMIN</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="ui-badge ui-badge--muted"><i class="bi bi-person"></i> USER</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="text-align: right;">
                                            <div style="display: inline-flex; gap: 4px;">
                                                <a href="/admin/user/${user.id}" class="ui-iconbtn" title="Xem chi tiết">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="/admin/user/update/${user.id}" class="ui-iconbtn ui-iconbtn--warn" title="Chỉnh sửa">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <form method="post" action="/admin/user/delete" style="display:inline;"
                                                      data-confirm-title="Xoá người dùng"
                                                      data-confirm="Bạn chắc chắn muốn xoá người dùng ${user.email}? Hành động này không thể hoàn tác.">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <input type="hidden" name="id" value="${user.id}" />
                                                    <button type="submit" class="ui-iconbtn" style="color: var(--danger-600); background: #fee2e2;" title="Xoá">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <c:if test="${not empty users1 and totalPages > 1}">
                <div style="padding: var(--space-4) var(--space-5); border-top: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: var(--space-3);">
                    <div style="font-size: var(--fs-sm); color: var(--text-muted);">Trang ${currentPage} / ${totalPages}</div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination" style="margin: 0;">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="/admin/user?page=${currentPage - 1}${filterQuery}" aria-label="Trước">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>
                            <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                <li class="page-item ${loop.index + 1 == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="/admin/user?page=${loop.index + 1}${filterQuery}">${loop.index + 1}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="/admin/user?page=${currentPage + 1}${filterQuery}" aria-label="Sau">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </c:if>
        </div>

        <jsp:include page="../layout/footer.jsp" />
    </main>

    <jsp:include page="/WEB-INF/view/fragments/scripts-admin.jsp" />
    <script>
        (function () {
            var filter = document.getElementById('roleFilter');
            if (filter && filter.form) {
                filter.addEventListener('change', function () {
                    filter.form.submit();
                });
            }
        })();
    </script>
</body>

</html>
