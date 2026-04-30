# Reviewer Guide

This guide is written for recruiters, mentors, and technical reviewers who want to evaluate Laptopshop quickly without reverse-engineering the project first.

## 10-Minute Review Flow

### 1. Start With The README

Check:

- Screenshots and project positioning.
- Demo accounts.
- Quick start and environment variables.
- Test and deployment commands.

Useful files:

- `README.MD`
- `INSTALLATION.md`
- `RELEASE_NOTES.md`
- `docs/GITHUB_REPO_SETUP.md`

### 2. Run The App

```powershell
$env:SPRING_PROFILES_ACTIVE = "local"
$env:MYSQL_PASSWORD = "your_mysql_password"
.\mvnw.cmd spring-boot:run "-Dspring-boot.run.arguments=--server.port=8081"
```

Open:

```text
http://localhost:8081
```

Demo accounts:

- Customer: `customer@laptopshop.dev` / `Customer@123`
- Admin: `admin@laptopshop.dev` / `Admin@123`

### 3. Storefront Walkthrough

Open:

```text
/
/products?factory=APPLE
/product/1
/about
```

Look for:

- Red retail header, category navigation, search suggestions.
- Product cards with dense e-commerce information.
- Catalog filters, sorting, active chips, pagination.
- Product detail buy box, promotion, support, specs, related products.
- Professional About page with service policy and portfolio release status.

### 4. Customer Walkthrough

Log in as the customer and open:

```text
/cart
/checkout
/order-history
/account
```

Try:

- Buy-now from product detail.
- Add-to-cart from product cards/detail.
- Quantity changes in cart.
- Checkout form validation.
- Order history and account tabs.

### 5. Admin Walkthrough

Log in as admin and open:

```text
/admin
/admin/product
/admin/order
/admin/user
/admin/report/orders.csv
```

Look for:

- Real dashboard metrics and charts.
- Low-stock and recent activity blocks.
- Backend search/filter on admin lists.
- Order status badges and validated status transitions.
- CSV report export.
- Consistent admin UI instead of default scaffold pages.

### 6. Code Review Targets

| Concern | Inspect |
| --- | --- |
| Security config | `src/main/java/vn/hoidanit/laptopshop/config/SecurityConfiguration.java` |
| Cart/order rules | `src/main/java/vn/hoidanit/laptopshop/service/ProductService.java`, `OrderService.java` |
| Admin metrics | `src/main/java/vn/hoidanit/laptopshop/service/DashboardService.java` |
| Filtering/search | `ProductSpecs.java`, `ProductRepository.java`, controllers |
| DTO validation | `domain/dto`, validators |
| UI system | `resources/css/tokens.css`, `components.css`, `client.css`, `admin.css` |
| Tests | `src/test/java/vn/hoidanit/laptopshop` |

### 7. Verification Commands

```powershell
.\mvnw.cmd test
.\mvnw.cmd package
docker compose config
```

Optional:

```powershell
docker build -t laptopshop:review .
curl.exe http://localhost:8081/actuator/health
curl.exe http://localhost:8081/api/products/suggest?name=mac
curl.exe http://localhost:8081/robots.txt
```

## Evaluation Notes

Strong points to look for:

- The app has a complete happy path from product discovery to checkout and order history.
- Admin screens are operational and data-driven, not just static templates.
- Tests cover meaningful service/controller behavior.
- Local/prod config is separated and does not rely on committed passwords.
- Docs explain not only how to run the app, but why the architecture and release choices exist.
- GitHub About, topics, and release text are documented in `docs/GITHUB_REPO_SETUP.md`.

Intentional non-goals for v1:

- No real payment gateway.
- No account-synced wishlist.
- No external object storage.
- No real email/SMS delivery.
