package vn.hoidanit.laptopshop.controller.admin;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriUtils;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderStatus;
import vn.hoidanit.laptopshop.service.OrderService;

@Controller
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getDashboard(
            Model model,
            @RequestParam("page") Optional<String> pageOptional,
            @RequestParam("q") Optional<String> queryOptional,
            @RequestParam("status") Optional<String> statusOptional
    ) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Math.max(1, Integer.parseInt(pageOptional.get()));
            }
        } catch (NumberFormatException ignored) {
        }
        String query = normalizeParam(queryOptional);
        String status = normalizeParam(statusOptional);
        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<Order> ordersPage = this.orderService.searchAdminOrders(pageable, query, status);
        List<Order> orders = ordersPage.getContent();

        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", ordersPage.getTotalPages());
        model.addAttribute("query", query);
        model.addAttribute("statusFilter", status);
        model.addAttribute("filterQuery", buildFilterQuery(query, status));

        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Order order = this.orderService.fetchOrderById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Order not found"));
        model.addAttribute("order", order);
        model.addAttribute("id", id);
        model.addAttribute("orderDetails", order.getOrderDetails());
        return "admin/order/detail";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id) {
        this.orderService.fetchOrderById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Order not found"));
        model.addAttribute("id", id);
        model.addAttribute("newOrder", new Order());
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String postDeleteOrder(@ModelAttribute("newOrder") Order order) {
        this.orderService.deleteOrderById(order.getId());
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        Order order = currentOrder
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Order not found"));
        model.addAttribute("newOrder", order);
        model.addAttribute("statusOptions", OrderStatus.allowedOptions(order.getStatus()));
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String handleUpdateOrder(@ModelAttribute("newOrder") Order order, RedirectAttributes redirectAttributes) {
        try {
            this.orderService.updateOrder(order);
            redirectAttributes.addFlashAttribute("success", "Đã cập nhật trạng thái đơn hàng");
        } catch (IllegalArgumentException ex) {
            redirectAttributes.addFlashAttribute("error", ex.getMessage());
            return "redirect:/admin/order/update/" + order.getId();
        }
        return "redirect:/admin/order";
    }

    private String normalizeParam(Optional<String> value) {
        return value.map(String::trim).filter(v -> !v.isBlank()).orElse(null);
    }

    private String buildFilterQuery(String query, String status) {
        StringBuilder builder = new StringBuilder();
        if (query != null) {
            builder.append("&q=").append(UriUtils.encodeQueryParam(query, StandardCharsets.UTF_8));
        }
        if (status != null) {
            builder.append("&status=").append(UriUtils.encodeQueryParam(status, StandardCharsets.UTF_8));
        }
        return builder.toString();
    }

}
