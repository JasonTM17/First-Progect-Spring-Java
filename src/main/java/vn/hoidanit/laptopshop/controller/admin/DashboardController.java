package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.hoidanit.laptopshop.domain.dto.DashboardMetricsDTO;
import vn.hoidanit.laptopshop.service.DashboardService;

@Controller
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/admin")
    public String getDashboard(Model model) {
        DashboardMetricsDTO metrics = this.dashboardService.getMetrics();
        model.addAttribute("dashboardMetrics", metrics);
        model.addAttribute("countUsers", metrics.getCountUsers());
        model.addAttribute("countProducts", metrics.getCountProducts());
        model.addAttribute("countOrders", metrics.getCountOrders());
        model.addAttribute("recentOrders", metrics.getRecentOrders());
        model.addAttribute("lowStockProducts", metrics.getLowStockProducts());
        model.addAttribute("revenueSeries", metrics.getRevenueSeries());
        model.addAttribute("factoryStats", metrics.getFactoryStats());
        model.addAttribute("dashboardActivities", metrics.getActivities());
        model.addAttribute("totalRevenue", String.format("%,.0f VND", metrics.getTotalRevenue()));
        model.addAttribute("revenueLabelsJson", toJsonStrings(metrics.getRevenueSeries().stream()
                .map(point -> point.getLabel()).toList()));
        model.addAttribute("revenueDataJson", toJsonNumbers(metrics.getRevenueSeries().stream()
                .map(point -> point.getRevenue()).toList()));
        model.addAttribute("factoryLabelsJson", toJsonStrings(metrics.getFactoryStats().stream()
                .map(stat -> stat.getLabel()).toList()));
        model.addAttribute("factoryDataJson", toJsonNumbers(metrics.getFactoryStats().stream()
                .map(stat -> stat.getCount()).toList()));

        return "admin/dashboard/show";
    }

    private String toJsonStrings(List<String> values) {
        return values.stream()
                .map(value -> "\"" + escapeJson(value) + "\"")
                .collect(Collectors.joining(",", "[", "]"));
    }

    private String toJsonNumbers(List<? extends Number> values) {
        return values.stream()
                .map(String::valueOf)
                .collect(Collectors.joining(",", "[", "]"));
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
