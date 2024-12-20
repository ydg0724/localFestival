package com.festival.jspfestival.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Route")
public class Route {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "trip_name", nullable = false)
    private String tripName; // 경로 제목

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private user user;

    @Column(name = "contentid", nullable = false)
    private String contentIds; // 콤마(,)로 구분된 contentid 목록

    // 기본 생성자
    public Route() {}

    // 생성자
    public Route(String tripName, user user, String contentIds) {
        this.tripName = tripName;
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

    public String getTripName() {
        return tripName;
    }

    public void setTripName(String tripName) {
        this.tripName = tripName;
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
