<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>경로 순서 조정</title>
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

        .list-container {
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

        .list-container h2 {
            margin-top: 0;
            font-size: 22px;
            color: #5F5FBD;
        }

        #sortable-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        #sortable-list li {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            cursor: grab;
            transition: transform 0.2s;
        }

        #sortable-list li:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        #sortable-list li img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            margin-right: 15px;
            border-radius: 8px;
        }

        .drag-handle {
            width: 20px;
            height: 20px;
            margin-left: 10px;
            background: repeating-linear-gradient(
                to bottom,
                #ccc,
                #ccc 4px,
                transparent 4px,
                transparent 8px
            );
            cursor: grab;
        }

        .item-info h3 {
            font-size: 18px;
            margin: 0;
            color: #333;
        }

        .item-info p {
            font-size: 14px;
            color: #666;
        }

        .input-box {
            margin-bottom: 20px;
        }

        .input-box input {
            width: 95%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.15.0/Sortable.min.js"></script>
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

<div class="list-container">
    <div class="input-box">
        <input type="text" placeholder="ex) 여행 1" id="trip-name">
    </div>

    <h2>선택 목록(마우스로 순서 조정)</h2>
    <ul id="sortable-list">
        <!-- 축제 정보 -->
        <c:if test="${not empty selectedFestival}">
            <li data-id="${selectedFestival.contentId}">
                <div style="display: flex; align-items: center;">
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
                    </div>
                </div>
                <div class="drag-handle"></div>
            </li>
        </c:if>

        <!-- 관광지 목록 -->
        <c:if test="${not empty selectedTours}">
            <c:forEach var="tour" items="${selectedTours}">
                <li data-id="${tour.contentId}">
                    <div style="display: flex; align-items: center;">
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
                        </div>
                    </div>
                    <div class="drag-handle"></div>
                </li>
            </c:forEach>
        </c:if>
    </ul>

    <div class="button-container">
        <button onclick="saveOrder()">순서 저장</button>
    </div>
</div>

<script>
    // Sortable.js 초기화
    const sortable = new Sortable(document.getElementById('sortable-list'), {
        animation: 150,
        handle: '.drag-handle', // 드래그 핸들러 지정
        onEnd: function (evt) {
            console.log('순서가 변경되었습니다.');
        }
    });

    function saveOrder() {
        const tripName = document.getElementById('trip-name').value.trim();
        if (!tripName) {
            alert("여행 이름을 입력해주세요.");
            return;
        }

        const items = document.querySelectorAll('#sortable-list li');
        const orderedIds = Array.from(items).map(item => item.getAttribute('data-id'));

        fetch('/routes/save', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                tripName: tripName,
                contentIds: orderedIds
            })
        })
            .then(response => response.text())
            .then(data => {
                alert(data);
                window.location.href = '/'; // 메인 페이지로 이동
            })
            .catch(error => console.error('에러 발생:', error));
    }

</script>

</body>
</html>
