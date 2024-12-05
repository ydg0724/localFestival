package com.festival.festival.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


// React와 Spring boot 간의 요청이 다른 포트를 사용하므로 CORS 설정이 필요함
@Configuration // Spring 설정 클래스
public class CorsConfig {

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/api/**") // "/api/**" 경로에 대해 CORS 허용
                        .allowedOrigins("http://localhost:3000") // React 개발 서버 URL
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS") // 허용할 HTTP 메서드
                        .allowedHeaders("*"); // 모든 헤더 허용
            }
        };
    }
}
