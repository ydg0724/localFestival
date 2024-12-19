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
            border-radius: 8px;
            padding: 10px;
            box-sizing: border-box;
            background-color: #f9f9f9; /* 배경 색상으로 공간 표시 */
        }
        #festival-details {
            display: none;
            background-color: #f9f9f9; /* 배경 색상 */
            border: 1px solid #ddd; /* 테두리 */
            border-radius: 8px; /* 모서리 둥글게 */
            padding: 20px; /* 내부 여백 */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
            margin-top: 20px; /* 위 여백 */
            /*display: flex; /* 이미지와 정보 배치를 위해 flex 사용 */
            gap: 15px; /* 요소 간 간격 */
            flex-direction: row;

        }

        #festival-details img {
            width: 300px; /* 이미지 너비 */
            height: auto; /* 비율 유지 */
            object-fit: cover; /* 이미지 잘림 방지 */
            border-radius: 8px; /* 이미지 모서리 둥글게 */
        }

        #festival-details .detail-info {
            display: flex;
            flex-direction: column; /* 정보 수직 배치 */
            justify-content: center; /* 세로 중앙 정렬 */
            gap: 10px; /* 각 정보 간 간격 */
        }

        #festival-details .detail-info p {
            margin: 0; /* 기본 여백 제거 */
            font-size: 16px; /* 글자 크기 */
            color: #333; /* 글자 색상 */
        }

        #festival-details .detail-title {
            font-size: 22px; /* 제목 크기 */
            font-weight: bold; /* 굵게 */
            color: #5F5FBD; /* 제목 색상 */
        }

        #festival-details button {
            width: 150px;
            padding: 10px;
            background-color: #8181F7; /* 버튼 색상 */
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 15px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        #festival-details .button-container{
            display: flex;
            justify-content: flex-end; /* 버튼을 오른쪽 끝으로 이동 */
            margin-top: 10px; /* 위의 내용과 간격 조정 */
        }

        #festival-details button:hover {
            background-color: #5F5FBD; /* 버튼 hover 효과 */
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
<%@ include file="/WEB-INF/views/layout/header.jsp" %> <!-- 절대 경로 사용 -->
<%--<h1>Festival Map</h1>--%>
<div id="main-map">
    <jsp:include page="/WEB-INF/views/components/googleMap.jsp">
        <jsp:param name="googleapikey" value="${googleMapsApiKey}"/>
    </jsp:include>

</div>

<div id="festival-list">
    <div>
        <input type="text" id="festivalSearch" placeholder="축제 검색" onkeyup="filterFestivals()"
               style="width: 54%; padding: 10px; margin-bottom: 10px; border: 1px solid #ddd; border-radius: 8px;">
        <input type="date" id="festivalDate" onchange="filterFestivals()"
               style="width: 30%; padding: 10px; margin-left: 10px; border: 1px solid #ddd; border-radius: 8px;">

    </div>

    <jsp:include page="/WEB-INF/views/components/festivalList.jsp" />
</div>
<div class="clearfix"></div>
<form id = "tourForm" action="/tour" method="post">
    <input type="hidden" id="inputContentId" name="contentId">
    <input type="hidden" id="inputTitle" name="title">
    <input type="hidden" id="inputTel" name="tel">
    <input type="hidden" id="inputMapx" name="mapx">
    <input type="hidden" id="inputMapy" name="mapy">
    <input type="hidden" id="inputOverview" name="overview">
    <div id="festival-details">
        <img id="detail-img" src="" alt="이미지 없음">
        <div class="detail-info">
            <p class="detail-title" id="detail-title"></p>
            <p>전화번호: <span id="detail-tel"></span></p>
            <p style="display: none"><span id ="detail-contentid"></span></p>
            <p style="display: none"><span id ="detail-mapx"></span></p>
            <p style="display: none"><span id ="detail-mapy"></span></p>
            <p>상세 설명: <span id="detail-overview"></span></p>
            <div class="button-container">
                <button type="submit" id="go-to-tour" onclick="navigateToTour()">관광지 선택으로 이동</button>
            </div>
        </div>
    </div>

<%--    <jsp:include page="/WEB-INF/views/components/festivalDetail.jsp" />--%>
</form>

<script>
    let currentFestivalData = {}; // 전역 변수 선언


    function filterFestivals() {
        const searchInput = document.getElementById('festivalSearch').value.toLowerCase();
        const selectedDate = document.getElementById('festivalDate').value; // 사용자가 선택한 날짜
        const festivals = document.querySelectorAll('#festival-list .festival-item');

        festivals.forEach(festival => {
            const title = festival.querySelector('.festival-title').innerText.toLowerCase();
            const address = festival.querySelector('.festival-address').innerText.toLowerCase();
            const startDateElement = festival.querySelector('.festival-start-date'); // 시작 날짜
            const endDateElement = festival.querySelector('.festival-end-date'); // 종료 날짜
            const rawStartDate = startDateElement ? startDateElement.innerText.trim() : null;
            const rawEndDate = endDateElement ? endDateElement.innerText.trim() : null;

            let dateMatch = true;

            if (selectedDate) {
                const selected = new Date(selectedDate); // 사용자가 입력한 날짜
                const formattedStartDate = rawStartDate ? formatDate(rawStartDate) : null;
                const formattedEndDate = rawEndDate ? formatDate(rawEndDate) : null;

                const start = formattedStartDate ? new Date(formattedStartDate) : null;
                const end = formattedEndDate ? new Date(formattedEndDate) : null;

                console.log("비교 날짜: 선택된 날짜 =", selected, "시작 날짜 =", start, "종료 날짜 =", end); // 디버깅용 출력

                // 시작일이 입력된 날짜보다 이전이고 종료일이 입력된 날짜보다 이후인지 확인
                dateMatch = (!start || start <= selected) && (!end || selected <= end);
            }

            // 검색어 및 날짜 비교 조건 확인
            if ((title.includes(searchInput) || address.includes(searchInput)) && dateMatch) {
                festival.style.display = '';
            } else {
                festival.style.display = 'none';
            }
        });
    }


    // 날짜 형식을 YYYYMMDD -> YYYY-MM-DD로 변환
    function formatDate(yyyymmdd) {
        if (!yyyymmdd || yyyymmdd.length !== 8) return null; // 값이 없거나 길이가 8이 아니면 null 반환
        return yyyymmdd.substring(0, 4) + "-" + yyyymmdd.substring(4, 6) + "-" + yyyymmdd.substring(6, 8);
    }

    <!-- AJAX 스크립트 -->
    function fetchDetail(contentId,addr, image) {
        // console.log("fetchDetail 실행");
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
                // console.log("AJAX 응답 데이터:", response);

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
                // console.log("AJAX 응답 데이터 title :", title);
                // console.log("AJAX 응답 데이터 tel :", tel);
                // console.log("AJAX 응답 데이터 contentId :", contentId);
                // console.log("mapx:", mapx); // 값 확인
                // console.log("mapy:", mapy); // 값 확인

                $('#detail-contentid').text(contentId);
                $('#detail-title').text(title);
                $('#detail-tel').text(tel);
                $('#detail-mapx').text(mapx);
                $('#detail-mapy').text(mapy);
                $('#detail-overview').text(overview);

                $('#detail-img').attr('src', (image && image.trim() !== '') ? image : '${pageContext.request.contextPath}/images/default-image.webp');// 이미지가 없을 경우 기본 이미지 설정

                $('#festival-details').css('display', 'flex');

                $('#go-to-tour').css('display', 'inline-block');
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


        document.getElementById("tourForm").submit();
    }


</script>

</body>
</html>
