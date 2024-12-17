<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
            background-color: #e0e0e0; /* 배경 색상으로 공간 표시 */
        }
        #festival-list {
            height: 700px;
            width: 28%;
            float: right;
            overflow-y: scroll;
            border: 1px solid #ddd;
            padding: 10px;
            box-sizing: border-box;
            background-color: #f9f9f9; /* 배경 색상으로 공간 표시 */
        }
        #festival-details {
            clear: both;
            padding-top: 20px;
            border: 1px solid #ddd;
            padding: 10px;
            box-sizing: border-box;
            background-color: #ffffff; /* 배경 색상으로 공간 표시 */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %> <!-- 절대 경로 사용 -->
<%--<h1>Festival Map</h1>--%>
<div id="main-map">
    <jsp:include page="/WEB-INF/views/components/googleMap.jsp">
        <jsp:param name="googleapikey" value="${googleMapsApiKey}"/>
    </jsp:include>

</div>
<div id="festival-list">
    <jsp:include page="/WEB-INF/views/components/festivalList.jsp" />
</div>
<form if = "tourform" action="/tour" method="post">
    <input type="hidden" id="inputContentId" name="contentId">
    <input type="hidden" id="inputTitle" name="title">
    <input type="hidden" id="inputTel" name="tel">
    <input type="hidden" id="inputMapx" name="mapx">
    <input type="hidden" id="inputMapy" name="mapy">
    <input type="hidden" id="inputOverview" name="overview">
    <div id = festival-details>
        <img id="detail-img" src="" alt="이미지 없음" style="width: 200px; height: auto;">
        <p><span id ="detail-title"></span></p>
        <p><span id ="detail-tel"></span></p>
        <p><span id ="detail-contentid"></span></p>
        <p><span id ="detail-mapx"></span></p>
        <p><span id ="detail-mapy"></span></p>
        <p><span id ="detail-overview"></span></p>

        <button type="submit" id="go-to-tour" style="display: none;" onclick="navigateToTour()">Tour 페이지로 이동</button>

        <%--    <jsp:include page="/WEB-INF/views/components/festivalDetail.jsp" />--%>

    </div>

</form>

<script>
    let currentFestivalData = {}; // 전역 변수 선언

    <!-- AJAX 스크립트 -->
    function fetchDetail(contentId,addr, image) {
        console.log("fetchDetail 실행");
        $.ajax({
            url: "/fetchDetail",
            type: "GET",
            cache: false, // 캐시 비활성화
            data: {
                contentId: contentId,
                image: image,
                addr: addr
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
                console.log("AJAX 응답 데이터 title :", title);
                console.log("AJAX 응답 데이터 tel :", tel);
                console.log("AJAX 응답 데이터 contentId :", contentId);
                console.log("mapx:", mapx); // 값 확인
                console.log("mapy:", mapy); // 값 확인

                $('#detail-contentid').text(contentId);
                $('#detail-title').text(title);
                $('#detail-tel').text(tel);
                $('#detail-mapx').text(mapx);
                $('#detail-mapy').text(mapy);
                $('#detail-overview').text(overview);

                $('#detail-img').attr('src', image || 'default-image.jpg');// 이미지가 없을 경우 기본 이미지 설정
                if (response.contentId) {
                    $('#go-to-tour').css('display', 'inline-block'); // 버튼 보이기
                }
                // 상세 정보 업데이트
                <%--$('#festival-details').html(`--%>
                <%--    <h2>${title}</h2>--%>
                <%--    <p><b>전화번호:</b> ${tel}</p>--%>
                <%--    <p><b>ID:</b> ${contentId}</p>--%>
                <%--`);--%>

            },
            error: function() {
                alert("디테일 정보를 불러오는 데 실패했습니다.");
            }
        });
    }
    function navigateToTour() {
        // 데이터를 수집
        const contentId = $('#detail-contentid').text();
        const title = $('#detail-title').text();
        const tel = $('#detail-tel').text();
        const mapx = $('#detail-mapx').text();
        const mapy = $('#detail-mapy').text();
        const overview = $('#detail-overview').text();

        // POST 요청 전송
        document.getElementById("inputContentId").value = $('#detail-contentid').text();
        document.getElementById("inputTitle").value = $('#detail-title').text();
        document.getElementById("inputTel").value = $('#detail-tel').text();
        document.getElementById("inputMapx").value = $('#detail-mapx').text();
        document.getElementById("inputMapy").value = $('#detail-mapy').text();
        document.getElementById("inputOverview").value = $('#detail-overview').text();

        console.log("mapx:", mapx); // 값 확인
        console.log("mapy:", mapy); // 값 확인

        document.getElementById("tourForm").submit();
    }


    // 공통 JavaScript 함수
    function showFestivalDetails(festivalId) {
        // 축제 상세 정보 로드 및 표시 로직
    }
</script>

</body>
</html>
