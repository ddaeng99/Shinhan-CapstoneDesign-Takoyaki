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


<link rel="stylesheet" href="../resources/css/login.css">
<link rel="shortcut icon" href="../resources/image/shortcut.png"
	type="image/x-icon" />

<script src="https://kit.fontawesome.com/d6f64dc1ee.js"
	crossorigin="anonymous"></script>


<title>문어빵</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>

	<div id="login">
		<h1>로그인</h1>
	</div>
	<p class="p">문어빵을 통해 맞춤 정보를 추천 받으세요</p>
	<div class="login-wrapper">
		<form method="post" action="loginAction.jsp" id="login-form">
			<input type="text" name="id" placeholder="ID"> 
			<input type="password" name="pw" placeholder="Password">
			<label for="remember-check"> <input type="checkbox"
				id="remember-check">아이디 저장하기
			</label>
			<ul>
				<li><a href="#">아이디/비밀번호찾기</a></li>
				<li><a href="http://localhost:8080/Takoyaki/signup/signup.jsp">회원가입</a></li>
			</ul>
			<input type="submit" value="Login">
		</form>
	</div>


	<%@include file="../include/footer.jsp"%>
</body>


</body>
</html>