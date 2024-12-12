package com.festival.jspfestival.model;

public class festival {

    private String addr;            //주소
    private String contentId;       //컨텐츠ID
    private String eventStartDate;  //행시시작일
    private String eventEndDate;    //행사종료일
    private String Image1;          //대표이미지1(원본)
    private String Image2;          //대표이미지2(썸네일)
    private String mapX;            //X좌표
    private String mapY;            //Y좌표
    private String tel;             //전화번호
    private String title;           //제목

    public String getAddr() {
        return addr;
    }
    public void setAddr(String addr) {
        this.addr = addr;
    }
    public String getContentId() {
        return contentId;
    }
    public void setContentId(String contentId) {
        this.contentId = contentId;
    }
    public String getEventStartDate() {
        return eventStartDate;
    }
    public void setEventStartDate(String eventStartDate) {
        this.eventStartDate = eventStartDate;
    }
    public String getEventEndDate() {
        return eventEndDate;
    }
    public void setEventEndDate(String eventEndDate) {
        this.eventEndDate = eventEndDate;
    }
    public String getImage1() {
        return Image1;
    }
    public void setImage1(String image1) {
        Image1 = image1;
    }
    public String getImage2() {
        return Image2;
    }
    public void setImage2(String image2) {
        Image2 = image2;
    }
    public String getMapX() {
        return mapX;
    }
    public void setMapX(String mapX) {
        this.mapX = mapX;
    }
    public String getMapY() {
        return mapY;
    }
    public void setMapY(String mapY) {
        this.mapY = mapY;
    }
    public String getTel() {
        return tel;
    }
    public void setTel(String tel) {
        this.tel = tel;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

}
