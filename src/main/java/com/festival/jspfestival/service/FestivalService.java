package com.festival.jspfestival.service;

import com.festival.jspfestival.model.Festival;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.festival.jspfestival.model.FestivalDetail;
import com.festival.jspfestival.model.Tour;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Service
public class FestivalService {

    private static final String FEST_MAIN_API_URL = "https://apis.data.go.kr/B551011/KorService1/searchFestival1";
    private static final String FEST_DETAIL_API_URL = "http://apis.data.go.kr/B551011/KorService1/detailCommon1";
    private static final String TOUR_MAIN_API_URL = "http://apis.data.go.kr/B551011/KorService1/locationBasedList1";

//    private static final String API_KEY = "";

    public List<Festival> fetchFestivals() {
        List<Festival> festivals = new ArrayList<>();
        try {
            RestTemplate restTemplate = new RestTemplate();

            //현재 날짜
            LocalDate currentDate = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
            String formattedDate = currentDate.format(formatter);

            // URI 생성
            URI url = new URI(FEST_MAIN_API_URL + "?serviceKey=" + API_KEY +
                    "&MobileApp=AppTest" +
                    "&MobileOS=ETC" +
                    "&pageNo=1" +
                    "&numOfRows=1000" +
                    "&eventStartDate=" + formattedDate + //현재 날짜 기준으로
                    "&listYN=Y" +
                    "&arrange=A" +
                    "&_type=json");
            System.out.println("Requesting URL: " + url);

            // GET 요청 전송
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);
            String response = responseEntity.getBody();
//            System.out.println("API Response: " + response);

            // JSON 데이터 파싱
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode root = objectMapper.readTree(response);
            JsonNode items = root.path("response").path("body").path("items").path("item");

            // JSON 데이터를 Festival 객체로 매핑
            for (JsonNode item : items) {
                Festival festival = new Festival();
                festival.setAddr(item.path("addr1").asText(""));
                festival.setContentId(item.path("contentid").asText(""));
                festival.setEventStartDate(item.path("eventstartdate").asText(""));
                festival.setEventEndDate(item.path("eventenddate").asText(""));
                festival.setImage1(item.path("firstimage").asText(""));
                festival.setImage2(item.path("firstimage2").asText(""));
                festival.setMapX(item.path("mapx").asText(""));
                festival.setMapY(item.path("mapy").asText(""));
                festival.setTel(item.path("tel").asText(""));
                festival.setTitle(item.path("title").asText(""));
                festivals.add(festival);
            }
        } catch (Exception e) {
            System.err.println("API 호출 중 오류 발생:");
            e.printStackTrace();
        }
        return festivals;
    }


    public FestivalDetail fetchFestivalDetail(String contentId, String image, String addr) {
        FestivalDetail festivalDetail = new FestivalDetail();

        try {
            RestTemplate restTemplate = new RestTemplate();

            // URI 생성
            URI url = new URI("https://apis.data.go.kr/B551011/KorService1/detailCommon1?serviceKey=" + API_KEY +
                    "&MobileApp=AppTest" +
                    "&MobileOS=ETC" +
                    "&pageNo=1" +
                    "&numOfRows=1" +
                    "&contentId=" + contentId +
                    "&defaultYN=Y" +
                    "&overviewYN=Y" +
                    "&mapinfoYN=Y" +
                    "&addrinfoYN=Y" +
                    "firstImageYN=Y"+
                    "&_type=json");
            System.out.println("Requesting URL: " + url);

            // GET 요청 전송
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);
            String response = responseEntity.getBody();
            System.out.println("API Response: " + response);

            // JSON 데이터 파싱
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode root = objectMapper.readTree(response);
            JsonNode item = root.path("response").path("body").path("items").path("item").get(0);

            // JSON 데이터를 FestivalDetail 객체로 매핑
            festivalDetail.setContentId(item.path("contentid").asText(""));
            festivalDetail.setFirstimage(image);
            festivalDetail.setTitle(item.path("title").asText(""));

            festivalDetail.setMapX(item.path("mapx").asDouble(0.0));
            festivalDetail.setMapY(item.path("mapy").asDouble(0.0));
            festivalDetail.setTel(item.path("tel").asText(""));
            festivalDetail.setAddr(addr);
            festivalDetail.setOverview(item.path("overview").asText(""));

        } catch (Exception e) {
            System.err.println("API 호출 중 오류 발생:");
            e.printStackTrace();
        }

        return festivalDetail;
    }


    //관광지 리스트 받아오기
    public List<Tour> fetchTourList(String mapx, String mapy) {
        List<Tour> tours = new ArrayList<>();
        try {
            RestTemplate restTemplate = new RestTemplate();

            // URI 생성
            URI url = new URI( TOUR_MAIN_API_URL + "?serviceKey=" + API_KEY +
                    "&MobileApp=AppTest" +
                    "&MobileOS=ETC" +
                    "&pageNo=1" +
                    "&numOfRows=100" +
                    "&contentTypeId=12" + //관광지만
                    "&radius=20000" + // 거리반경(m): 5000m - max = 20000
                    "&mapX=" +mapx +
                    "&mapY=" +mapy+
                    "&listYN=Y" +
                    "&arrange=E" + // 대포 이미지 있는 컨텐츠 우선 정렬 O:제목순, S:거리순
                    "&_type=json");
            System.out.println("Requesting TOUR URL: " + url);

            // GET 요청 전송
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);
            String response = responseEntity.getBody();
//            System.out.println("API Response: " + response);

            // JSON 데이터 파싱
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode root = objectMapper.readTree(response);
            JsonNode items = root.path("response").path("body").path("items").path("item");

            // JSON 데이터를 Festival 객체로 매핑
            for (JsonNode item : items) {
                Tour tour = new Tour();
                tour.setAddr(item.path("addr1").asText(""));
                tour.setContentId(item.path("contentid").asText(""));
                tour.setDist(item.path("dist").asText(""));
                tour.setMapX(item.path("mapx").asText(""));
                tour.setMapY(item.path("mapy").asText(""));
                tour.setFirstImage(item.path("firstimage").asText(""));
                tour.setTel(item.path("tel").asText(""));
                tour.setTitle(item.path("title").asText(""));
                tours.add(tour);
            }
        } catch (Exception e) {
            System.err.println("API 호출 중 오류 발생:");
            e.printStackTrace();
        }
        return tours;
    }



    public FestivalDetail fetchTourDetail(String contentId, String image) {
        FestivalDetail tourDetail = new FestivalDetail();
        System.out.println("fetchTourDetail 실행 ");

        try {
            RestTemplate restTemplate = new RestTemplate();

            // URI 생성
            URI url = new URI("https://apis.data.go.kr/B551011/KorService1/detailCommon1?serviceKey=" + API_KEY +
                    "&MobileApp=AppTest" +
                    "&MobileOS=ETC" +
                    "&pageNo=1" +
                    "&numOfRows=1" +
                    "&contentId=" + contentId +
                    "&defaultYN=Y" +
                    "&overviewYN=Y" +
                    "&mapinfoYN=Y" +
                    "&addrinfoYN=Y" +
                    "&firstImageYN=Y"+
                    "&_type=json");
            System.out.println("Requesting URL: " + url);

            // GET 요청 전송
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);
            String response = responseEntity.getBody();
            System.out.println("API Response: " + response);

            // JSON 데이터 파싱
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode root = objectMapper.readTree(response);
            JsonNode item = root.path("response").path("body").path("items").path("item").get(0);

            // JSON 데이터를 FestivalDetail 객체로 매핑
            tourDetail.setContentId(item.path("contentid").asText(""));
//            tourDetail.setFirstimage(image);
            tourDetail.setTitle(item.path("title").asText(""));
            tourDetail.setFirstimage(item.path("firstimage").asText(""));

            tourDetail.setMapX(item.path("mapx").asDouble(0.0));
            tourDetail.setMapY(item.path("mapy").asDouble(0.0));
            tourDetail.setTel(item.path("tel").asText(""));
            tourDetail.setOverview(item.path("overview").asText(""));

        } catch (Exception e) {
            System.err.println("API 호출 중 오류 발생:");
            e.printStackTrace();
        }

        return tourDetail;
    }


}
