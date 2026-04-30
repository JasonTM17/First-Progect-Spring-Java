package vn.hoidanit.laptopshop.domain.dto;

public class CartResponseDTO {

    private int cartCount;
    private String message;

    public CartResponseDTO(int cartCount, String message) {
        this.cartCount = cartCount;
        this.message = message;
    }

    public int getCartCount() {
        return cartCount;
    }

    public void setCartCount(int cartCount) {
        this.cartCount = cartCount;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
