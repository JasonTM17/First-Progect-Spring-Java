package vn.hoidanit.laptopshop.domain.dto;

import java.util.List;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.Product;

public class DashboardMetricsDTO {

    private final long countUsers;
    private final long countProducts;
    private final long countOrders;
    private final double totalRevenue;
    private final List<Order> recentOrders;
    private final List<Product> lowStockProducts;
    private final List<DailyRevenueDTO> revenueSeries;
    private final List<FactoryStatDTO> factoryStats;
    private final List<DashboardActivityDTO> activities;

    public DashboardMetricsDTO(
            long countUsers,
            long countProducts,
            long countOrders,
            double totalRevenue,
            List<Order> recentOrders,
            List<Product> lowStockProducts,
            List<DailyRevenueDTO> revenueSeries,
            List<FactoryStatDTO> factoryStats,
            List<DashboardActivityDTO> activities) {
        this.countUsers = countUsers;
        this.countProducts = countProducts;
        this.countOrders = countOrders;
        this.totalRevenue = totalRevenue;
        this.recentOrders = recentOrders;
        this.lowStockProducts = lowStockProducts;
        this.revenueSeries = revenueSeries;
        this.factoryStats = factoryStats;
        this.activities = activities;
    }

    public long getCountUsers() {
        return countUsers;
    }

    public long getCountProducts() {
        return countProducts;
    }

    public long getCountOrders() {
        return countOrders;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public List<Order> getRecentOrders() {
        return recentOrders;
    }

    public List<Product> getLowStockProducts() {
        return lowStockProducts;
    }

    public List<DailyRevenueDTO> getRevenueSeries() {
        return revenueSeries;
    }

    public List<FactoryStatDTO> getFactoryStats() {
        return factoryStats;
    }

    public List<DashboardActivityDTO> getActivities() {
        return activities;
    }
}
