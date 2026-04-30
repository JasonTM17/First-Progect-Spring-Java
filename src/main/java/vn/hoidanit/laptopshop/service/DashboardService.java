package vn.hoidanit.laptopshop.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderStatus;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.dto.DailyRevenueDTO;
import vn.hoidanit.laptopshop.domain.dto.DashboardActivityDTO;
import vn.hoidanit.laptopshop.domain.dto.DashboardMetricsDTO;
import vn.hoidanit.laptopshop.domain.dto.FactoryStatDTO;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.repository.UserRepository;

@Service
public class DashboardService {

    private static final long LOW_STOCK_THRESHOLD = 3;

    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;

    public DashboardService(
            UserRepository userRepository,
            ProductRepository productRepository,
            OrderRepository orderRepository) {
        this.userRepository = userRepository;
        this.productRepository = productRepository;
        this.orderRepository = orderRepository;
    }

    public DashboardMetricsDTO getMetrics() {
        List<Order> recentOrders = orderRepository.findTop30ByOrderByIdDesc();
        List<Product> lowStockProducts = productRepository
                .findTop5ByQuantityLessThanEqualOrderByQuantityAsc(LOW_STOCK_THRESHOLD);

        return new DashboardMetricsDTO(
                userRepository.count(),
                productRepository.count(),
                orderRepository.count(),
                orderRepository.sumTotalRevenue(),
                recentOrders.stream().limit(5).toList(),
                lowStockProducts,
                buildRevenueSeries(recentOrders),
                buildFactoryStats(),
                buildActivities(recentOrders, lowStockProducts));
    }

    private List<DailyRevenueDTO> buildRevenueSeries(List<Order> recentOrders) {
        if (recentOrders == null || recentOrders.isEmpty()) {
            return List.of(new DailyRevenueDTO("Chưa có đơn", 0));
        }

        List<Order> chronological = new ArrayList<>(recentOrders);
        Collections.reverse(chronological);
        return chronological.stream()
                .map(order -> new DailyRevenueDTO("#" + order.getId(), order.getTotalPrice()))
                .toList();
    }

    private List<FactoryStatDTO> buildFactoryStats() {
        return productRepository.countProductsByFactory().stream()
                .map(row -> new FactoryStatDTO(
                        row[0] == null || row[0].toString().isBlank() ? "Khác" : row[0].toString(),
                        ((Number) row[1]).longValue()))
                .toList();
    }

    private List<DashboardActivityDTO> buildActivities(List<Order> recentOrders, List<Product> lowStockProducts) {
        List<DashboardActivityDTO> activities = new ArrayList<>();

        if (recentOrders != null) {
            recentOrders.stream().limit(3).forEach(order -> activities.add(new DashboardActivityDTO(
                    "bi bi-receipt",
                    "success",
                    "Đơn #" + order.getId() + " - " + OrderStatus.label(order.getStatus()),
                    order.getUser() == null ? "Khách hàng chưa xác định" : order.getUser().getEmail())));
        }

        if (lowStockProducts != null && !lowStockProducts.isEmpty()) {
            Product product = lowStockProducts.get(0);
            activities.add(new DashboardActivityDTO(
                    "bi bi-box-seam",
                    "warning",
                    product.getName() + " sắp hết hàng",
                    "Còn " + product.getQuantity() + " sản phẩm"));
        }

        if (activities.isEmpty()) {
            activities.add(new DashboardActivityDTO(
                    "bi bi-lightning-charge",
                    "info",
                    "Hệ thống đã sẵn sàng vận hành",
                    "Chưa có đơn hàng mới trong dữ liệu hiện tại"));
        }

        return activities.stream().limit(5).toList();
    }
}
