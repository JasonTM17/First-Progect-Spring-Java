package vn.hoidanit.laptopshop.domain.dto;

public class DashboardActivityDTO {

    private final String iconClass;
    private final String tone;
    private final String title;
    private final String meta;

    public DashboardActivityDTO(String iconClass, String tone, String title, String meta) {
        this.iconClass = iconClass;
        this.tone = tone;
        this.title = title;
        this.meta = meta;
    }

    public String getIconClass() {
        return iconClass;
    }

    public String getTone() {
        return tone;
    }

    public String getTitle() {
        return title;
    }

    public String getMeta() {
        return meta;
    }
}
