package vn.hoidanit.laptopshop.config;

import java.util.List;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Role;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.repository.RoleRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Component
@Profile("local")
@ConditionalOnProperty(prefix = "app.demo", name = "seed", havingValue = "true", matchIfMissing = true)
public class LocalDemoDataInitializer implements ApplicationRunner {

    private final RoleRepository roleRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final PasswordEncoder passwordEncoder;

    public LocalDemoDataInitializer(
            RoleRepository roleRepository,
            UserRepository userRepository,
            ProductRepository productRepository,
            CartRepository cartRepository,
            CartDetailRepository cartDetailRepository,
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository,
            PasswordEncoder passwordEncoder) {
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        Role adminRole = ensureRole("ADMIN", "Administrator");
        Role userRole = ensureRole("USER", "End user");

        ensureUser(
                "admin@laptopshop.dev",
                "Admin@123",
                "Admin Demo",
                "Laptopshop HQ, Ha Noi",
                "0988888888",
                adminRole);

        ensureUser(
                "customer@laptopshop.dev",
                "Customer@123",
                "Customer Demo",
                "123 Demo Street, Ha Noi",
                "0900000000",
                userRole);

        if (productRepository.count() == 0) {
            productRepository.saveAll(List.of(
                    buildProduct(
                            "Dell Inspiron 15",
                            14990000,
                            "1711078452562-dell-01.png",
                            "Core i5, 16GB RAM, 512GB SSD, phu hop hoc tap va van phong.",
                            "Laptop office and study",
                            10,
                            "DELL",
                            "SINHVIEN-VANPHONG"),
                    buildProduct(
                            "ASUS TUF Gaming",
                            22990000,
                            "1711078092373-asus-01.png",
                            "Ryzen 7, 16GB RAM, RTX 4050, man hinh tan so quet cao cho game thu.",
                            "Gaming laptop",
                            8,
                            "ASUS",
                            "GAMING"),
                    buildProduct(
                            "MacBook Air M2",
                            26990000,
                            "1711079954090-apple-01.png",
                            "Apple M2, 16GB RAM, 512GB SSD, mong nhe va pin ben cho di chuyen.",
                            "Thin and light laptop",
                            6,
                            "APPLE",
                            "MONG-NHE")));
        }

        User customer = userRepository.findByEmail("customer@laptopshop.dev");
        seedDemoOrders(customer);
        seedDemoCart(customer);
    }

    private Role ensureRole(String name, String description) {
        Role role = roleRepository.findByName(name);
        if (role != null) {
            return role;
        }

        Role newRole = new Role();
        newRole.setName(name);
        newRole.setDescription(description);
        return roleRepository.save(newRole);
    }

    private void ensureUser(String email, String rawPassword, String fullName, String address, String phone, Role role) {
        if (userRepository.existsByEmail(email)) {
            return;
        }

        User user = new User();
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(rawPassword));
        user.setFullName(fullName);
        user.setAddress(address);
        user.setPhone(phone);
        user.setAvatar("default.png");
        user.setRole(role);
        userRepository.save(user);
    }

    private Product buildProduct(
            String name,
            double price,
            String image,
            String detailDesc,
            String shortDesc,
            long quantity,
            String factory,
            String target) {
        Product product = new Product();
        product.setName(name);
        product.setPrice(price);
        product.setImage(image);
        product.setDetailDesc(detailDesc);
        product.setShortDesc(shortDesc);
        product.setQuantity(quantity);
        product.setSold(0);
        product.setFactory(factory);
        product.setTarget(target);
        return product;
    }

    private void seedDemoOrders(User customer) {
        if (customer == null || !orderRepository.findByUser(customer).isEmpty()) {
            return;
        }

        List<Product> products = productRepository.findAll();
        if (products.isEmpty()) {
            return;
        }

        Product office = products.get(0);
        Product gaming = products.size() > 1 ? products.get(1) : office;
        Product premium = products.size() > 2 ? products.get(2) : gaming;

        createOrder(customer, "DELIVERED", "BANKING", List.of(
                createOrderLine(office, 1),
                createOrderLine(premium, 1)));

        createOrder(customer, "CONFIRMED", "COD", List.of(
                createOrderLine(gaming, 1)));
    }

    private void seedDemoCart(User customer) {
        if (customer == null || cartRepository.findByUser(customer) != null) {
            return;
        }

        List<Product> products = productRepository.findAll();
        if (products.isEmpty()) {
            return;
        }

        Product product = products.size() > 1 ? products.get(1) : products.get(0);
        if (product.getQuantity() < 1) {
            return;
        }

        Cart cart = new Cart();
        cart.setUser(customer);
        cart.setSum(1);
        cart = cartRepository.save(cart);

        CartDetail cartDetail = new CartDetail();
        cartDetail.setCart(cart);
        cartDetail.setProduct(product);
        cartDetail.setQuantity(1);
        cartDetail.setPrice(product.getPrice());
        cartDetailRepository.save(cartDetail);
    }

    private OrderDetailSeed createOrderLine(Product product, long quantity) {
        return new OrderDetailSeed(product, quantity);
    }

    private void createOrder(User customer, String status, String paymentMethod, List<OrderDetailSeed> lines) {
        if (lines == null || lines.isEmpty()) {
            return;
        }

        double totalPrice = 0;
        for (OrderDetailSeed line : lines) {
            if (line.product == null || line.quantity < 1 || line.product.getQuantity() < line.quantity) {
                return;
            }
            totalPrice += line.product.getPrice() * line.quantity;
        }

        Order order = new Order();
        order.setUser(customer);
        order.setReceiverName(customer.getFullName());
        order.setReceiverAddress(customer.getAddress());
        order.setReceiverPhone(customer.getPhone());
        order.setStatus(status);
        order.setPaymentMethod(paymentMethod);
        order.setTotalPrice(totalPrice);
        order = orderRepository.save(order);

        for (OrderDetailSeed line : lines) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(line.product);
            orderDetail.setPrice(line.product.getPrice());
            orderDetail.setQuantity(line.quantity);
            orderDetailRepository.save(orderDetail);

            line.product.setQuantity(line.product.getQuantity() - line.quantity);
            line.product.setSold(line.product.getSold() + line.quantity);
            productRepository.save(line.product);
        }
    }

    private record OrderDetailSeed(Product product, long quantity) {
    }
}
