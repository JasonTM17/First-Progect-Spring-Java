package vn.hoidanit.laptopshop.controller.client;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.ui.ExtendedModelMap;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.hoidanit.laptopshop.service.ProductService;

class ItemControllerTest {

    @Test
    void productsPaginationPreservesExistingFiltersWithAmpersand() {
        ProductService productService = org.mockito.Mockito.mock(ProductService.class);
        ItemController controller = new ItemController(productService, null);

        ProductCriteriaDTO criteria = new ProductCriteriaDTO();
        criteria.setPage(Optional.of("1"));
        criteria.setFactory(Optional.of(List.of("APPLE")));

        Product product = new Product();
        product.setId(1);
        product.setName("MacBook");

        when(productService.fetchProductsWithSpec(any(PageRequest.class), any(ProductCriteriaDTO.class)))
                .thenReturn(new PageImpl<>(List.of(product), PageRequest.of(0, 10), 1));

        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setQueryString("factory=APPLE&page=1");
        ExtendedModelMap model = new ExtendedModelMap();

        String view = controller.getProductPage(model, criteria, request);

        assertThat(view).isEqualTo("client/product/show");
        assertThat(model.get("queryString")).isEqualTo("&factory=APPLE");
    }
}
