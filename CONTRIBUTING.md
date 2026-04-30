# Contributing

Laptopshop is maintained as a portfolio-grade Spring Boot MVC project. Keep changes small, tested, and consistent with the current architecture.

## Local Setup

1. Copy `.env.example` to `.env`.
2. Create a MySQL database named `laptopshop`.
3. Run with the `local` profile:

```powershell
$env:SPRING_PROFILES_ACTIVE = "local"
$env:MYSQL_PASSWORD = "your_mysql_password"
.\mvnw.cmd spring-boot:run
```

## Before Opening A PR

Run:

```powershell
.\mvnw.cmd test
.\mvnw.cmd package
docker build -t laptopshop:local .
```

For UI changes, include screenshots from the affected routes and smoke test:

```text
/ -> /products -> /product/1 -> /cart -> /order-history -> /admin
```

## Code Style

- Keep controller logic thin and place business rules in services.
- Keep JSP changes aligned with the shared CSS tokens and components.
- Avoid hard-coded secrets; use environment variables and profiles.
- Add tests when changing business rules, security behavior, or routes.
