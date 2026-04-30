package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.User;

public interface CartRepository extends JpaRepository<Cart, Long> {

    Cart findByUser(User user);

    Cart findByUserId(long id);

    @EntityGraph(attributePaths = {"cartDetails", "cartDetails.product"})
    @Query("select c from Cart c where c.user.id = :userId")
    Cart findByUserIdWithDetails(@Param("userId") long userId);

}
