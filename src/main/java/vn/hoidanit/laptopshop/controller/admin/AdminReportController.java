package vn.hoidanit.laptopshop.controller.admin;

import java.nio.charset.StandardCharsets;

import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderStatus;
import vn.hoidanit.laptopshop.service.OrderService;

@Controller
public class AdminReportController {

    private final OrderService orderService;

    public AdminReportController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping(value = "/admin/report/orders.csv", produces = "text/csv; charset=UTF-8")
    public ResponseEntity<String> exportOrdersCsv() {
        StringBuilder csv = new StringBuilder("\uFEFF");
        csv.append("id,customer_email,customer_name,total_price,status,payment_method,receiver_name,receiver_phone\n");

        for (Order order : orderService.fetchOrdersForReport()) {
            csv.append(order.getId()).append(',')
                    .append(csv(order.getUser() == null ? "" : order.getUser().getEmail())).append(',')
                    .append(csv(order.getUser() == null ? "" : order.getUser().getFullName())).append(',')
                    .append(order.getTotalPrice()).append(',')
                    .append(csv(OrderStatus.label(order.getStatus()))).append(',')
                    .append(csv(order.getPaymentMethod())).append(',')
                    .append(csv(order.getReceiverName())).append(',')
                    .append(csv(order.getReceiverPhone())).append('\n');
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentDisposition(ContentDisposition.attachment().filename("laptopshop-orders.csv").build());
        headers.setContentType(new MediaType("text", "csv", StandardCharsets.UTF_8));
        return ResponseEntity.ok().headers(headers).body(csv.toString());
    }

    private String csv(String value) {
        String safe = value == null ? "" : value;
        return "\"" + safe.replace("\"", "\"\"") + "\"";
    }
}
