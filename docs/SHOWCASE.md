# Laptopshop Showcase Script

Use this as a short portfolio pitch when presenting the project.

## One-Line Pitch

Laptopshop is a Spring Boot MVC e-commerce portfolio app for laptop retail, with a polished storefront, customer checkout flow, admin dashboard, demo data, CI, Docker, and deployment-ready configuration.

## What To Show First

1. Home page: retail-style layout, search autocomplete, categories, deal blocks, product cards.
2. Catalog: filter by brand, need, price, search keyword, sorting, active chips, and pagination.
3. Product detail: promo box, warranty/service blocks, quantity control, add-to-cart and buy-now behavior.
4. Customer flow: demo login, cart, checkout, account page, order history.
5. Admin flow: real dashboard metrics, low-stock alerts, backend search/filter for users/products/orders, status badges, quick product search, CSV export.
6. About/release docs: professional About page, `RELEASE_NOTES.md`, feature matrix, reviewer guide, and deployment/testing docs.

## Technical Highlights

- Java 17, Spring Boot, Spring MVC, JSP/JSTL, Spring Security.
- MySQL for app data and H2 for automated tests.
- Transactional cart/order handling with stock decrement and sold count updates.
- JSON `401` for unauthenticated API calls and clear `404` behavior for missing resources.
- Public product suggestion API, local wishlist polish, Product JSON-LD, sitemap, and cacheable static assets.
- Admin dashboard uses real database metrics instead of random chart data; admin lists have backend search/filter and order status transitions are validated.
- Local profile auto-seeds reviewer-ready accounts, products, cart, and order history.
- Docker, Docker Compose, Render blueprint, health checks, and GitHub Actions CI.
- Architecture, testing, deployment, contributing, and security docs are included for reviewer confidence.

## Suggested Five-Minute Walkthrough

1. Open README and point to screenshots, demo accounts, and quick start.
2. Show storefront search autocomplete, category drawer, product cards, and local wishlist feedback.
3. Add a product to cart as the demo customer and open order history.
4. Switch to admin dashboard and show real metrics, low-stock alerts, list filtering, order status rules, and CSV export.
5. Open `/about` and `RELEASE_NOTES.md` to show how the product story and release scope are documented.
6. Close with tests, Docker, CI, Render blueprint, and profile-based secrets.

## Demo Accounts

- Customer: `customer@laptopshop.dev` / `Customer@123`
- Admin: `admin@laptopshop.dev` / `Admin@123`

## Suggested GitHub About Text

Spring Boot MVC e-commerce portfolio app for laptop retail, featuring a polished storefront, search autocomplete, customer checkout flow, real admin metrics, backend admin filters, demo data seed, automated tests, Docker, CI, and deployment-ready configuration.

## Best Supporting Docs

- [Project About](ABOUT.md)
- [Reviewer Guide](REVIEWER_GUIDE.md)
- [Feature Matrix](FEATURE_MATRIX.md)
- [GitHub Repository Setup](GITHUB_REPO_SETUP.md)
- [Release Notes](../RELEASE_NOTES.md)

## Suggested Topics

```text
spring-boot spring-mvc spring-security jsp jstl mysql h2-database ecommerce docker github-actions portfolio java
```
