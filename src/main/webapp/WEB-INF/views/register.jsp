<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>여행어때:회원가입</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
        h2 {
            margin-bottom: 20px;
            font-size: 52px;
            color: #8181F7;
        }
        .register-container {
            width: 400px;
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 300px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group input {
            width: 90%;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        .form-group button {
            width: 98%;
            padding: 15px;
            background-color: #8181F7;
            border: none;
            border-radius: 4px;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #8181F7;
        }
    </style>
</head>
<body>
<h2>회원가입</h2>
<div class="register-container">
    <form action="/register" method="post">
        <div class="form-group">
            <input type="text" id="name" name="name" placeholder="이름" required>
        </div>
        <div class="form-group">
            <input type="text" id="id" name="id" placeholder="아이디" required>
        </div>
        <div class="form-group">
            <input type="password" id="password" name="password" placeholder="비밀번호" required>
        </div>
        <div class="form-group">
            <button type="submit">회원가입</button>
        </div>
    </form>
</div>
</body>
</html>
