<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tour-list-container">
    <h3>관광지</h3>
    <div class="list-wrapper">
        <ul>
            <c:forEach var="tour" items="${tours}">
                <li>
                    <h2>
                        <a href="javascript:void(0);" onclick="fetchTourDetail('${tour.contentId}','${tour.firstImage}')">
                                ${tour.title}
                        </a>
                    </h2>
                        <%--                <p>Start Date: ${festival.eventStartDate}</p>--%>
                        <%--                <p>End Date: ${festival.eventEndDate}</p>--%>
                        <%--                <p>Address: ${festival.addr}</p>--%>
                    <img src="${tour.firstImage}" alt="${tour.title}" style="max-width: 200px;">
                        <%--                <p>Phone: ${festival.tel}</p>--%>
                        <%--                <p>Map Coordinates: (${festival.mapX}, ${festival.mapY})</p>--%>
                </li>
            </c:forEach>
        </ul>

    </div>
</div>

<script>
    // function selectFestival(element) {
    //     // 선택된 축제의 위치 정보 추출
    //     const lat = parseFloat(element.getAttribute('data-lat'));
    //     const lng = parseFloat(element.getAttribute('data-lng'));
    //     const name = element.getAttribute('data-name');
    //
    //     // 구글맵 함수 호출 (맵 컴포넌트로 데이터 전송)
    //     updateMapLocation(lat, lng, name);
    //
    //     // 상세 정보 업데이트
    //     updateFestivalDetails(element);
    // }
</script>

