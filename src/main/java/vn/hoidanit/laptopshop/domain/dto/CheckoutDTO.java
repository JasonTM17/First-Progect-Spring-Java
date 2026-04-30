package vn.hoidanit.laptopshop.domain.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class CheckoutDTO {

    @NotBlank(message = "Vui lòng nhập họ tên người nhận")
    @Size(min = 2, max = 100, message = "Họ tên người nhận phải từ 2 đến 100 ký tự")
    private String receiverName;

    @NotBlank(message = "Vui lòng nhập địa chỉ nhận hàng")
    @Size(min = 8, max = 255, message = "Địa chỉ nhận hàng phải từ 8 đến 255 ký tự")
    private String receiverAddress;

    @NotBlank(message = "Vui lòng nhập số điện thoại")
    @Pattern(regexp = "^[0-9]{9,11}$", message = "Số điện thoại phải gồm 9 đến 11 chữ số")
    private String receiverPhone;

    @NotBlank(message = "Vui lòng chọn phương thức thanh toán")
    @Pattern(regexp = "^(COD|BANK)$", message = "Phương thức thanh toán không hợp lệ")
    private String paymentMethod = "COD";

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
}
