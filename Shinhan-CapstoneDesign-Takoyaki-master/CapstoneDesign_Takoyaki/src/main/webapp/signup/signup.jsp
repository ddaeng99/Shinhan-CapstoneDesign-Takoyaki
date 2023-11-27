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
<link rel="stylesheet" href="../resources/css/signup.css">
<link rel="shortcut icon" href="../resources/image/shortcut.png"
	type="image/x-icon" />
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/d6f64dc1ee.js" crossorigin="anonymous"></script>

<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.4.0/kakao.min.js"></script>

<title>문어빵</title>
</head>
<body>
	<div class="container">
		<div class="content">
			<!-- HEADER -->
			<header>
				<h2>회원가입</h2>
				<h3>문어빵 회원가입을 통해 맞춤 정보 추천 받으세요</h3>
			</header>

			<!-- INPUT -->
			<form method="post" action="signupAction.jsp" name="newUser">
				<section>
					<div class="info" id="info__id">
						<div id="id-input">
							<input class="box" type="text" name="id"
								placeholder="아이디 입력(6~20자)" />
							<button id="id-check" onclick="registerCheckFunction()" type="button">중복 확인</button>
						</div>
						<div class="error-msg"></div>
					</div>
					<div class="info" id="info__pw">
						<input class="box" type="password" name="pw"
							placeholder="비밀번호 입력 (문자, 숫자, 특수문자 포함 8~20자)" style="font-size: 12px" />
						<div class="error-msg"></div>
					</div>
					<div class="info" id="info__pwRe">
						<input class="box" type="password" name="pw_confirm" placeholder="비밀번호 재입력" />
						<div class="error-msg"></div>
					</div>
					<div class="info" id="info__email">
						<input class="box" id="email-txt" type="text" name="email1"
							placeholder="이메일 입력" /> 
							<span>@</span> 
							<input class="box" id="domain-txt" type="text"/>
						<select class="box" id="domain-list" name="email2">
							<option value="naver.com">naver.com</option>
							<option value="google.com">google.com</option>
							<option value="kakao.com">kakao.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
						</select>
					</div>
					<div class="info" id="info__birth">
						<div id="birth-flex">
							<select class="box" id="year" name="year">
								<option disabled selected>출생 연도</option>
							</select> <select class="box" id="month" name="month">
								<option disabled selected>월</option>
							</select> <select class="box" id="day" name="day">
								<option disabled selected>일</option>
							</select>
						</div>
						<div class="error-msg"></div>
					</div>

					<div class="info" id="info__mobile">
						<input class="box" type="text" name="mobile"
							placeholder="휴대폰 번호 입력 (‘-’ 제외 11자리 입력)" />
						<div class="error-msg"></div>
					</div>
				
			</section>
			<div id="result-fail"></div>
			<button id="submit">가입하기</button>
			</form>
			<div class="exist">
				<span>이미 회원이신가요?</span> <a href="http://localhost:8080/Takoyaki/login/login.jsp">로그인 하러가기</a>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" charset="UTF-8"
	src="../resources/script/signup.js"></script>
</html>


