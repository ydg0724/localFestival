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

    .header-left a {
        text-decoration: none;
        color: #8181F7;
    }
    .header-right {
        flex: 1;
        text-align: right;
    }
    .header-right button {
        width: 120px;
        padding: 10px;
        background-color: #8181F7;
        border: none;
        border-radius: 4px;
        color: #fff;
        font-size: 15px;
        cursor: pointer;
    }
    .header-right button:hover {
        background-color: #5F5FBD;
    }
</style>
<div class="header">
    <!-- 왼쪽: 제목 -->
    <div class="header-left">
        <h1><a href="<c:url value='/' />">축제어때</a></h1>
    </div>

    <!-- 오른쪽: 로그인 버튼 -->
    <div class="header-right">
        <form action="<c:url value='/login' />" method="get">
            <button type="submit">로그인/회원가입</button>
        </form>
    </div>
</div>
