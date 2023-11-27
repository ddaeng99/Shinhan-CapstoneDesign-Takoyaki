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
<link rel="stylesheet" href="../resources/css/userUpdate.css">
<link rel="shortcut icon" href="../resources/image/shortcut.png"
	type="image/x-icon" />

<script src="https://kit.fontawesome.com/d6f64dc1ee.js" crossorigin="anonymous"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../resources/script/address.js"></script>


<title>문어빵</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>

	<div class="updateWord">
		<h1>개인정보 수정</h1>
	</div>

	<div class="PFP">
		<img src="../resources/image/basicPFP.png" width="80px" height="80px" class="PFPimg">
		<button type="button"
			data-attribute-id="signupLogin__start" data-method="kakao"
			class="updatePFP">
			<img src="../resources/image/PFPUpdate.png" width="25px" height="25px">
		</button>
	</div>

	<div class="userDater">
		<div class="nameGroup">
			<label class="nameLabel">이름</label> <input class="nameInput"
				type="text">
		</div>
		<div class="ageGroup">
            <label class="ageLabel">생년월일</label>
            <div class="info" id="info__birth">
                <select class="box" id="birth-year">
                  <option disabled selected>출생 연도</option>
                </select>
                <select class="box" id="birth-month">
                  <option disabled selected>월</option>
                </select>
                <select class="box" id="birth-day">
                  <option disabled selected>일</option>
                </select>
              </div>
        </div>
		<div class="genderGroup">
            <label class="genderLabel">성별</label>
            <input type="radio" name="gender" value="man">남
            <input type="radio" name="gender" value="woman">여
        </div>
		<div class="addressGroup">
			<label class="addressLabel">주소</label>
			<div class="inputAddress">
				<div class="postcodeGroup">
					<input id="inputPostcode" type="text" placeholder="우편번호">
					<button type="button" onclick="findAddr()" id="findAddr">
						찾기</button>
				</div>
				<input type="text" id="address" placeholder="주소"> <input
					type="text" id="detailAddress" placeholder="상세주소"> <input
					type="text" id="extraAddress" placeholder="참고항목">
			</div>
		</div>
	</div>

	<div class="btnGroup">
		<div class="commit">
			<button class="commitBtn" onclick="window.location.href='http://localhost:8080/Takoyaki/user/myPage.jsp';">완료</button>
		</div>
		<div class="rollback">
			<button type="button" class="rollbackBtn" onclick="window.location.href='http://localhost:8080/Takoyaki/user/myPage.jsp';">취소</button>
		</div>
	</div>

	<%@include file="../include/footer.jsp"%>
</body>

<script src="../resources/script/birth.js"></script>
</html>