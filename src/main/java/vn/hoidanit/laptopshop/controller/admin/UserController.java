package vn.hoidanit.laptopshop.controller.admin;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.util.UriUtils;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UploadService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, UploadService uploadService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/user")
    public String getUserPage(
            Model model,
            @RequestParam("page") Optional<String> pageOptional,
            @RequestParam("q") Optional<String> queryOptional,
            @RequestParam("role") Optional<String> roleOptional
    ) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Math.max(1, Integer.parseInt(pageOptional.get()));
            }
        } catch (NumberFormatException ignored) {
        }

        String query = normalizeParam(queryOptional);
        String role = normalizeParam(roleOptional);
        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<User> usersPage = this.userService.searchAdminUsers(pageable, query, role);
        List<User> users = usersPage.getContent();

        model.addAttribute("users1", users);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", usersPage.getTotalPages());
        model.addAttribute("query", query);
        model.addAttribute("roleFilter", role);
        model.addAttribute("filterQuery", buildFilterQuery(query, role));

        return "admin/user/show";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = getUserOr404(id);
        model.addAttribute("user", user);
        model.addAttribute("id", id);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/create") //GET
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserPage(
            Model model,
            @ModelAttribute("newUser") @Valid User hoidanit, BindingResult newUserBindingResult,
            @RequestParam("hoidanitFile") MultipartFile[] files
    ) {

        if (newUserBindingResult.hasErrors()) {
            return "admin/user/create";
        }
        //
        String avatar;
        try {
            avatar = this.uploadService.handleSaveUploadFile(files, "avatar");
        } catch (IllegalArgumentException | IllegalStateException ex) {
            newUserBindingResult.rejectValue("avatar", "upload.invalid", ex.getMessage());
            return "admin/user/create";
        }
        String hashPassword = this.passwordEncoder.encode(hoidanit.getPassword());
        hoidanit.setAvatar(avatar);
        hoidanit.setPassword(hashPassword);
        hoidanit.setRole(this.userService.getRoleByName(hoidanit.getRole().getName()));
        //save
        this.userService.handleSaveUser(hoidanit);
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/update/{id}") // GET
    public String getUpdateUserPage(Model model, @PathVariable long id
    ) {
        User currentUser = getUserOr404(id);
        model.addAttribute("newUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String getUpdateUserPage(Model model, @ModelAttribute("newUser") User hoidanit
    ) {
        User currentUser = getUserOr404(hoidanit.getId());
        currentUser.setAddress(hoidanit.getAddress());
        currentUser.setFullName(hoidanit.getFullName());
        currentUser.setPhone(hoidanit.getPhone());
        this.userService.handleSaveUser(currentUser);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id
    ) {
        getUserOr404(id);
        model.addAttribute("id", id);
        model.addAttribute("newUser", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeletUser(Model model, @ModelAttribute("newUser") User eric
    ) {
        this.userService.deleteUser(eric.getId());
        return "redirect:/admin/user";
    }

    private User getUserOr404(long id) {
        User user = this.userService.getUserById(id);
        if (user == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }
        return user;
    }

    private String normalizeParam(Optional<String> value) {
        return value.map(String::trim).filter(v -> !v.isBlank()).orElse(null);
    }

    private String buildFilterQuery(String query, String role) {
        StringBuilder builder = new StringBuilder();
        if (query != null) {
            builder.append("&q=").append(UriUtils.encodeQueryParam(query, StandardCharsets.UTF_8));
        }
        if (role != null) {
            builder.append("&role=").append(UriUtils.encodeQueryParam(role, StandardCharsets.UTF_8));
        }
        return builder.toString();
    }

}
