<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<link rel="stylesheet" href="../resources/css/stylelog.css">
<link rel="stylesheet" href="../resources/css/infomodi.css?ver=1.1">
<link rel="shortcut icon" href="../resources/image/shortcut.png"
	type="image/x-icon" />

<script src="https://kit.fontawesome.com/d6f64dc1ee.js" crossorigin="anonymous"></script>


<title>문어빵</title>
</head>
<body>
<%@include file="../include/header.jsp"%>
<body>
    <h1 class="title">추가 정보 입력</h1>
    <div class="container-450">
        <div id="centerInput">
            <div class="emailGroup">
                <div class="emailLabel">이메일</div>
                <input class="emailInput" type="email">
            </div>
            <div class="locGroup">
                <div class="locLabel">지역</div>
                <input class="locInput" type="text">
            </div>
            <div class="careerGroup">
                <div class="careerLabel">경력</div>
                <input class="careerInput" type="text">
            </div>
            <div class="interestJobGroup">
                <div class="interestJobLabel">관심직종</div>
                <input class="interestJobInput" type="text">
            </div>
            <div class="eduGroup">
                <div class="eduLabel">학력</div>
                <input class="eduInput" type="text">
            </div>
        </div>


        <div class="btnGroup">
            <div class="commit">
                <button class="commitBtn">완료</button>
            </div>
            <div class="rollback">
                <button type="button" class="rollbackBtn" onclick="window.location.href='http://localhost:8080/Takoyaki/user/myPage.jsp';">취소</button>
            </div>

        </div>
    </div>
<%@include file="../include/footer.jsp"%>
</body>
</html>