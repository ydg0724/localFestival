package com.festival.jspfestival.repository;

import com.festival.jspfestival.model.Route;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RouteRepository extends JpaRepository<Route, Integer> {
    List<Route> findByUser_Id(int userId);


}
