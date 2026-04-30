<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${not empty param.title ? param.title : 'Laptopshop - Laptop chinh hang, gia tot moi ngay'}" />
<c:set var="pageDescription" value="${not empty param.description ? param.description : 'Laptopshop la portfolio e-commerce Spring Boot voi giao dien retail hien dai, catalog tim kiem nhanh, checkout ro rang va admin dashboard day du.'}" />
<c:set var="shareImage" value="${not empty param.shareImage ? param.shareImage : '/images/branding/laptopshop-og.svg'}" />
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />
<meta name="theme-color" content="#d70018" />
<meta name="description" content="${pageDescription}" />
<meta property="og:site_name" content="Laptopshop" />
<meta property="og:type" content="website" />
<meta property="og:title" content="${pageTitle}" />
<meta property="og:description" content="${pageDescription}" />
<meta property="og:image" content="${shareImage}" />
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:title" content="${pageTitle}" />
<meta name="twitter:description" content="${pageDescription}" />
<meta name="twitter:image" content="${shareImage}" />

<%-- CSRF meta (for fetch/ajax) --%>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<link rel="icon" type="image/svg+xml" href="/images/branding/laptopshop-favicon.svg" />
<link rel="apple-touch-icon" href="/images/branding/laptopshop-favicon.svg" />
<link rel="manifest" href="/site.webmanifest" />

<%-- Fonts --%>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap" />

<%-- Icons --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

<%-- Bootstrap 5.3 --%>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />

<%-- Design system --%>
<link rel="stylesheet" href="/css/tokens.css" />
<link rel="stylesheet" href="/css/components.css" />
<link rel="stylesheet" href="/css/client.css" />
