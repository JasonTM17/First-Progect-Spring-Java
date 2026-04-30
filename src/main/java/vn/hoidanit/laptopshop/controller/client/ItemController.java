package vn.hoidanit.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.CheckoutDTO;
import vn.hoidanit.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class ItemController {

    private static final int PRODUCT_PAGE_SIZE = 10;

    private final ProductService productService;
    private final UserService userService;

    public ItemController(ProductService productService, UserService userService) {
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id) {
        Product product = this.productService.fetchProductById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found"));
        List<Product> relatedProducts = product.getFactory() == null || product.getFactory().isBlank()
                ? new ArrayList<>()
                : this.productService.fetchProductsByFactory(product.getFactory(), 5)
                        .stream()
                        .filter(item -> item.getId() != product.getId())
                        .limit(4)
                        .toList();
        model.addAttribute("product", product);
        model.addAttribute("relatedProducts", relatedProducts);
        model.addAttribute("id", id);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(false);
        String email = session == null ? null : (String) session.getAttribute("email");
        try {
            this.productService.handleAddProductToCart(email, id, session, 1);
            redirectAttributes.addFlashAttribute("success", "Đã thêm sản phẩm vào giỏ hàng");
        } catch (IllegalArgumentException | NoSuchElementException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        Cart cart = fetchCurrentUserCart(request);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", calculateTotalPrice(cartDetails));
        model.addAttribute("cart", cart);
        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        this.productService.handleRemoveCartDetail(id, request.getSession(false));
        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        Cart cart = fetchCurrentUserCart(request);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", calculateTotalPrice(cartDetails));
        model.addAttribute("cart", cart == null ? new Cart() : cart);
        if (!model.containsAttribute("checkoutDTO")) {
            model.addAttribute("checkoutDTO", buildCheckoutDTO(request));
        }
        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String confirmCheckout(@ModelAttribute("cart") Cart cart, RedirectAttributes redirectAttributes) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();
        try {
            this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
            return "redirect:/cart";
        }
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @ModelAttribute @Valid CheckoutDTO checkoutDTO,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes
    ) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", bindingResult.getFieldError().getDefaultMessage());
            return "redirect:/checkout";
        }

        User currentUser = getCurrentUser(request);
        try {
            boolean placed = this.productService.handlePlaceOrder(
                    currentUser,
                    request.getSession(false),
                    checkoutDTO.getReceiverName().trim(),
                    checkoutDTO.getReceiverAddress().trim(),
                    checkoutDTO.getReceiverPhone().trim(),
                    checkoutDTO.getPaymentMethod().trim());

            if (!placed) {
                redirectAttributes.addFlashAttribute("error", "Giỏ hàng đang trống");
                return "redirect:/cart";
            }
        } catch (IllegalArgumentException | NoSuchElementException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
            return "redirect:/checkout";
        }

        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThankYouPage() {
        return "client/cart/thanks";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            HttpServletRequest request,
            RedirectAttributes redirectAttributes,
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity) {

        HttpSession session = request.getSession(false);
        String email = session == null ? null : (String) session.getAttribute("email");
        try {
            this.productService.handleAddProductToCart(email, id, session, quantity);
            redirectAttributes.addFlashAttribute("success", "Đã thêm sản phẩm vào giỏ hàng");
        } catch (IllegalArgumentException | NoSuchElementException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/product/" + id;
    }

    @GetMapping("/products")
    public String getProductPage(
            Model model,
            ProductCriteriaDTO productCriteriaDTO,
            HttpServletRequest request) {
        int page = parsePage(productCriteriaDTO);
        Pageable pageable = buildProductPageable(page, productCriteriaDTO);

        Page<Product> productsPage = this.productService.fetchProductsWithSpec(pageable, productCriteriaDTO);
        List<Product> products = productsPage.hasContent() ? productsPage.getContent() : new ArrayList<>();

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productsPage.getTotalPages());
        model.addAttribute("totalProducts", productsPage.getTotalElements());
        model.addAttribute("sort", productCriteriaDTO.getSort().orElse(""));
        model.addAttribute("queryString", buildQueryStringWithoutPage(request.getQueryString()));
        return "client/product/show";
    }

    private int parsePage(ProductCriteriaDTO productCriteriaDTO) {
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                return Math.max(1, Integer.parseInt(productCriteriaDTO.getPage().get()));
            }
        } catch (NumberFormatException ignored) {
        }
        return 1;
    }

    private Pageable buildProductPageable(int page, ProductCriteriaDTO productCriteriaDTO) {
        String sort = productCriteriaDTO.getSort().orElse("");
        return switch (sort) {
            case "gia-tang-dan" -> PageRequest.of(page - 1, PRODUCT_PAGE_SIZE, Sort.by("price").ascending());
            case "gia-giam-dan" -> PageRequest.of(page - 1, PRODUCT_PAGE_SIZE, Sort.by("price").descending());
            default -> PageRequest.of(page - 1, PRODUCT_PAGE_SIZE);
        };
    }

    private String buildQueryStringWithoutPage(String queryString) {
        if (queryString == null || queryString.isBlank()) {
            return "";
        }
        String normalized = queryString
                .replaceAll("(^|&)page=[^&]*", "")
                .replaceAll("&{2,}", "&")
                .replaceAll("^&|&$", "");
        return normalized.isBlank() ? "" : "&" + normalized;
    }

    private Cart fetchCurrentUserCart(HttpServletRequest request) {
        return this.productService.fetchByUser(getCurrentUser(request));
    }

    private User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Object id = session == null ? null : session.getAttribute("id");
        if (!(id instanceof Number userId)) {
            if (userService != null && request.getUserPrincipal() != null) {
                User user = userService.getUserByEmail(request.getUserPrincipal().getName());
                if (user != null) {
                    return user;
                }
            }
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User session is missing");
        }
        User currentUser = new User();
        currentUser.setId(userId.longValue());
        return currentUser;
    }

    private double calculateTotalPrice(List<CartDetail> cartDetails) {
        if (cartDetails == null) {
            return 0;
        }
        double totalPrice = 0;
        for (CartDetail cartDetail : cartDetails) {
            totalPrice += cartDetail.getPrice() * cartDetail.getQuantity();
        }
        return totalPrice;
    }

    private CheckoutDTO buildCheckoutDTO(HttpServletRequest request) {
        CheckoutDTO dto = new CheckoutDTO();
        HttpSession session = request.getSession(false);
        Object user = session == null ? null : session.getAttribute("user");
        if (user instanceof User currentUser) {
            dto.setReceiverName(currentUser.getFullName());
            dto.setReceiverPhone(currentUser.getPhone());
            dto.setReceiverAddress(currentUser.getAddress());
        }
        return dto;
    }
}
