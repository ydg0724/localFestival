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
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div id="main-map">
    <jsp:include page="/WEB-INF/views/components/googleMap.jsp">
        <jsp:param name="googleapikey" value="${googleMapsApiKey}"/>
    </jsp:include>
</div>

<div id="selected-list" class="selected-list-container">
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
                        <img src="${pageContext.request.contextPath}/images/default-image.jpeg" alt="기본 이미지">
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
                            <img src="${pageContext.request.contextPath}/images/default-image.jpeg" alt="기본 이미지">
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
</div>

</body>
</html>
