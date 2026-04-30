package vn.hoidanit.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {

    Page<Product> findAll(Pageable page);

    Page<Product> findAll(Specification<Product> spec, Pageable page);

    Page<Product> findByNameContainingIgnoreCase(String name, Pageable page);

    @Query("""
            select p from Product p
            where (:keyword is null
                or lower(p.name) like lower(concat('%', :keyword, '%'))
                or lower(p.factory) like lower(concat('%', :keyword, '%'))
                or lower(p.target) like lower(concat('%', :keyword, '%')))
            and (:factory is null or p.factory = :factory)
            """)
    Page<Product> searchAdminProducts(
            @Param("keyword") String keyword,
            @Param("factory") String factory,
            Pageable page);

    List<Product> findTop5ByQuantityLessThanEqualOrderByQuantityAsc(long quantity);

    @Query("select coalesce(p.factory, 'Khác'), count(p) from Product p group by p.factory order by count(p) desc")
    List<Object[]> countProductsByFactory();

}
