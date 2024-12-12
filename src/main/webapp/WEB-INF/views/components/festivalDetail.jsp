<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="festival-details" class="festival-details-container">
    <h3>축제 상세 정보</h3>
    <div id="details-content">
        <p id="festival-name"></p>
        <p id="festival-description"></p>
        <p id="festival-date"></p>
    </div>
</div>

<script>
    function updateFestivalDetails(element) {
        // 축제 상세 정보 업데이트 로직
        document.getElementById('festival-name').textContent =
            element.querySelector('h4').textContent;

        // 필요한 다른 상세 정보도 여기서 업데이트
    }
</script>

