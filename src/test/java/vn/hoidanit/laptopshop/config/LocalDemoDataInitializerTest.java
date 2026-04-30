package vn.hoidanit.laptopshop.config;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.repository.RoleRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@SpringBootTest(properties = {
        "spring.session.store-type=none",
        "spring.datasource.url=jdbc:h2:mem:laptopshop-local-seed;MODE=MySQL;DB_CLOSE_DELAY=-1;DATABASE_TO_LOWER=TRUE",
        "spring.datasource.username=sa",
        "spring.datasource.password=",
        "spring.datasource.driver-class-name=org.h2.Driver",
        "spring.jpa.hibernate.ddl-auto=create-drop"
})
@ActiveProfiles("local")
class LocalDemoDataInitializerTest {

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    CartRepository cartRepository;

    @Autowired
    OrderRepository orderRepository;

    @Test
    void localProfileSeedsReviewerReadyDemoData() {
        User admin = userRepository.findByEmail("admin@laptopshop.dev");
        User customer = userRepository.findByEmail("customer@laptopshop.dev");

        assertThat(roleRepository.findByName("ADMIN")).isNotNull();
        assertThat(roleRepository.findByName("USER")).isNotNull();
        assertThat(admin).isNotNull();
        assertThat(customer).isNotNull();
        assertThat(productRepository.count()).isGreaterThanOrEqualTo(3);

        Cart cart = cartRepository.findByUser(customer);
        List<Order> orders = orderRepository.findByUser(customer);

        assertThat(cart).isNotNull();
        assertThat(cart.getSum()).isEqualTo(1);
        assertThat(orders).hasSize(2);
        assertThat(orders).extracting(Order::getStatus)
                .containsExactlyInAnyOrder("DELIVERED", "CONFIRMED");
        assertThat(orders)
                .allSatisfy(order -> assertThat(order.getOrderDetails()).isNotEmpty());
    }
}
