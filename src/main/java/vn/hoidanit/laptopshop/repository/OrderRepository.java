package vn.hoidanit.laptopshop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    @EntityGraph(attributePaths = {"user", "orderDetails", "orderDetails.product"})
    List<Order> findByUser(User user);

    @EntityGraph(attributePaths = {"user", "orderDetails", "orderDetails.product"})
    Optional<Order> findById(Long id);

    @EntityGraph(attributePaths = {"user"})
    List<Order> findTop30ByOrderByIdDesc();

    @EntityGraph(attributePaths = {"user"})
    List<Order> findAllByOrderByIdDesc();

    @Query("select coalesce(sum(o.totalPrice), 0) from Order o")
    double sumTotalRevenue();

    @EntityGraph(attributePaths = {"user"})
    @Query("""
            select o from Order o
            left join o.user u
            where (:keyword is null
                or str(o.id) like concat('%', :keyword, '%')
                or lower(o.receiverName) like lower(concat('%', :keyword, '%'))
                or lower(o.receiverPhone) like lower(concat('%', :keyword, '%'))
                or lower(o.receiverAddress) like lower(concat('%', :keyword, '%'))
                or lower(u.email) like lower(concat('%', :keyword, '%'))
                or lower(u.fullName) like lower(concat('%', :keyword, '%')))
            and (:status is null or o.status = :status)
            """)
    Page<Order> searchAdminOrders(
            @Param("keyword") String keyword,
            @Param("status") String status,
            Pageable page);
}
