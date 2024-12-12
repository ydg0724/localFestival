package com.festival.jspfestival.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.ui.Model;

@Controller
public class MainController {
    @Value("${google.maps.api.key}")
    private String googleMapsApiKey;

    @RequestMapping("/main")
    public String mainPage(Model model) {
        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
        return "main";
    }

}
