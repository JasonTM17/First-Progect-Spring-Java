package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.dto.ChangePasswordDTO;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class AccountController {

    private final UserService userService;

    public AccountController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/account")
    public String getAccountPage(Model model, HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");

        model.addAttribute("email", email);
        model.addAttribute("changePasswordDTO", new ChangePasswordDTO());

        return "client/account/account";
    }

    @PostMapping("/account/update-password")
    public String updatePassword(
            @ModelAttribute("changePasswordDTO") ChangePasswordDTO dto,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");

        boolean success = userService.changePassword(
                email,
                dto.getOldPassword(),
                dto.getNewPassword()
        );

        if (!success) {
            redirectAttributes.addFlashAttribute(
                    "error", "Mật khẩu cũ không đúng");
            return "redirect:/account";
        }

        redirectAttributes.addFlashAttribute(
                "success", "Đổi mật khẩu thành công");
        return "redirect:/account";
    }
}
