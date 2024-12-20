<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>축제어때</title>
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

        #tour-list {
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

        .sticky-bar {
            position: sticky;
            top: 0; /* 상단에서 고정 위치 */
            background-color: #f9f9f9; /* 배경색으로 고정 영역 강조 */
            z-index: 1000; /* 다른 요소 위로 오도록 설정 */
            padding: 10px;
            border-bottom: 1px solid #ddd; /* 구분선 추가 */
        }

        .sticky-bar input {
            width: 58%; /* 검색 필드 크기 */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .sticky-bar button {
            padding: 10px 20px;
            background-color: #8181F7;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
        }

        .sticky-bar button:hover {
            background-color: #5F5FBD;
        }

        #tour-details {
            display: none;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            gap: 15px;
            flex-direction: row;
            align-items: center;
            justify-content: flex-start;
        }

        #tour-details img {
            width: 300px;
            height: auto;
            object-fit: cover;
            border-radius: 8px;
        }

        #tour-details .detail-info {
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 10px;
        }

        .detail-title {
            font-size: 22px;
            font-weight: bold;
            color: #5F5FBD;
        }

        #tour-details p {
            margin: 0;
            font-size: 16px;
            color: #333;
        }

        .clearfix::after {
            content: "";
            display: table;
            clear: both;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>
<div id="main-map">
    <jsp:include page="/WEB-INF/views/components/googleMap.jsp">
        <jsp:param name="googleapikey" value="${googleMapsApiKey}"/>
        <jsp:param name="festivalLat" value="${localMapy}" />
        <jsp:param name="festivalLng" value="${localMapx}" />
        <jsp:param name="festivalTitle" value="${localTitle}" />
    </jsp:include>
</div>

<div id="tour-list">
    <!-- 검색 및 다음 페이지 이동 -->
    <form id="tourSearchForm" class="sticky-bar">
        <input type="text" id="tourSearch" placeholder="관광지 검색" onkeyup="filterTours()">
        <button type="button" onclick="submitSearch()">다음으로 이동</button>
    </form>

    <!-- 관광지 목록을 새로운 form으로 묶음 -->
    <form id="tourListForm" action="routeResult" method="post">
        <input type="hidden" name="selectedFestival" value="${localContentId}">
        <input type="hidden" name="festivalTitle" value="${localTitle}">
        <input type="hidden" name="festivalMapX" value="${localMapx}">
        <input type="hidden" name="festivalMapY" value="${localMapy}">

        <jsp:include page="/WEB-INF/views/components/tourList.jsp" />
    </form>
</div>

<div class="clearfix"></div>

<div id="tour-details">
    <img id="tour-detail-img" src="" alt="이미지 없음">
    <div class="detail-info">
        <p class="detail-title" id="tour-detail-title" ></p>
        <p>전화번호: <span id="tour-detail-tel"></span></p>
        <p>주소: <span id="tour-detail-addr"></span></p>

        <p style="display: none">위도: <span id="tour-detail-mapx"></span></p>
        <p style="display: none">경도: <span id="tour-detail-mapy"></span></p>
        <p>상세 설명: <span id="tour-detail-overview"></span></p>
    </div>
</div>

<%--    <jsp:include page="/WEB-INF/views/components/festivalDetail.jsp" />--%>
<script>
    function filterTours() {
        const searchInput = document.getElementById('tourSearch').value.toLowerCase();
        const tours = document.querySelectorAll('#tour-list .tour-item');

        tours.forEach(tour => {
            const title = tour.querySelector('.tour-title').innerText.toLowerCase();

            if (title.includes(searchInput)) {
                tour.style.display = '';
            } else {
                tour.style.display = 'none';
            }

        });
    }

    document.addEventListener("DOMContentLoaded", () => {
        // 서버에서 전달된 축제 데이터 확인
        const festivalLat = parseFloat("${localMapy}");
        const festivalLng = parseFloat("${localMapx}");
        const festivalTitle = "${localTitle}";
        const festivalContentId = "${localContentId}";

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

    function fetchTourDetail(contentId, image) {
        console.log("fetchTourDetail 실행");
        $.ajax({
            url: "/fetchTourDetail",
            type: "GET",
            cache: false, // 캐시 비활성화
            data: {
                contentId: contentId,
                image: image,
            },
            success: function(response) {
                console.log("AJAX 응답 데이터:", response);

                // 문자열일 경우 JSON 파싱
                if (typeof response === "string") {
                    try {
                        response = JSON.parse(response);
                    } catch (e) {
                        console.error("JSON 파싱 실패:", e);
                    }
                }

                const title = response.title || "제목 없음";
                const tel = response.tel || "전화번호 없음";
                const contentId = response.contentid || "ID 없음";
                const mapx = response.mapx;
                const mapy = response.mapy;
                const overview = response.overview;
                const addr = response.addr1;
                console.log("AJAX tour응답 데이터 title :", title);
                console.log("AJAX tour응답 데이터 tel :", tel);
                console.log("AJAX tour응답 데이터 contentId :", contentId);
                console.log("mapx:", mapx); // 값 확인
                console.log("mapy:", mapy); // 값 확인
                console.log("addr:", addr);

                $('#tour-detail-contentid').text(contentId);
                $('#tour-detail-title').text(title);
                $('#tour-detail-tel').text(tel);
                $('#tour-detail-mapx').text(mapx);
                $('#tour-detail-mapy').text(mapy);
                $('#tour-detail-overview').text(overview);
                $('#tour-detail-addr').text(addr);

                $('#tour-detail-img').attr('src', (image && image.trim() !== '') ? image : '${pageContext.request.contextPath}/images/default-image.webp');
                // 이미지가 없을 경우 기본 이미지 설정
                // if (response.contentId) {
                //     $('#go-to-tour').css('display', 'inline-block'); // 버튼 보이기
                // }
                // 상세 정보 업데이트
                <%--$('#festival-details').html(`--%>
                <%--    <h2>${title}</h2>--%>
                <%--    <p><b>전화번호:</b> ${tel}</p>--%>
                <%--    <p><b>ID:</b> ${contentId}</p>--%>
                <%--`);--%>
                $('#tour-details').css('display', 'flex');

            },
            error: function() {
                alert("디테일 정보를 불러오는 데 실패했습니다.");
            }
        });
    }
    function submitSearch() {
        // 필요한 데이터 수집
        const form = document.getElementById("tourListForm");

        // 폼 제출
        form.submit();
    }


    // 공통 JavaScript 함수
    function showFestivalDetails(festivalId) {
        // 축제 상세 정보 로드 및 표시 로직
    }
</script>

</body>
</html>
