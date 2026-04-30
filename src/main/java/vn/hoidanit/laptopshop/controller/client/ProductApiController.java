package vn.hoidanit.laptopshop.controller.client;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import vn.hoidanit.laptopshop.domain.dto.ProductSuggestionDTO;
import vn.hoidanit.laptopshop.service.ProductService;

@RestController
public class ProductApiController {

    private final ProductService productService;

    public ProductApiController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/api/products/suggest")
    public List<ProductSuggestionDTO> suggestProducts(@RequestParam(value = "name", required = false) String name) {
        return productService.suggestProducts(name, 6)
                .stream()
                .map(ProductSuggestionDTO::from)
                .toList();
    }
}
