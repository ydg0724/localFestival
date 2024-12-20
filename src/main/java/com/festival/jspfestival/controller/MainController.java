package com.festival.jspfestival.controller;

import com.festival.jspfestival.model.*;
import com.festival.jspfestival.service.RouteService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import com.festival.jspfestival.service.FestivalService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MainController {

    public MainController(FestivalService festivalService) {
        this.festivalService = festivalService;
    }

    @Value("${google.maps.api.key}")
    private String googleMapsApiKey;

    private final FestivalService festivalService;

    @RequestMapping("/")
    public String mainPage(Model model) {

        List<Festival> festivals = festivalService.fetchFestivals();
        model.addAttribute("festivals", festivals);
        System.out.println(festivals); // 디버그용

        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
        return "main";
    }
    //    @RequestMapping("/tour")
//    public String tourPage(Model model) {
//        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
//        return "tour";
//    }
    @PostMapping("/tour")
    public String tourPage(@RequestParam Map<String, String> requestData, RedirectAttributes redirectAttributes) {
        System.out.println("ContentId: " + requestData.get("contentId"));
        System.out.println("Title: " + requestData.get("title"));
        System.out.println("Tel: " + requestData.get("tel"));
        System.out.println("MapX: " + requestData.get("mapx"));
        System.out.println("MapY: " + requestData.get("mapy"));
        System.out.println("Overview: " + requestData.get("overview"));

        // API 데이터 처리
        List<Tour> tours = festivalService.fetchTourList(requestData.get("mapx"), requestData.get("mapy"));

        // Redirect 시 데이터 전달
        redirectAttributes.addFlashAttribute("tours", tours);
        redirectAttributes.addFlashAttribute("localContentId", requestData.get("contentId"));
        redirectAttributes.addFlashAttribute("localTitle", requestData.get("title"));
        redirectAttributes.addFlashAttribute("localTel", requestData.get("tel"));
        redirectAttributes.addFlashAttribute("localMapx", requestData.get("mapx"));
        redirectAttributes.addFlashAttribute("localMapy", requestData.get("mapy"));
        redirectAttributes.addFlashAttribute("localOverview", requestData.get("overview"));

        return "redirect:/tour"; // GET 요청으로 리다이렉트
    }
    @GetMapping("/tour")
    public String getTourPage(Model model) {
        // Flash Attribute를 가져오는지 확인
        if (!model.containsAttribute("localContentId")) {
            model.addAttribute("localContentId", "defaultContentId");
        }
        model.addAttribute("googleMapsApiKey", googleMapsApiKey);
        return "tour";
    }

    @PostMapping("/routeResult")
    public String handleSelectedTours(
            @RequestParam(value = "selectedTours", required = false) List<String> selectedTours,
            @RequestParam(value = "selectedFestival", required = false) String selectedFestival,
            Model model) {
        FestivalDetail festivalDetail = null;
        if (selectedFestival != null && !selectedFestival.isEmpty()) {
            festivalDetail = festivalService.fetchTourDetail(selectedFestival, ""); // API 호출
        }

        if (selectedTours == null || selectedTours.isEmpty()) {
            System.out.println("선택된 투어가 없습니다.");
            model.addAttribute("error", "선택된 항목이 없습니다.");
            return "routeResult"; // 에러 메시지를 보여줄 페이지
        }

        System.out.println("선택된 투어 ID: " + selectedTours);

        List<FestivalDetail> selectedTourDetails = new ArrayList<>();
        for (String contentId : selectedTours) {
            FestivalDetail detail = festivalService.fetchTourDetail(contentId, "");
            if (detail != null) {
                selectedTourDetails.add(detail);
            }
        }

        model.addAttribute("selectedTours", selectedTourDetails);
        model.addAttribute("selectedFestival", festivalDetail);

        return "routeResult";
    }

    @PostMapping("/RouteOrder")
    public String routeOrderPage(
            @RequestParam(value = "selectedFestival", required = false) String selectedFestival,
            @RequestParam(value = "selectedTours", required = false) List<String> selectedTours,
            Model model) {

        // 축제 상세 정보 가져오기
        FestivalDetail festivalDetail = null;
        if (selectedFestival != null && !selectedFestival.isEmpty()) {
            festivalDetail = festivalService.fetchTourDetail(selectedFestival, ""); // API 호출
        }

        // 선택된 관광지 상세 정보 가져오기
        List<FestivalDetail> selectedTourDetails = new ArrayList<>();
        if (selectedTours != null && !selectedTours.isEmpty()) {
            for (String tourId : selectedTours) {
                FestivalDetail detail = festivalService.fetchTourDetail(tourId, "");
                if (detail != null) {
                    selectedTourDetails.add(detail);
                }
            }
        }

        // Model에 데이터 추가
        model.addAttribute("selectedFestival", festivalDetail);
        model.addAttribute("selectedTours", selectedTourDetails);

        return "RouteOrder"; // RouteOrder.jsp 반환
    }


    @GetMapping("/RouteOrder")
    public String getRouteOrderPage(Model model) {
        // Flash Attribute를 가져와 모델로 전달
        if (!model.containsAttribute("selectedTours")) {
            model.addAttribute("error", "선택된 항목이 없습니다.");
        }
        return "RouteOrder";
    }




    @Autowired
    private FestivalService FestivalService;

    @GetMapping("/festivalList")
    public String festivalListPage(Model model) {
        // Tour API를 통해 데이터 가져오기
        List<Festival> festivals = FestivalService.fetchFestivals();
        model.addAttribute("festivals", festivals);
        System.out.println(festivals); // 디버그용

        return "festivalList"; // festivalList.jsp로 데이터 전달
    }


    @RequestMapping(value = "/fetchDetail", method = RequestMethod.GET)
    @ResponseBody
    public FestivalDetail fetchDetail( @RequestParam String contentId,
                                       @RequestParam String image,
                                       @RequestParam String addr) {
        FestivalDetail festivalDetail = festivalService.fetchFestivalDetail(contentId, image, addr);
        System.out.println("축제 상세 정보: " + festivalDetail);
        System.out.println("contentId: " + festivalDetail.getContentId());
        System.out.println("title: " + festivalDetail.getTitle());
//        System.out.println("firstimage: " + festivalDetail.getFirstimage());
        System.out.println("tel: " + festivalDetail.getTel());
        System.out.println("addr: " + festivalDetail.getAddr());

//        System.out.println("overview: " + festivalDetail.getOverview());
        if (festivalDetail.getTitle() == null) festivalDetail.setTitle("제목 없음");
        if (festivalDetail.getTel() == null) festivalDetail.setTel("전화번호 없음");

        return festivalDetail; // JSON 데이터 반환
    }


    @RequestMapping(value = "/fetchTourDetail", method = RequestMethod.GET)
    @ResponseBody
    public FestivalDetail fetchTourDetail( @RequestParam String contentId,
                                           @RequestParam String image
    ) {
        FestivalDetail tourDetail = festivalService.fetchTourDetail(contentId, image);
        System.out.println("축제 상세 정보: " + tourDetail);
        System.out.println("contentId: " + tourDetail.getContentId());
        System.out.println("title: " + tourDetail.getTitle());
//        System.out.println("firstimage: " + tourDetail.getFirstimage());
        System.out.println("tel: " + tourDetail.getTel());
//        System.out.println("overview: " + tourDetail.getOverview());
        if (tourDetail.getTitle() == null) tourDetail.setTitle("제목 없음");
        if (tourDetail.getTel() == null) tourDetail.setTel("전화번호 없음");

        return tourDetail; // JSON 데이터 반환
    }

    @Autowired
    private RouteService routeService;

    @GetMapping("/myPage")
    public String myPage(HttpSession session, Model model) {
        // 세션에서 로그인된 사용자 정보 가져오기
        user loggedInUser = (user) session.getAttribute("user");

        if (loggedInUser == null) {
            return "redirect:/login"; // 비로그인 상태면 로그인 페이지로 이동
        }

        // 사용자 ID를 사용하여 경로 목록 조회
        List<Route> userRoutes = routeService.getRoutesByUserId(loggedInUser.getId());
        List<Map<String, Object>> routeDetails = new ArrayList<>();

        for (Route route : userRoutes) {
            Map<String, Object> routeDetail = new HashMap<>();
            routeDetail.put("id", route.getId());
            routeDetail.put("tripName", route.getTripName());

            // ContentIds를 개별 ID로 분리
            String[] contentIds = route.getContentIds().split(",");
            List<String> contentNames = new ArrayList<>();

            for (String contentId : contentIds) {
                // 각 ContentId에 대해 축제 또는 관광지 이름 조회
                FestivalDetail festivalDetail = festivalService.fetchFestivalDetail(contentId, "", "");
                if (festivalDetail != null) {
                    contentNames.add(festivalDetail.getTitle());
                } else {
                    contentNames.add("알 수 없는 콘텐츠");
                }
            }

            routeDetail.put("contentNames", contentNames);
            routeDetails.add(routeDetail);
        }

        // 모델에 사용자 경로 추가
        model.addAttribute("routeDetails", routeDetails);
        model.addAttribute("username", loggedInUser.getUsername());

        // myPage.jsp로 이동
        return "myPage";
    }



//    @GetMapping("/festivalDetail")
//    public String getFestivalDetail(@RequestParam("contentId") String contentId, Model model) {
//        FestivalDetail festivalDetail = festivalService.fetchFestivalDetail(contentId);
//        model.addAttribute("festivalDetail", festivalDetail);
//        return "components/festivalDetail"; // festivalDetail.jsp로 연결
//    }

}
