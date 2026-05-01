package vn.hoidanit.laptopshop.controller.client;

import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.ChangePasswordDTO;
import vn.hoidanit.laptopshop.domain.dto.ProfileDTO;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class AccountController {

    private final UserService userService;

    public AccountController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/account")
    public String getAccountPage(Model model, HttpServletRequest request) {
        String email = resolveEmail(request);
        User user = email == null ? null : userService.getUserByEmail(email);

        model.addAttribute("email", email);
        model.addAttribute("user", user);
        if (!model.containsAttribute("profileDTO")) {
            model.addAttribute("profileDTO", buildProfileDTO(user));
        }
        if (!model.containsAttribute("changePasswordDTO")) {
            model.addAttribute("changePasswordDTO", new ChangePasswordDTO());
        }

        return "client/account/account";
    }

    @PostMapping("/account/profile")
    public String updateProfile(
            @ModelAttribute("profileDTO") @Valid ProfileDTO profileDTO,
            BindingResult bindingResult,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", bindingResult.getFieldError().getDefaultMessage());
            return "redirect:/account#tab-info";
        }

        HttpSession session = request.getSession(false);
        String email = resolveEmail(request);
        User updatedUser = userService.updateProfile(email, profileDTO);
        if (updatedUser == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy tài khoản để cập nhật");
            return "redirect:/account#tab-info";
        }

        if (session != null) {
            session.setAttribute("user", updatedUser);
            session.setAttribute("fullName", updatedUser.getFullName());
            session.setAttribute("avatar", updatedUser.getAvatar());
            session.setAttribute("email", updatedUser.getEmail());
        }
        redirectAttributes.addFlashAttribute("success", "Cập nhật thông tin tài khoản thành công");
        return "redirect:/account#tab-info";
    }

    @PostMapping({"/account/change-password", "/account/update-password"})
    public String updatePassword(
            @ModelAttribute("changePasswordDTO") @Valid ChangePasswordDTO dto,
            BindingResult bindingResult,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("error", bindingResult.getFieldError().getDefaultMessage());
            return "redirect:/account#tab-password";
        }

        if (!Objects.equals(dto.getNewPassword(), dto.getConfirmPassword())) {
            redirectAttributes.addFlashAttribute("error", "Xác nhận mật khẩu không khớp");
            return "redirect:/account#tab-password";
        }

        String email = resolveEmail(request);

        boolean success = userService.changePassword(
                email,
                dto.getOldPassword(),
                dto.getNewPassword()
        );

        if (!success) {
            redirectAttributes.addFlashAttribute("error", "Mật khẩu hiện tại không đúng");
            return "redirect:/account#tab-password";
        }

        redirectAttributes.addFlashAttribute("success", "Đổi mật khẩu thành công");
        return "redirect:/account#tab-password";
    }

    private String resolveEmail(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = session == null ? null : (String) session.getAttribute("email");
        if (email == null && request.getUserPrincipal() != null) {
            email = request.getUserPrincipal().getName();
        }
        return email;
    }

    private ProfileDTO buildProfileDTO(User user) {
        if (user == null) {
            return new ProfileDTO();
        }
        return new ProfileDTO(user.getFullName(), user.getPhone(), user.getAddress());
    }
}
