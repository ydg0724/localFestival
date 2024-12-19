<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>마이페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #5F5FBD;
        }
        .route-list {
            margin-top: 20px;
        }
        .route-item {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
        }
        .route-title {
            font-weight: bold;
            color: #333;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>${username}님의 마이페이지</h1>
    <p>아래는 저장된 경로 목록입니다:</p>

    <div class="route-list">
        <c:forEach var="route" items="${userRoutes}">
            <div class="route-item">
                <p class="route-title">경로 제목: ${route.tripName}</p>
                <p>경로 내용: ${route.contentIds}</p>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
