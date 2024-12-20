<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>선택된 관광지 정보</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 10px;
            padding: 10px;
        }

        #main-map {
            height: 700px;
            width: 70%;
            float: left;
            background-color: #e0e0e0;
        }

        #selected-list {
            height: 700px;
            width: 28%;
            float: right;
            overflow-y: scroll;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px;
            box-sizing: border-box;
            background-color: #f9f9f9;
        }

        .selected-list-container h2 {
            margin-top: 10px;
            font-size: 22px;
            color: #5F5FBD;
        }

        .selected-list-container ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .selected-list-container li {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }

        .selected-list-container li:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .selected-list-container img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            margin-right: 15px;
            border-radius: 8px;
        }

        .item-info h3 {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin: 0;
        }

        .item-info p {
            margin: 5px 0;
            font-size: 14px;
            color: #666;
        }

        .button-container {
            margin-top: 20px;
            display: flex;
            justify-content: space-around;
        }

        .button-container button {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background-color: #8181F7;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .button-container button:hover {
            background-color: #5F5FBD;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div id="main-map">
    <script>
        // JavaScript 객체로 데이터 변환
        const selectedFestival = {
            title: "${selectedFestival.title}",
            lat: parseFloat("${selectedFestival.mapY}"),
            lng: parseFloat("${selectedFestival.mapX}")
        };

        const selectedTours = [
            <c:forEach var="tour" items="${selectedTours}" varStatus="status">
            {
                title: "${tour.title}",
                lat: parseFloat("${tour.mapY}"),
                lng: parseFloat("${tour.mapX}")
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];
        function setMapCenter(lat, lng, zoomLevel = 12) {
            if (!map) {
                console.warn("Map 객체가 아직 초기화되지 않았습니다. 0.5초 후 재시도.");
                setTimeout(() => setMapCenter(lat, lng, zoomLevel), 500);
                return;
            }
            map.panTo({ lat, lng });
            map.setZoom(zoomLevel);
            console.log("지도 중심 이동 완료 (panTo):", lat, lng, zoomLevel);
        }


        // 지도 로드 후 마커 추가
        function onMapLoaded(map) {
            console.log("지도 로드 완료!");

            // 축제 데이터
            const festivalLat = parseFloat("${selectedFestival.mapY}");
            const festivalLng = parseFloat("${selectedFestival.mapX}");
            const festivalTitle = "${selectedFestival.title}";

            // 관광지 데이터
            const selectedTours = [
                <c:forEach var="tour" items="${selectedTours}" varStatus="status">
                {
                    title: "${tour.title}",
                    lat: parseFloat("${tour.mapY}"),
                    lng: parseFloat("${tour.mapX}")
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ];
            console.log("전달된 관광지 데이터:", selectedTours);

            // 축제 위치 마커 추가 및 지도 중심 설정
            if (!isNaN(festivalLat) && !isNaN(festivalLng)) {
                setFestivalLocation(festivalLat, festivalLng, festivalTitle);
            } else {
                console.error("유효하지 않은 축제 데이터입니다.");
            }

            // 관광지 마커 추가
            selectedTours.forEach((tour, index) => {
                console.log(`관광지 ${index + 1}:`, tour); // 디버깅 로그
                if (!isNaN(tour.lat) && !isNaN(tour.lng)) {
                    addMarker(tour.lat, tour.lng, tour.title, "blue");
                } else {
                    console.warn(`유효하지 않은 좌표 데이터:`, tour);
                }
            });
        }

    </script>


    <jsp:include page="/WEB-INF/views/components/googleMap.jsp">
        <jsp:param name="googleapikey" value="${googleMapsApiKey}"/>
    </jsp:include>
</div>

<div id="selected-list" class="selected-list-container">
    <script>
        function confirmFestivalSelection() {
            if (confirm("축제 선택 페이지로 이동합니다. 확인을 누르면 메인 페이지로 이동합니다.")) {
                window.location.href = '/'; // 메인 페이지로 이동
            }
        }

        function navigateToRouteOrderPage() {
            window.location.href = '/RouteOrder'; // 경로 순서 정하기 페이지로 이동
        }
    </script>
<%--    <h1>선택된 관광지 정보</h1>--%>
    <ul>
        <!-- 축제 정보 표시 -->
        <c:if test="${not empty selectedFestival}">
            <h2>선택한 축제 정보</h2>
            <li>
                <c:choose>
                    <c:when test="${not empty selectedFestival.firstimage}">
                        <img src="${selectedFestival.firstimage}" alt="이미지 없음">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/default-image.webp" alt="기본 이미지">
                    </c:otherwise>
                </c:choose>
                <div class="item-info">
                    <h3>${selectedFestival.title}</h3>
<%--                    <p>전화번호: ${selectedFestival.tel}</p>--%>
<%--                    <p>${selectedFestival.overview}</p>--%>
                </div>
            </li>
        </c:if>

        <!-- 선택된 관광지 목록 표시 -->
        <c:if test="${not empty selectedTours}">
            <h2>선택된 관광지 목록</h2>
            <c:forEach var="tour" items="${selectedTours}">
                <li>
                    <c:choose>
                        <c:when test="${not empty tour.firstimage}">
                            <img src="${tour.firstimage}" alt="이미지 없음">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/default-image.webp" alt="기본 이미지">
                        </c:otherwise>
                    </c:choose>
                    <div class="item-info">
                        <h3>${tour.title}</h3>
<%--                        <p>전화번호: ${tour.tel}</p>--%>
<%--                        <p>${tour.overview}</p>--%>
                    </div>
                </li>
            </c:forEach>
        </c:if>
    </ul>
    <c:set var="festival" value="${selectedFestival}" />
    <c:set var="tours" value="${selectedTours}" />

    <div class="button-container">
    <!-- 축제 관광지 다시 선택하기 버튼 -->
    <button onclick="confirmFestivalSelection()">축제 관광지 다시 선택하기</button>

    <!-- 경로 순서 정하기 버튼 -->
    <form action="${pageContext.request.contextPath}/RouteOrder" method="post">
        <!-- 숨겨진 필드로 선택된 축제와 관광지 데이터를 전달 -->
        <input type="hidden" name="selectedFestival" value="${selectedFestival.contentId}">
        <c:forEach var="tour" items="${selectedTours}">
            <input type="hidden" name="selectedTours" value="${tour.contentId}">
        </c:forEach>
        <button type="submit">경로 순서 정하기</button>
    </form>
</div>

</div>

</body>
</html>