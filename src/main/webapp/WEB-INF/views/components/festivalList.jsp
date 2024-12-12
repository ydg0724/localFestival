<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="festival-list-container">
    <h3>축제 목록</h3>
<%--    <div class="list-wrapper">--%>
        <c:forEach var="festival" items="${festivals}">
            <div class="festival-item"
                 data-lat="${festival.latitude}"
                 data-lng="${festival.longitude}"
                 data-name="${festival.name}"
                 onclick="selectFestival(this)">
            </div>
        </c:forEach>
<%--    </div>--%>
</div>

<script>
    function selectFestival(element) {
        // 선택된 축제의 위치 정보 추출
        const lat = parseFloat(element.getAttribute('data-lat'));
        const lng = parseFloat(element.getAttribute('data-lng'));
        const name = element.getAttribute('data-name');

        // 구글맵 함수 호출 (맵 컴포넌트로 데이터 전송)
        updateMapLocation(lat, lng, name);

        // 상세 정보 업데이트
        updateFestivalDetails(element);
    }
</script>

