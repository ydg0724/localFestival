package com.festival.festival.repository;

import com.festival.festival.model.users;
import org.springframework.data.jpa.repository.JpaRepository;

//DB와 상호작용하는 인터페이스 (JPA사용) -> JpaRepository 상속받으면 CRUD메소드를 제공받음
public interface UserRepository extends JpaRepository<users, Integer> {
    //중복된
    boolean existsByUsername(String username);
    users findByUsername(String username);
}
