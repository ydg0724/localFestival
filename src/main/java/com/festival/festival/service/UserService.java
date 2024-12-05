package com.festival.festival.service;

import com.festival.festival.model.users;
import com.festival.festival.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service    //service 계층
public class UserService {

    @Autowired      //UserRepository를 주입받음
    private UserRepository userRepository;

    //회원가입 로직
    public boolean registerUser(users users) {
        //중복된 username 체크
        if(userRepository.existsByUsername(users.getUsername())) {
            return false;
        }
        userRepository.save(users);
        return true;
    }
}
