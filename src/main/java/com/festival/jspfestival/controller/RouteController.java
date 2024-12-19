package com.festival.jspfestival.controller;

import com.festival.jspfestival.model.Route;
import com.festival.jspfestival.model.user;
import com.festival.jspfestival.service.RouteService;
import com.festival.jspfestival.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/routes")
public class RouteController {

    @Autowired
    private RouteService routeService;
    @Autowired
    private UserService userService;

    // 경로 저장
    @PostMapping("/save")
    @ResponseBody
    public String saveRoute(@RequestParam String tripName,
                            @RequestParam List<String> contentIds,
                            HttpSession session) {
        // 세션에서 로그인된 사용자 정보 가져오기
        user loggedInUser = (user) session.getAttribute("user");

        if (loggedInUser == null) {
            return "로그인/회원가입 후 저장 가능합니다.";
        }

        // 경로 저장
        routeService.saveRoute(tripName, loggedInUser, contentIds);
        return tripName + "이(가) 저장되었습니다.";
    }

    @GetMapping("/list/{userId}")
    public String listRoutes(@PathVariable int userId, Model model) {
        List<Route> routes = routeService.getRoutesByUserId(userId);
        model.addAttribute("routes", routes);
        return "routeList";
    }

    @PostMapping("/delete/{id}")
    public String deleteRoute(@PathVariable int id) {
        routeService.deleteRoute(id);
        return "redirect:/myPage";
    }
}
