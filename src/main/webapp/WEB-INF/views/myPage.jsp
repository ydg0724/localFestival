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
        .header {
            display: flex;
            align-items: baseline;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .header h1 {
            font-size: 36px;
            margin: 0;
            color: #8181F7;
            cursor: pointer;
        }
        .header h1 a {
            text-decoration: none;
            color: inherit;
        }
        .header h2 {
            font-size: 16px;
            margin: 0;
            color: #333;
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .route-title {
            font-weight: bold;
            color: #333;
        }
        .delete-button {
            padding: 8px 12px;
            background-color: #FF6B6B;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .delete-button:hover {
            background-color: #FF4C4C;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><a href="<c:url value='/' />">축제어때</a></h1>
        <h2>${username}님의 마이페이지</h2>
    </div>

    <p>아래는 저장된 경로 목록입니다:</p>

    <div class="route-list">
        <c:forEach var="route" items="${routeDetails}">
            <div class="route-item">
                <div>
                    <p class="route-title">경로 제목: ${route.tripName}</p>
                    <p>경로 내용:
                        <c:forEach var="content" items="${route.contentNames}" varStatus="status">
                            ${content}${!status.last ? " -- " : ""}
                        </c:forEach>
                    </p>
                </div>
                <form action="<c:url value='/routes/delete/${route.id}' />" method="post" style="margin: 0;">
                    <button type="submit" class="delete-button">X</button>
                </form>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
