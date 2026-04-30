package vn.hoidanit.laptopshop.controller.admin;

import java.security.Principal;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
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
        if (!model.containsAttribute("changePasswordDTO")) {
            model.addAttribute("changePasswordDTO", new ChangePasswordDTO());
        }
        return "admin/account/update-password";
    }

    @PostMapping("/account/change-password")
    public String changePassword(
            @ModelAttribute("changePasswordDTO") @Valid ChangePasswordDTO dto,
            BindingResult bindingResult,
            Principal principal,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", bindingResult.getFieldError().getDefaultMessage());
            return "redirect:/admin/account";
        }

        if (!Objects.equals(dto.getNewPassword(), dto.getConfirmPassword())) {
            redirectAttributes.addFlashAttribute("error", "Xác nhận mật khẩu không khớp");
            return "redirect:/admin/account";
        }

        boolean success = userService.changePassword(
                principal.getName(),
                dto.getOldPassword(),
                dto.getNewPassword()
        );

        if (!success) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu hiện tại không đúng");
            return "redirect:/admin/account";
        }

        redirectAttributes.addFlashAttribute("success", "Đổi mật khẩu thành công");
        return "redirect:/admin/account";
    }
}
