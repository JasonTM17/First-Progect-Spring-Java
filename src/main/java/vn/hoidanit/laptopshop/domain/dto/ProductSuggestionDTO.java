package vn.hoidanit.laptopshop.domain.dto;

import vn.hoidanit.laptopshop.domain.Product;

public class ProductSuggestionDTO {

    private final long id;
    private final String name;
    private final String image;
    private final double price;
    private final String factory;

    public ProductSuggestionDTO(long id, String name, String image, double price, String factory) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.price = price;
        this.factory = factory;
    }

    public static ProductSuggestionDTO from(Product product) {
        return new ProductSuggestionDTO(
                product.getId(),
                product.getName(),
                product.getImage(),
                product.getPrice(),
                product.getFactory());
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getImage() {
        return image;
    }

    public double getPrice() {
        return price;
    }

    public String getFactory() {
        return factory;
    }
}
