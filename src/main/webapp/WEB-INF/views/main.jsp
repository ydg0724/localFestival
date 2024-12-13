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
<div id = festival-details>
    <jsp:include page="/WEB-INF/views/components/festivalDetail.jsp" />

</div>

<script>
    // 공통 JavaScript 함수
    function showFestivalDetails(festivalId) {
        // 축제 상세 정보 로드 및 표시 로직
    }
</script>

</body>
</html>
