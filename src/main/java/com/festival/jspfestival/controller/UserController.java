package com.festival.jspfestival.controller;

import com.festival.jspfestival.model.user;
import com.festival.jspfestival.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    //로그인 페이지 이동
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // login.jsp를 반환합니다.
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session){
        user loginUser = userService.login(username,password);
        if(loginUser != null){
            session.setAttribute("user", loginUser); //세션에 사용자 정보 저장
            return "redirect:/"; //메인페이지로 이동
        } else{
            return "redirect:/login?error=true"; //로그인 실패 시
        }
    }
    
    @PostMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();   //세션 종료
        return "redirect:/"; //메인 페이지로 이동
    }

    //회원가입 페이지
    @GetMapping("/register")
    public String showRegisterPage() {
        return "register"; // "register.jsp"를 반환
    }

    //회원가입 처리
    @PostMapping("/register")
    public String register(@RequestParam String name,
                           @RequestParam String username,
                           @RequestParam String password){
        user newUser = new user();
        newUser.setName(name);
        newUser.setPassword(password);
        newUser.setUsername(username);

        boolean isRegistered = userService.register(newUser);
        if(isRegistered){
            return "redirect:/login"; // 회원가입 성공 시 로그인 페이지로 리다이렉트
        } else{
            return "redirect:/register?error=true";// 증복된 username으로 인한 회원가입 실패 시
        }

    }

}
