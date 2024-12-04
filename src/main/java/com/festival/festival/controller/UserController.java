package com.festival.festival.controller;


import com.festival.festival.model.users;
import com.festival.festival.repository.UserRepository;
import com.festival.festival.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController //RESTful 컨트롤러 선언
@RequestMapping("/api") //기본 API 경로를 /api로 설정
public class UserController {


    @Autowired      //UserService를 주입받음
    private UserService userService;
    @Autowired
    private UserRepository userRepository;

    //회원가입 요청 처리
    @PostMapping("/register") //HTTP POST 요청 처리
    public ResponseEntity<String> register(@RequestBody users users) {
        if(userService.registerUser(users)){
            return ResponseEntity.ok("회원가입 성공");
        }else{
            return ResponseEntity.badRequest().body("이미 존재하는 아이디입니다.");
        }
    }

    //로그인 API
    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody users loginRequest, HttpSession session) {
        //User 조회
        users users = userRepository.findByUsername(loginRequest.getUsername());
        if(users == null || !users.getPassword().equals(loginRequest.getPassword())){
            return ResponseEntity.badRequest().body("아이디 또는 비밀번호가 잘못되었습니다.");
        }

        session.setAttribute("user", users);

        return ResponseEntity.ok("로그인 성공");

    }

}
