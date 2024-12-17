package com.festival.jspfestival.service;


import com.festival.jspfestival.model.Route;
import com.festival.jspfestival.model.user;
import com.festival.jspfestival.repository.RouteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class RouteService {

    @Autowired
    private RouteRepository routeRepository;

    public Route saveRoute(user user, List<String> contentIds){
        String contentIdsString = String.join(",", contentIds); //List를 ,로 연결
        Route route = new Route(user, contentIdsString);
        return routeRepository.save(route);
    }

    public List<String> getContentIds(int routeId){
        Route route = routeRepository.findById(routeId).orElse(null);
        if(route!=null){
            return Arrays.asList(route.getContentIds().split(","));
        }
        return null;
    }

    public List<Route> getRoutesByUserId(int userId){
        return routeRepository.findByUser_Id(userId);
    }

    public void deleteRoute(int id){
        routeRepository.deleteById(id);
    }
}
