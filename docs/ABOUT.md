# About Laptopshop

Laptopshop is a full-stack Java Spring Boot MVC e-commerce project built as a portfolio-grade laptop retail application. It focuses on the parts reviewers usually care about most: a realistic shopping experience, business rules that protect data consistency, an admin workflow that uses real backend data, and documentation that makes the project easy to run and evaluate.

## Product Story

The application models a Vietnamese laptop retailer with a dense electronics-commerce UX:

- Customers can search, filter, compare, add products to cart, check out, and review order history.
- Admins can monitor revenue, stock, products, users, orders, and export order reports.
- Reviewers can run the app locally with seeded demo accounts, products, cart data, and order history.

The visual direction is inspired by high-information electronics retail patterns: red brand system, compact product cards, promotion badges, sticky summaries, strong search, and clear category navigation. The brand, content, assets, and copy remain Laptopshop-owned for portfolio use.

## Target Users

| User | Needs |
| --- | --- |
| Shopper | Find the right laptop quickly, understand price/promo/service, and check out safely |
| Returning customer | View order history, manage profile, update password |
| Admin operator | Track revenue, low stock, recent activity, orders, users, products |
| Recruiter/reviewer | Run the project quickly, see meaningful flows, inspect tests and deployment readiness |

## Product Principles

- **Clarity before decoration:** every visible UI block should support selection, purchase, support, or administration.
- **Real flows over placeholder UI:** CTAs such as buy-now, search suggestion, CSV export, admin filters, and cart actions are wired to real behavior.
- **Business rules in services:** cart/order/stock/status behavior lives in service-level code rather than being only view logic.
- **Reviewer-ready defaults:** the `local` profile can seed demo accounts and data so the first run has something to inspect.
- **Deployment awareness:** secrets are environment-driven; prod disables local seed behavior and expects external database configuration.

## What Makes It Portfolio-Ready

- Complete storefront: home, catalog, product detail, cart, checkout, login, register, account, order history, About.
- Complete admin slice: dashboard, users, products, orders, search/filter, CSV report, status validation.
- Automated tests beyond context loading: services, controllers, security responses, seed data, admin routes, and E2E smoke.
- Professional docs: installation, architecture, testing, deployment, release notes, feature matrix, reviewer guide, showcase script.
- Production metadata: favicon/manifest, sitemap, robots, Open Graph-friendly assets, health endpoints.

## Demo Accounts

When running with `SPRING_PROFILES_ACTIVE=local` and demo seed enabled:

| Role | Email | Password |
| --- | --- | --- |
| Admin | `admin@laptopshop.dev` | `Admin@123` |
| Customer | `customer@laptopshop.dev` | `Customer@123` |

The customer account includes sample cart and order-history data. The admin account can access `/admin` and the report export route.

## Evaluation Path

Use this path for a quick review:

```text
/ -> /products?factory=APPLE -> /product/1 -> customer login -> /cart -> /checkout -> /order-history -> admin login -> /admin
```

Then inspect:

- `src/main/java/vn/hoidanit/laptopshop/service`
- `src/main/java/vn/hoidanit/laptopshop/controller`
- `src/test/java/vn/hoidanit/laptopshop`
- `docs/ARCHITECTURE.md`
- `docs/TESTING.md`
- `RELEASE_NOTES.md`

## Scope Boundaries

This release intentionally keeps the database schema focused. Wishlist sync, live payment gateways, full promotion/spec tables, email delivery, and object storage are good next-release slices rather than partially implemented placeholders.
