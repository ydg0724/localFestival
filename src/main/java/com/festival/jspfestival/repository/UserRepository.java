package com.festival.jspfestival.repository;

import com.festival.jspfestival.model.user;
import org.springframework.data.jpa.repository.JpaRepository;
//DB와 상호작용하는 인터페이스 (JPA사용) -> JpaRepository 상속받으면 CRUD메소드를 제공받음
public interface UserRepository extends JpaRepository<user,Integer> {

}
