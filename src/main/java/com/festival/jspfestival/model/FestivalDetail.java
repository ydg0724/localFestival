package com.festival.jspfestival.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class FestivalDetail {
    @JsonProperty("contentid")
    private String contentid;

    @JsonProperty("firstimage")
    private String firstimage;

    @JsonProperty("title")
    private String title;

    @JsonProperty("addr1") // JSON 필드와 매핑
    private String addr;

    @JsonProperty("tel")
    private String tel;

    @JsonProperty("overview")
    private String overview;

    public String getAddr() { return addr; }
    public void setAddr(String addr) { this.addr = addr; }

    @JsonProperty("mapx")
    private double mapX;

    @JsonProperty("mapy")
    private double mapY;

    public Double getMapX() {
        return mapX;
    }

    public void setMapX(Double mapX) {
        this.mapX = mapX;
    }

    public Double getMapY() {
        return mapY;
    }

    public void setMapY(Double mapY) {
        this.mapY = mapY;
    }

    // Getters and Setters
    public String getContentId() { return contentid; }
    public void setContentId(String contentid) { this.contentid = contentid; }

    public String getFirstimage() { return firstimage; }
    public void setFirstimage(String firstimage) { this.firstimage = firstimage; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getTel() { return tel; }
    public void setTel(String tel) { this.tel = tel; }

    public String getOverview() { return overview; }
    public void setOverview(String overview) { this.overview = overview; }
}

