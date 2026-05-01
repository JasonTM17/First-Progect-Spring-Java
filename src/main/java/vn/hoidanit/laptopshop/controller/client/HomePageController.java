package vn.hoidanit.laptopshop.controller.client;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.server.ResponseStatusException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.RegisterDTO;
import vn.hoidanit.laptopshop.service.OrderService;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final OrderService orderService;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder, OrderService orderService) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.orderService = orderService;
    }

    @GetMapping("/")
    public String getHomePage(Model model) {
        Pageable pageable = PageRequest.of(0, 10);
        Page<Product> prs = this.productService.fetchProducts(pageable);
        List<Product> products = prs.getContent();
        model.addAttribute("products", products);
        model.addAttribute("featuredProducts", products);
        model.addAttribute("macbookProducts", this.productService.fetchProductsByFactory("APPLE", 5));
        model.addAttribute("gamingProducts", this.productService.fetchProductsByTarget("GAMING", 5));
        model.addAttribute("officeProducts", this.productService.fetchProductsByTarget("SINHVIEN-VANPHONG", 5));
        model.addAttribute("budgetProducts", this.productService.fetchProductsByPriceRange("duoi-10-trieu", 5));
        return "client/homepage/show";
    }

    @GetMapping("/about")
    public String getAboutPage(Model model) {
        model.addAttribute("productCount", this.userService.countProducts());
        model.addAttribute("orderCount", this.userService.countOrders());
        model.addAttribute("userCount", this.userService.countUsers());
        return "client/about/show";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult
    ) {
        if (bindingResult.hasErrors()) {
            return "client/auth/register";
        }
        User user = this.userService.registerDTOtoUser(registerDTO);
        String hashPassword = this.passwordEncoder.encode(user.getPassword());

        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("USER"));
        //save
        this.userService.handleSaveUser(user);
        return "redirect:/login?registerSuccess";

    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/login";
    }

    @GetMapping("/access-deny")
    public String getDenyPage(Model model) {
        return "client/auth/deny";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        User currentUser = resolveCurrentUser(request);
        List<Order> orders = this.orderService.fetchOrderByUser(currentUser);
        model.addAttribute("orders", orders);

        return "client/cart/order-history";
    }

    private User resolveCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Object sessionUser = session == null ? null : session.getAttribute("user");
        if (sessionUser instanceof User user && user.getId() > 0) {
            return user;
        }

        Object id = session == null ? null : session.getAttribute("id");
        if (id instanceof Number userId) {
            User user = this.userService.getUserById(userId.longValue());
            if (user != null) {
                return user;
            }
        }

        if (request.getUserPrincipal() != null) {
            User user = this.userService.getUserByEmail(request.getUserPrincipal().getName());
            if (user != null) {
                return user;
            }
        }

        throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User session is missing");
    }

}
