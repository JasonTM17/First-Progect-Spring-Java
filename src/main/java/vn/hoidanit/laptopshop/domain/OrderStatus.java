package vn.hoidanit.laptopshop.domain;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

public final class OrderStatus {

    public static final String PENDING = "PENDING";
    public static final String CONFIRMED = "CONFIRMED";
    public static final String SHIPPING = "SHIPPING";
    public static final String DELIVERED = "DELIVERED";
    public static final String CANCELLED = "CANCELLED";

    private static final Map<String, String> LABELS = Map.of(
            PENDING, "Chờ xử lý",
            CONFIRMED, "Đã xác nhận",
            SHIPPING, "Đang giao",
            DELIVERED, "Đã giao",
            CANCELLED, "Huỷ"
    );

    private static final Map<String, List<String>> TRANSITIONS = Map.of(
            PENDING, List.of(CONFIRMED, CANCELLED),
            CONFIRMED, List.of(SHIPPING, CANCELLED),
            SHIPPING, List.of(DELIVERED),
            DELIVERED, List.of(),
            CANCELLED, List.of()
    );

    private OrderStatus() {
    }

    public static String normalize(String status) {
        if (status == null || status.isBlank()) {
            return PENDING;
        }
        String normalized = status.trim().toUpperCase(Locale.ROOT);
        if ("COMPLETE".equals(normalized)) {
            return DELIVERED;
        }
        if ("CANCEL".equals(normalized)) {
            return CANCELLED;
        }
        return normalized;
    }

    public static boolean isKnown(String status) {
        return LABELS.containsKey(normalize(status));
    }

    public static boolean canTransition(String currentStatus, String nextStatus) {
        String current = normalize(currentStatus);
        String next = normalize(nextStatus);
        if (!isKnown(current) || !isKnown(next)) {
            return false;
        }
        if (current.equals(next)) {
            return true;
        }
        return Set.copyOf(TRANSITIONS.getOrDefault(current, List.of())).contains(next);
    }

    public static String label(String status) {
        return LABELS.getOrDefault(normalize(status), "Chờ xử lý");
    }

    public static Map<String, String> allowedOptions(String currentStatus) {
        String current = normalize(currentStatus);
        LinkedHashMap<String, String> options = new LinkedHashMap<>();
        options.put(current, label(current));
        for (String status : TRANSITIONS.getOrDefault(current, List.of())) {
            options.put(status, label(status));
        }
        return options;
    }
}
