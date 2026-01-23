package vn.hoidanit.laptopshop.controller.admin;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.hoidanit.laptopshop.domain.dto.ChangePasswordDTO;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminAccountController {

    private final UserService userService;

    public AdminAccountController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/account")
    public String showAccountPage(Model model) {
        model.addAttribute("changePasswordDTO", new ChangePasswordDTO());
        return "admin/account/update-password";
    }

    @PostMapping("/account/change-password")
    public String changePassword(@ModelAttribute ChangePasswordDTO dto,
            Principal principal,
            Model model) {

        boolean success = userService.changePassword(
                principal.getName(),
                dto.getOldPassword(),
                dto.getNewPassword()
        );

        if (!success) {
            model.addAttribute("error", "Mật khẩu cũ không đúng");
            return "admin/account/update-password";
        }

        model.addAttribute("success", "Đổi mật khẩu thành công");
        return "admin/account/update-password";
    }
}
