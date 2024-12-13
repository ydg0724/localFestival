package com.festival.jspfestival.service;


import com.festival.jspfestival.model.user;
import com.festival.jspfestival.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    //회원가입 처리
    public boolean register(user newUser) {
        //중복된 username이 있는지 확인
        Optional<user> existingUser = userRepository.findAll()
                .stream()
                .filter(u -> u.getUsername().equals(newUser.getUsername()))
                .findFirst();
        //이미 존재하는 username이 있는경우
        if (existingUser.isPresent()) {
            return false;
        }
        userRepository.save(newUser);
        return true;
    }

    public user login(String username, String password){
        Optional<user> optionalUser = userRepository.findAll()
                .stream()
                .filter(u -> u.getUsername().equals(username) && u.getPassword().equals(password))
                .findFirst();
        return optionalUser.orElse(null);
    }
}

