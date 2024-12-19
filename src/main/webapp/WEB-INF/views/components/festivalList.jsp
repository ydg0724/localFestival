<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* 공통 리스트 컨테이너 스타일 */
    .list-container {
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        padding: 15px;
        border-radius: 8px;
        margin: 0 auto;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .list-container h3 {
        font-size: 20px;
        margin-bottom: 10px;
        color: #333;
    }

    /* 공통 리스트 스타일 */
    .list-container ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .list-container li {
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

    .list-container li:hover {
        transform: scale(1.02);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    /* 이미지 스타일 */
    .list-container img {
        width: 120px;
        height: 120px;
        object-fit: cover;
        margin-right: 15px;
        border-radius: 8px;
    }

    /* 타이틀과 부가정보 스타일 */
    .list-container .item-info {
        flex-grow: 1;
    }

    .list-container .item-title {
        font-size: 18px;
        font-weight: bold;
        color: #333;
        margin: 0;
    }

    .list-container .item-description {
        font-size: 14px;
        color: #666;
        margin: 5px 0 0;
    }

    /* 링크 스타일 */
    .list-container a {
        text-decoration: none;
        color: #333;
    }

    .list-container a:hover {
        color: #8181F7;
    }

</style>
<div class="list-container">
    <h3>축제 목록</h3>
    <ul>
        <c:forEach var="festival" items="${festivals}">
            <li class="festival-item">
                <c:choose>
                    <c:when test="${not empty festival.image1}">
                        <img src="${festival.image1}" alt="${festival.title}">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/default-image.webp">
                    </c:otherwise>
                </c:choose>
                
                <div class="item-info festival-info" >
                    <p class="item-title festival-title">
                        <a href="javascript:void(0);"
                           onclick="fetchDetail('${festival.contentId}', '${festival.addr}', '${festival.image1}');
                                   selectFestival('${festival.mapX}', '${festival.mapY}', '${festival.title.replace("'", "\\'")}');">
                                ${festival.title}
                        </a>
                    </p>
                    <p class="item-description festival-address">${festival.addr}</p>
                    <p class="item-description festival-dates">
                        <span class="festival-start-date">${festival.eventStartDate}</span> ~
                        <span class="festival-end-date">${festival.eventEndDate}</span>
                    </p>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>

<script>
    function selectFestival(mapx, mapy, title) {
        // console.log("DEBUG - 함수 호출됨");
        // console.log("전달된 축제 이름:", title);

        const lat = parseFloat(mapy); // mapY는 위도
        const lng = parseFloat(mapx); // mapX는 경도

        // console.log("위도(lat):", lat);
        // console.log("경도(lng):", lng);

        // 유효성 검사
        if (isNaN(lat) || isNaN(lng)) {
            // console.error("유효하지 않은 좌표입니다. lat:", lat, "lng:", lng);
            return;
        }
        // console.log("축제 이름:", title);

        // 구글 맵 업데이트
        updateMapLocation(lat, lng, title);
    }
</script>