package vn.hoidanit.laptopshop.controller.client;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.RedirectView;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class SeoController {

    private final String configuredBaseUrl;

    public SeoController(@Value("${app.base-url:}") String configuredBaseUrl) {
        this.configuredBaseUrl = configuredBaseUrl == null ? "" : configuredBaseUrl.trim();
    }

    @GetMapping(value = "/robots.txt", produces = MediaType.TEXT_PLAIN_VALUE)
    @ResponseBody
    public String robots(HttpServletRequest request) {
        String baseUrl = resolveBaseUrl(request);
        return """
                User-agent: *
                Allow: /
                Disallow: /admin/
                Disallow: /account/
                Disallow: /cart/
                Disallow: /checkout/
                Disallow: /order-history
                Sitemap: %s/sitemap.xml
                """.formatted(baseUrl);
    }

    @GetMapping(value = "/sitemap.xml", produces = MediaType.APPLICATION_XML_VALUE)
    @ResponseBody
    public String sitemap(HttpServletRequest request) {
        String baseUrl = resolveBaseUrl(request);
        String today = LocalDate.now().toString();
        List<String> routes = List.of("/", "/products", "/about", "/login");
        StringBuilder xml = new StringBuilder("""
                <?xml version="1.0" encoding="UTF-8"?>
                <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
                """);
        for (String route : routes) {
            xml.append("  <url>\n")
                    .append("    <loc>").append(baseUrl).append(route).append("</loc>\n")
                    .append("    <lastmod>").append(today).append("</lastmod>\n")
                    .append("    <changefreq>").append(route.equals("/") ? "daily" : "weekly").append("</changefreq>\n")
                    .append("    <priority>").append(route.equals("/") ? "1.0" : "0.8").append("</priority>\n")
                    .append("  </url>\n");
        }
        xml.append("</urlset>\n");
        return xml.toString();
    }

    @GetMapping("/favicon.ico")
    public RedirectView favicon() {
        RedirectView redirectView = new RedirectView("/images/branding/laptopshop-favicon.svg");
        redirectView.setStatusCode(org.springframework.http.HttpStatus.FOUND);
        return redirectView;
    }

    private String resolveBaseUrl(HttpServletRequest request) {
        if (!configuredBaseUrl.isBlank()) {
            return stripTrailingSlash(configuredBaseUrl);
        }
        String scheme = headerOrDefault(request, "X-Forwarded-Proto", request.getScheme());
        String host = headerOrDefault(request, "X-Forwarded-Host", request.getHeader("Host"));
        if (host == null || host.isBlank()) {
            host = request.getServerName() + ":" + request.getServerPort();
        }
        return stripTrailingSlash(scheme + "://" + host);
    }

    private String headerOrDefault(HttpServletRequest request, String headerName, String fallback) {
        String header = request.getHeader(headerName);
        return header == null || header.isBlank() ? fallback : header.split(",")[0].trim();
    }

    private String stripTrailingSlash(String value) {
        return value.endsWith("/") ? value.substring(0, value.length() - 1) : value;
    }
}
