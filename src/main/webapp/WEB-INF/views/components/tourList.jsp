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

    .list-container input[type="checkbox"] {
        width: 18px;
        height: 18px;
        margin-right: 10px;
        cursor: pointer;
        accent-color: #8181F7; /* 체크박스 색상 */
    }

    .list-container input[type="checkbox"]:hover {
        transform: scale(1.1);
    }

    .list-container button {
        display: block;
        width: 200px;
        padding: 10px;
        margin: 20px auto 0; /* 버튼을 중앙에 배치 */
        background-color: #8181F7;
        border: none;
        border-radius: 4px;
        color: #fff;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.2s ease-in-out;
        text-align: center;
    }

    .list-container button:hover {
        background-color: #5F5FBD;
        transform: scale(1.05);
    }

</style>
<div class="list-container">
    <h3>주변 관광지 목록</h3>
    <ul>
        <c:forEach var="tour" items="${tours}">
            <li class="tour-item">

                <!-- 체크박스 추가 -->
                <input type="checkbox" name="selectedTours" value="${tour.contentId}"
                       data-title="${tour.title}"
                       data-mapx="${tour.mapX}"
                       data-mapy="${tour.mapY}"
                       onchange="handleCheckboxChange(this)"
                >

                <!-- 이미지 -->
                <c:choose>
                    <c:when test="${not empty tour.firstImage}">
                        <img src="${tour.firstImage}" alt="${tour.title}">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/default-image.webp" alt="기본 이미지">
                    </c:otherwise>
                </c:choose>

                <!-- 관광지 정보 -->
                <div class="item-info tour-info">
                    <p class="item-title tour-title">
                        <a href="javascript:void(0);"
                           onclick="fetchTourDetail('${tour.contentId}', '${tour.firstImage}');
                                   selectTour('${tour.mapX}', '${tour.mapY}', '${tour.title.replace("'", "\\'")}');">
                                ${tour.title}
                        </a>
                    </p>
                    <p class="item-description">관광지 상세 정보를 클릭해 확인하세요.</p>
                </div>
            </li>
        </c:forEach>
    </ul>
<%--    <button type="submit">다음 페이지로 이동</button>--%>

</div>

<script>




</script>

