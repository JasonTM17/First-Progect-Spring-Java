package vn.hoidanit.laptopshop.controller.client;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.dto.CartRequestDTO;
import vn.hoidanit.laptopshop.domain.dto.CartResponseDTO;
import vn.hoidanit.laptopshop.service.ProductService;

@RestController
@Validated
public class CartAPI {

    private final ProductService productService;

    public CartAPI(ProductService productService) {
        this.productService = productService;
    }

    @PostMapping("/api/add-product-to-cart")
    public ResponseEntity<CartResponseDTO> addProductToCart(
            @Valid @RequestBody CartRequestDTO cartRequest,
            HttpServletRequest request
    ) {

        HttpSession session = request.getSession(false);
        String email = session == null ? null : (String) session.getAttribute("email");
        if (email == null && request.getUserPrincipal() != null) {
            email = request.getUserPrincipal().getName();
        }
        int cartCount = this.productService.handleAddProductToCart(email, cartRequest.getProductId(), session, cartRequest.getQuantity());
        return ResponseEntity.ok(new CartResponseDTO(cartCount, "Đã thêm sản phẩm vào giỏ hàng"));
    }

}
