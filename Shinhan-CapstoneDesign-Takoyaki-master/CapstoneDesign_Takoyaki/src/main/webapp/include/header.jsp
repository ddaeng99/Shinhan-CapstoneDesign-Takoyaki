<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<link rel="stylesheet" href="../resources/css/header.css?ver=1.1">

</head>
<body>
	<%
	String id = null;
	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}
	%>
	<nav class="navbar">
		<div class="navbar_logo">
			<a href="http://localhost:8080/Takoyaki/main/main.jsp"><img
				src="../resources/image/icon.png" alt="문어빵" width="50px"
				height="50px" /></a> <a
				href="http://localhost:8080/Takoyaki/main/main.jsp" class="name">문어빵</a>
		</div>
		<form id="hiddenval4"
			action="http://localhost:8080/Takoyaki/contents/search.jsp">
			<div class="search_form">
				<input type="text" id="search">
				<button id="searchBtn"
					href="http://localhost:8080/Takoyaki/contents/search.jsp"
					onclick="searchClick()">
					<input type="hidden" id="searchkeywordInput" name=searchkeyword
						value="" /> <i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</div>
		</form>

		<%
		if (id == null) {
		%>
		<div class="navbar_login">
			<a href="http://localhost:8080/Takoyaki/login/login.jsp">로그인/회원가입</a>
		</div>
		<%
		} else {
		%>
		<div class="userNameDrp">
			<!--나중에 닉네임 저장하면 닉네임을 표시-->
			<button id="userID">
				<%
				out.print(id);
				%>
				<span style="color: #666; font-size: 1.3rem;">님</span>
			</button>
			<div class="userNameDrp-content">
				<ul>
					<li><a href="http://localhost:8080/Takoyaki/user/myPage.jsp">마이페이지</a></li>
					<li><a href="../signup/logoutAction.jsp">로그아웃</a></li>
				</ul>
			</div>
		</div>
		<%
		}
		%>
	</nav>
	<nav class="navmenu">
		<ul class="navbar_menu">
			<li><a href="http://localhost:8080/Takoyaki/contents/jobInfo.jsp" class="nav_jobinfo">채용공고</a></li>
			<li><a href="http://localhost:8080/Takoyaki/contents/contest.jsp?category=comall" class="nav_contest">공모전</a></li>
			<li><a href="http://localhost:8080/Takoyaki/contents/extActivity.jsp?category=exall" class="nav_external">대외활동</a></li>
			<li><a href="http://localhost:8080/Takoyaki/contents/CFReco.jsp" class="nav_recoContent">추천 컨텐츠</a></li>
			<li><a href="http://localhost:8080/Takoyaki/board/mainboard.jsp" class="nav_bbs">커뮤니티</a></li>
		</ul>
	</nav>
	<hr>
</body>
<script>
	var dropdownButton = document.getElementById("userID");
	var dropdownContent = document.querySelector(".userNameDrp-content");

	// 클릭 이벤트를 사용하여 드롭다운을 표시/숨김
	dropdownButton.addEventListener("click", function() {
		if (dropdownContent.style.display === "none"
				|| dropdownContent.style.display === "") {
			dropdownContent.style.display = "block";
		} else {
			dropdownContent.style.display = "none";
		}
	});

	// 다른 곳을 클릭하면 드롭다운을 닫도록 처리
	document.addEventListener("click",
			function(event) {
				if (event.target !== dropdownButton
						&& event.target !== dropdownContent) {
					dropdownContent.style.display = "none";
				}
			});
</script>

<script>
	var searchInput = document.getElementById("search");
	var searchButton = document.getElementById("searchBtn");
	var searchKeywordInput = document.getElementById("searchkeywordInput");

	searchInput.addEventListener("keydown", function(event) {
		if (event.key === "Enter") {

			searchClick();

		}
	});

	searchButton.addEventListener("click", searchClick);

	function searchClick() {
		var userInput = searchInput.value;
		searchKeywordInput.value = userInput; // 입력값을 hidden input에 설정
		console.log(userInput);

		//이부분에 if(userInput != null ){window.location.href =""} 으로 이동하려하면 if가 작동안하고 window함수만 쓰면 위에서 searchClick()을 이미 2번이나 호출해서
		//3번쨰 호출이 되므로 페이지 이동이 엄~청느려짐 값불러오지도 않음

	}
</script>
<script>
	// 클릭했을때 불 들어오는거
	var currentPageURL = window.location.href;
	var menuItems = document.querySelectorAll('.navbar_menu a');

	for (var i = 0; i < menuItems.length; i++) {
		var menuItemURL = menuItems[i].getAttribute('href');

		if (currentPageURL === menuItemURL) {
			menuItems[i].classList.add('selected');
		}
	}
</script>
</html>