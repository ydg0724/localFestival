package com.festival.jspfestival.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {

    @RequestMapping("/")
    public String mainPage() {
        return "main";
    }



    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // login.jsp를 반환합니다.
    }

    @GetMapping("/register")
    public String showRegisterPage() {
        return "register"; // "register.jsp"를 반환
    }


}
