package vn.hoidanit.laptopshop.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import vn.hoidanit.laptopshop.service.validator.RegisterChecked;
import vn.hoidanit.laptopshop.service.validator.StrongPassword;

@RegisterChecked
public class RegisterDTO {

    @NotBlank(message = "Họ không được để trống")
    @Size(min = 2, message = "Họ phải có tối thiểu 2 ký tự")
    private String firstName;

    @NotBlank(message = "Tên không được để trống")
    @Size(min = 2, message = "Tên phải có tối thiểu 2 ký tự")
    private String lastName;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+$")
    private String email;

    @NotBlank(message = "Mật khẩu không được để trống")
    @Size(min = 6, message = "Mật khẩu phải có tối thiểu 6 ký tự")
    @StrongPassword
    private String password;

    @NotBlank(message = "Xác nhận mật khẩu không được để trống")
    @Size(min = 6, message = "Xác nhận mật khẩu phải có tối thiểu 6 ký tự")
    private String confirmPassword;

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
}
