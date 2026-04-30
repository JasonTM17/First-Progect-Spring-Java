package vn.hoidanit.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.OrderStatus;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository
    ) {
        this.orderDetailRepository = orderDetailRepository;
        this.orderRepository = orderRepository;
    }

    public Page<Order> fetchAllOrders(Pageable page) {
        return this.orderRepository.findAll(page);
    }

    public Page<Order> searchAdminOrders(Pageable page, String keyword, String status) {
        return this.orderRepository.searchAdminOrders(
                normalizeFilter(keyword),
                normalizeStatusFilter(status),
                page);
    }

    public List<Order> fetchRecentOrders(int limit) {
        int size = Math.max(1, limit);
        Pageable page = PageRequest.of(0, size, Sort.by(Sort.Direction.DESC, "id"));
        return this.orderRepository.findAll(page).getContent();
    }

    public double calculateTotalRevenue() {
        return this.orderRepository.sumTotalRevenue();
    }

    public Optional<Order> fetchOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public List<Order> fetchOrdersForReport() {
        return this.orderRepository.findAllByOrderByIdDesc();
    }

    @Transactional
    public void deleteOrderById(long id) {
        // delete order detail
        Optional<Order> orderOptional = this.fetchOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = order.getOrderDetails();
            for (OrderDetail orderDetail : orderDetails) {
                this.orderDetailRepository.deleteById(orderDetail.getId());
            }
        }

        this.orderRepository.deleteById(id);
    }

    @Transactional
    public void updateOrder(Order order) {
        Optional<Order> orderOptional = this.fetchOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            String nextStatus = OrderStatus.normalize(order.getStatus());
            if (!OrderStatus.canTransition(currentOrder.getStatus(), nextStatus)) {
                throw new IllegalArgumentException("Không thể chuyển trạng thái từ "
                        + OrderStatus.label(currentOrder.getStatus()) + " sang " + OrderStatus.label(nextStatus));
            }
            currentOrder.setStatus(nextStatus);
            this.orderRepository.save(currentOrder);
        }
    }

    public List<Order> fetchOrderByUser(User user) {
        if (user == null || user.getId() <= 0) {
            return List.of();
        }
        return this.orderRepository.findByUser(user);
    }

    private String normalizeFilter(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isBlank() ? null : trimmed;
    }

    private String normalizeStatusFilter(String status) {
        String normalized = normalizeFilter(status);
        if (normalized == null) {
            return null;
        }
        return OrderStatus.isKnown(normalized) ? OrderStatus.normalize(normalized) : normalized;
    }

}
