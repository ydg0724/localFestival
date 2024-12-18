document.addEventListener("DOMContentLoaded", () => {
    const isRouteResultPage = "<c:out value='${isRouteResultPage}' />" === "true";

    if (isRouteResultPage) {
        console.log("routeResult 페이지에서는 축제 마커 함수가 실행되지 않습니다.");
        return; // 함수 실행 방지
    }

    // 서버에서 전달된 축제 데이터 확인
    const festivalLat = parseFloat("${localMapy}");
    const festivalLng = parseFloat("${localMapx}");
    const festivalTitle = "${localTitle}";

    // 값 유효성 검사
    console.log("축제 위도:", festivalLat);
    console.log("축제 경도:", festivalLng);
    console.log("축제 제목:", festivalTitle);

    // 값이 유효하면 setFestivalLocation 호출
    if (!isNaN(festivalLat) && !isNaN(festivalLng) && festivalTitle) {
        console.log("축제 위치 마커 설정 시작...");
        setFestivalLocation(festivalLat, festivalLng, festivalTitle);
    } else {
        console.error("유효하지 않은 축제 위치 데이터입니다.");
    }
});
