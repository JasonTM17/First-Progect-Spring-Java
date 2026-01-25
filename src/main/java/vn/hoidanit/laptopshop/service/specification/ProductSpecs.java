package vn.hoidanit.laptopshop.service.specification;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import vn.hoidanit.laptopshop.domain.Product;

public class ProductSpecs {

    public static Specification<Product> nameLike(String name) {
        return (root, query, cb)
                -> cb.like(
                        root.get("name"), "%" + name + "%"
                );
    }

    public static Specification<Product> minPrice(double price) {
        return (root, query, cb)
                -> cb.ge(
                        root.get("price"), price
                );
    }

    public static Specification<Product> maxPrice(double price) {
        return (root, query, cb)
                -> cb.le(
                        root.get("price"), price
                );
    }

    public static Specification<Product> matchFactory(String factory) {
        return (root, query, cb)
                -> cb.equal(
                        root.get("factory"), factory
                );
    }

    // case 4: match list target
    public static Specification<Product> matchListTarget(List<String> target) {
        return (root, query, cb)
                -> root.get("target").in(target);
    }

    public static Specification<Product> matchListFactory(List<String> factory) {
        return (root, query, cb)
                -> root.get("factory").in(factory);
    }

    public static Specification<Product> matchPrice(double min, double max) {
        return (root, query, cb)
                -> cb.and(
                        cb.ge(root.get("price"), min),
                        cb.le(root.get("price"), max)
                );
    }

    // case 6
    public static Specification<Product> matchMultiplePrice(double min, double max) {
        return (root, query, cb)
                -> cb.between(
                        root.get("price"), min, max
                );
    }

}
