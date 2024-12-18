<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>선택된 관광지 정보</title>
</head>
<body>
<h1>선택된 관광지 목록</h1>
<ul>
    <c:forEach var="tour" items="${selectedTours}">
        <li>
            <h3>${tour.title}</h3>
            <p>전화번호: ${tour.tel}</p>
            <p>위도: ${tour.mapY}, 경도: ${tour.mapX}</p>
            <p>상세 설명: ${tour.overview}</p>
            <img src="${tour.firstimage}" alt="이미지 없음" width="300">
        </li>
    </c:forEach>
</ul>
</body>
</html>
