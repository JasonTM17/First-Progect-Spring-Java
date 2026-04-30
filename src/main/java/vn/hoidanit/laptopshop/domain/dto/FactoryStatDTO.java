package vn.hoidanit.laptopshop.domain.dto;

public class FactoryStatDTO {

    private final String label;
    private final long count;

    public FactoryStatDTO(String label, long count) {
        this.label = label;
        this.count = count;
    }

    public String getLabel() {
        return label;
    }

    public long getCount() {
        return count;
    }
}
