package vn.hoidanit.laptopshop.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.ProfileDTO;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.repository.RoleRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    UserRepository userRepository;

    @Mock
    RoleRepository roleRepository;

    @Mock
    ProductRepository productRepository;

    @Mock
    OrderRepository orderRepository;

    @Mock
    PasswordEncoder passwordEncoder;

    @InjectMocks
    UserService userService;

    @Test
    void updateProfileTrimsFieldsAndSavesUser() {
        User user = new User();
        user.setEmail("buyer@example.com");
        user.setFullName("Old Name");

        ProfileDTO dto = new ProfileDTO("  Nguyen Son  ", " 0912345678 ", "  Ha Noi  ");

        when(userRepository.findByEmail("buyer@example.com")).thenReturn(user);
        when(userRepository.save(user)).thenReturn(user);

        User updated = userService.updateProfile("buyer@example.com", dto);

        assertThat(updated).isSameAs(user);
        assertThat(updated.getFullName()).isEqualTo("Nguyen Son");
        assertThat(updated.getPhone()).isEqualTo("0912345678");
        assertThat(updated.getAddress()).isEqualTo("Ha Noi");
    }

    @Test
    void updateProfileReturnsNullWhenUserMissing() {
        when(userRepository.findByEmail("missing@example.com")).thenReturn(null);

        User updated = userService.updateProfile("missing@example.com", new ProfileDTO("Nguyen Son", "", ""));

        assertThat(updated).isNull();
    }
}
