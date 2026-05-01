package vn.hoidanit.laptopshop.controller.admin;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.util.UriUtils;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UploadService;

@Controller
public class ProductController {

    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(
            UploadService uploadService,
            ProductService productService
    ) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        this.productService.fetchProductById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found"));
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newProduct") Product pr) {
        this.productService.deleteProduct(pr.getId());
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product")
    public String getProduct(
            Model model,
            @RequestParam("page") Optional<String> pageOptional,
            @RequestParam("q") Optional<String> queryOptional,
            @RequestParam("factory") Optional<String> factoryOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Math.max(1, Integer.parseInt(pageOptional.get()));
            }
        } catch (NumberFormatException ignored) {
        }
        String query = normalizeParam(queryOptional);
        String factory = normalizeParam(factoryOptional);
        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<Product> prs = this.productService.searchAdminProducts(pageable, query, factory);
        List<Product> listProducts = prs.getContent();

        model.addAttribute("products", listProducts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("query", query);
        model.addAttribute("factoryFilter", factory);
        model.addAttribute("filterQuery", buildFilterQuery(query, factory));

        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String handleCreateProduct(
            @ModelAttribute("newProduct") @Valid Product pr,
            BindingResult newProductBindingResult,
            @RequestParam("hoidanitFile") MultipartFile[] files
    ) {
        // validate
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/create";
        }

        String image;
        try {
            image = this.uploadService.handleSaveUploadFile(files, "product");
        } catch (IllegalArgumentException | IllegalStateException ex) {
            newProductBindingResult.rejectValue("image", "upload.invalid", ex.getMessage());
            return "admin/product/create";
        }
        pr.setImage(image);
        this.productService.createProduct(pr);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product pr = this.productService.fetchProductById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found"));
        model.addAttribute("product", pr);
        model.addAttribute("id", id);

        return "admin/product/detail";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Optional<Product> currentProduct
                = this.productService.fetchProductById(id);
        model.addAttribute("newProduct", currentProduct
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found")));
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String handleUpdateProduct(
            @ModelAttribute("newProduct") @Valid Product pr,
            BindingResult newProductBindingResult,
            @RequestParam("hoidanitFile") MultipartFile[] files
    ) {

        // validate
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Product currentProduct = this.productService.fetchProductById(pr.getId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found"));

        if (currentProduct != null) {
            if (files != null && files.length > 0 && !files[0].isEmpty()) {
                String img;
                try {
                    img = this.uploadService.handleSaveUploadFile(files, "product");
                } catch (IllegalArgumentException | IllegalStateException ex) {
                    newProductBindingResult.rejectValue("image", "upload.invalid", ex.getMessage());
                    return "admin/product/update";
                }
                currentProduct.setImage(img);
            }

            currentProduct.setName(pr.getName());
            currentProduct.setPrice(pr.getPrice());
            currentProduct.setQuantity(pr.getQuantity());
            currentProduct.setDetailDesc(pr.getDetailDesc());
            currentProduct.setShortDesc(pr.getShortDesc());
            currentProduct.setFactory(pr.getFactory());
            currentProduct.setTarget(pr.getTarget());

            this.productService.createProduct(currentProduct);
        }

        return "redirect:/admin/product";
    }

    private String normalizeParam(Optional<String> value) {
        return value.map(String::trim).filter(v -> !v.isBlank()).orElse(null);
    }

    private String buildFilterQuery(String query, String factory) {
        StringBuilder builder = new StringBuilder();
        if (query != null) {
            builder.append("&q=").append(UriUtils.encodeQueryParam(query, StandardCharsets.UTF_8));
        }
        if (factory != null) {
            builder.append("&factory=").append(UriUtils.encodeQueryParam(factory, StandardCharsets.UTF_8));
        }
        return builder.toString();
    }

}
