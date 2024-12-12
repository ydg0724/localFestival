<%@ taglib prefix="c" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 20px;
        background-color: #f0f0f0;
        border-bottom: 1px solid #ddd;
    }
    .header-left {
        flex: 1;
    }
    .header-right {
        flex: 1;
        text-align: right;
    }
</style>
<div class="header">
    <!-- 왼쪽: 제목 -->
    <div class="header-left">
        <h1>축제어때</h1>
    </div>

    <!-- 오른쪽: 로그인 버튼 -->
    <div class="header-right">
        <form action="<c:url value='/login' />" method="get">
            <button type="submit">로그인/회원가입</button>
        </form>
    </div>
</div>
