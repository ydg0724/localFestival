package com.festival.jspfestival.controller;

import com.festival.jspfestival.model.Route;
import com.festival.jspfestival.model.user;
import com.festival.jspfestival.service.RouteService;
import com.festival.jspfestival.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/routes")
public class RouteController {

    @Autowired
    private RouteService routeService;
    @Autowired
    private UserService userService;

    @PostMapping("/add")
    public String addRoute(@RequestParam int userId, @RequestParam String contentIds){
        user user = userService.findById(userId);
        if(user != null){
            List<String> contentIdList = Arrays.asList(contentIds.split(","));
            routeService.saveRoute(user,contentIdList);
        }
        return "redirect:/main";
    }

    @GetMapping("/list/{userId}")
    public String listRoutes(@PathVariable int userId, Model model){
        List<Route> routes = routeService.getRoutesByUserId(userId);
        model.addAttribute("routes",routes);
        return "routeList";
    }

    @PostMapping("/delete/{id}")
    public String deleteRoute(@PathVariable int id){
        routeService.deleteRoute(id);
        return "redirect:/main";
    }
}
