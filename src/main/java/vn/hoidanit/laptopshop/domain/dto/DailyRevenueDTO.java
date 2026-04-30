package vn.hoidanit.laptopshop.domain.dto;

public class DailyRevenueDTO {

    private final String label;
    private final double revenue;

    public DailyRevenueDTO(String label, double revenue) {
        this.label = label;
        this.revenue = revenue;
    }

    public String getLabel() {
        return label;
    }

    public double getRevenue() {
        return revenue;
    }
}
