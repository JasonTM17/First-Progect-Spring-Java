package vn.hoidanit.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    User save(User hoidanit);

    void deleteById(long id);

    List<User> findOneByEmail(String email);

    List<User> findAll();

    User findById(long id);

    boolean existsByEmail(String email);

    User findByEmail(String email);

    @Query("""
            select u from User u
            left join u.role r
            where (:keyword is null
                or lower(u.email) like lower(concat('%', :keyword, '%'))
                or lower(u.fullName) like lower(concat('%', :keyword, '%'))
                or lower(u.phone) like lower(concat('%', :keyword, '%'))
                or lower(u.address) like lower(concat('%', :keyword, '%')))
            and (:role is null or r.name = :role)
            """)
    Page<User> searchAdminUsers(
            @Param("keyword") String keyword,
            @Param("role") String role,
            Pageable page);
}
