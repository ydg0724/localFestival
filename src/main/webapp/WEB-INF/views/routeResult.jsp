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
            background-color: #e0e0e0; /* 배경 색상으로 공간 표시 */
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
            background-color: #f9f9f9; /* 배경 색상으로 공간 표시 */
        }
        .selected-list-container {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            margin: 0 auto;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %> <!-- 절대 경로 사용 -->
<div id="main-map">
    <jsp:include page="/WEB-INF/views/components/googleMap.jsp">
        <jsp:param name="googleapikey" value="${googleMapsApiKey}"/>
    </jsp:include>

</div>
<div id = "selected-list" class="selected-list-container">
    <h1>선택된 관광지 정보</h1>
    <ul>
        <c:if test="${not empty selectedFestival}">
            <h2>축제 정보</h2>
            <li>
                <h3>${selectedFestival.title}</h3>
<%--                <p>위도: ${selectedFestival.mapY}, 경도: ${selectedFestival.mapX}</p>--%>
<%--                <p>전화번호: ${selectedFestival.tel}</p>--%>
<%--                <p>${selectedFestival.overview}</p>--%>
            </li>
        </c:if>

        <c:if test="${not empty selectedTours}">
            <h2>선택된 관광지 목록</h2>
            <c:forEach var="tour" items="${selectedTours}">
                <li>
                    <h3>${tour.title}</h3>
<%--                    <p>위도: ${tour.mapY}, 경도: ${tour.mapX}</p>--%>
<%--                    <p>전화번호: ${tour.tel}</p>--%>
<%--                    <p>${tour.overview}</p>--%>
                </li>
            </c:forEach>
        </c:if>
    </ul>

</div>
</body>
</html>
