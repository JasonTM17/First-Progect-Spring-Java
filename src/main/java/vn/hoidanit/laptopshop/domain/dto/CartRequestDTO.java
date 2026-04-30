package vn.hoidanit.laptopshop.domain.dto;

import jakarta.validation.constraints.Min;

public class CartRequestDTO {

    @Min(value = 1, message = "Sản phẩm không hợp lệ")
    private long productId;

    @Min(value = 1, message = "Số lượng phải lớn hơn hoặc bằng 1")
    private long quantity;

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }
}
