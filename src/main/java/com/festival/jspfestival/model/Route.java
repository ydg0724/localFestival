package com.festival.jspfestival.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Route") //Route 테이블 생성
public class Route {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private user user;

    @Column(name = "contentid", nullable = false)
    private String contentIds; // 콤마(,)로 구분된 contentid 목록을 저장

    // 기본 생성자
    public Route() {}

    // 생성자
    public Route(user user, String contentIds) {
        this.user = user;
        this.contentIds = contentIds;
    }

    // Getter와 Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public user getUser() {
        return user;
    }

    public void setUser(user user) {
        this.user = user;
    }

    public String getContentIds() {
        return contentIds;
    }

    public void setContentIds(String contentIds) {
        this.contentIds = contentIds;
    }
}
