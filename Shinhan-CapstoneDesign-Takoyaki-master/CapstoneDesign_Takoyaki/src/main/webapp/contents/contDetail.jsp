<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
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
<link rel="shortcut icon" href="../resources/image/shortcut.png"
   type="image/x-icon" />

<script src="https://kit.fontawesome.com/d6f64dc1ee.js" crossorigin="anonymous"></script>


<title>문어빵</title>


</head>
<body>
   <%@include file="../include/header.jsp"%>
<%
String url = "AWS_RDS_ADDRESS";
String user = "DBID";
String password = "DBPW";

Connection connection = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;
String contidStr = request.getParameter("contid"); // 파라미터 값을 문자열로 얻음
int contid = Integer.parseInt(contidStr);

try {
    // 데이터베이스 연결
    Class.forName("com.mysql.cj.jdbc.Driver"); 
    connection = DriverManager.getConnection(url, user, password);
    
    
    
    // SQL 쿼리 실행 (첫 3개의 데이터만 가져옴)
    String sqlQuery = "SELECT * FROM contDetail where contid = ?";
    preparedStatement = connection.prepareStatement(sqlQuery);
    preparedStatement.setInt(1, contid);
    resultSet = preparedStatement.executeQuery();
%>
    <%
        // 결과를 웹 페이지에 표시
        while (resultSet.next()) {
            String name = resultSet.getString("name");
            String category = resultSet.getString("category");
            String agent = resultSet.getString("agent");
            String support = resultSet.getString("support");
            String during = resultSet.getString("during");
            String money1 = resultSet.getString("money1");
            String money2 = resultSet.getString("money2");
            String homepage = resultSet.getString("homepage");
            String viewContents = resultSet.getString("viewContents");
    %>
    <form id="bookmarkForm" method="POST" action="contBookmark.jsp">
    <input type="hidden" name="id" id="id">
    <input type="hidden" name="contid" id="contid" value="<%= contid %>">
    <input type="hidden" name="rating" id="rating">
    <input type="hidden" name="name" id="name" value="<%= name %>">
    <input type="hidden" name="category" id="category" value="<%= category %>">
    <input type="hidden" name="agent" id="agent" value="<%= agent %>">
	</form>
	
	<div class="wrap">
		<div>
		<div>
		 <div class="title_d"><%= name %></div>
		<hr>
		<div class="time">
		접수기간: <%= during %>
		</div>
		 <div class="like">
			<!-- 별점을 줘보아요 -->
			<button id="bookmarkButton" type = "button">즐겨찾기</button>
			<div class="starbox" style="display: none;">
				<span class="star">
				    ★★★★★
				    <span>★★★★★</span>
				    <input type="range" oninput="drawStar(this)" value="1" step="1" min="0" max="10">
				</span>
				<p id="rating-value">평가: <span id="current-rating">0</span> / 5.0</p>
				<button type="submit" id="favoriteLink" onclick="addToFavorites()">저장</button>
				<button type="button" id="cancelButton" onclick="toggleRating()">취소</button>
				</div>
			</div>
	</div>
	</div>
	<div>
    <div class="result-item">
       <% if (category != null && !category.isEmpty()) { %>
                <div class="result-category">응모대상: <%= category %></div>
            <% } %>
            <% if (agent != null && !agent.isEmpty()) { %>
                <div class="result-agent">주최/주관: <%= agent %></div>
            <% } %>
            <% if (support != null && !support.isEmpty()) { %>
                <div class="result-support">후원/협찬: <%= support %></div>
            <% } %>
            <% if (money1 != null && !money1.isEmpty()) { %>
                <div class="result-money1">총 상금: <%= money1 %></div>
            <% } %>
            <% if (money2 != null && !money2.isEmpty()) { %>
                <div class="result-money2">1등 상금: <%= money2 %></div>
            <% } %>
            <% if (homepage != null && !homepage.isEmpty()) { %>
			    <div class="result-homepage">
			        홈페이지: 
			        <a href="<%= homepage %>" target="_blank"><%= homepage %></a>
			    </div>
			<% } %>
            <% if (viewContents != null && !viewContents.isEmpty()) { %>
                <div class="result-viewContents"> <%= viewContents %></div>
            <% } %>
    <%
        }
    %>
    </div>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
} finally {
    // 연결 종료
    if (resultSet != null) resultSet.close();
    if (preparedStatement != null) preparedStatement.close();
    if (connection != null) connection.close();
}
%>
</div>
		<%@include file="../include/footer.jsp"%>
</body>
<script>
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

document.addEventListener("DOMContentLoaded", function() {
    var id = getParameterByName('id');
    var contid = getParameterByName('contid');

    document.getElementById('id').value = id;
    document.getElementById('contid').value = contid;
});

let currentRating = 0;
let ratingEnabled = false;

function drawStar(input) {
    var value = input.value;
    document.querySelector('.star span').style.width = ((value / 10) * 100) + '%';
    currentRating = (value / 2).toFixed(1);
    document.getElementById('current-rating').textContent = currentRating;
}

var isAddingToFavorites = false;

function addToFavorites() {
    if (isAddingToFavorites) {
        return false; // 이미 실행 중이면 추가로 실행되지 않음
    }

    isAddingToFavorites = true; // 실행 중 플래그를 설정

    var form = document.getElementById('bookmarkForm');
    var rating = document.getElementById('rating');

    rating.value = currentRating;

    var xhr = new XMLHttpRequest();
    xhr.open(form.method, form.action);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4) {
            isAddingToFavorites = false; // 요청이 완료되면 실행 중 플래그를 해제

            if (xhr.status === 200) {
                alert('즐겨찾기에 저장되었습니다!');
            } else {
                alert('즐겨찾기 저장에 실패하였습니다. 다시 시도해주세요.');
            }
        }
    };

    var formData = new FormData(form);
    var encodedData = new URLSearchParams(formData).toString();
    xhr.send(encodedData);

    return false;
}

function toggleRating() {
    var starbox = document.querySelector('.starbox');
    var bookmarkButton = document.getElementById('bookmarkButton');
    
    var display = window.getComputedStyle(starbox).display;

    if (display === 'none') {
        starbox.style.display = 'block';
        bookmarkButton.style.display = 'none'; 
    } else {
        starbox.style.display = 'none';
        bookmarkButton.style.display = 'block'; 
    }
}

var isLoggedIn = <%= (request.getSession().getAttribute("id") != null) ? "true" : "false" %>;

document.getElementById('bookmarkButton').addEventListener('click', function() {
    if (!isLoggedIn) {
        alert('로그인을 하세요!');
        window.location.href = "http://localhost:8080/Takoyaki/login/login.jsp";
        return false;
    }

    toggleRating();
    return false; 
});
document.getElementById('favoriteLink').addEventListener('click', addToFavorites);

document.getElementById('cancelButton').addEventListener('click', function() {
    var starbox = document.querySelector('.starbox');
    starbox.style.display = 'none';
    ratingEnabled = false;

    return false; 
});
</script>

<style>
    .star {
        position: relative;
        font-size: 4rem;
        color: #ddd;
    }

    .star input {
        width: 100%;
        height: 100%;
        position: absolute;
        left: 0;
        opacity: 0;
        cursor: pointer;
    }

    .star span {
        width: 0;
        position: absolute;
        left: 0;
        color: #F59A12;
        overflow: hidden;
        pointer-events: none;
    }
    #favoriteLink, #cancelButton {
    position: relative;
    border: none;
    display: inline-block;
    padding: 10px 20px;
    border-radius: 10px;
    font-family: "paybooc-Light", sans-serif;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
    background-color: #F59A12;
    color: aliceblue;
    font-size: 0.8em;
	}

	#favoriteLink:hover, #cancelButton:hover {
	    background-color: aliceblue;
	    color: #F59A12;
	} 
   
    #bookmarkButton { position: relative;
    border: none;
    display: inline-block;
    padding: 15px 30px;
    border-radius: 15px;
    font-family: "paybooc-Light", sans-serif;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
    background-color: #F59A12;
    color: aliceblue;
	}
	#bookmarkButton-outline {
	    position: relative;
	    padding: 15px 30px;
	    border-radius: 15px;
	    font-family: "paybooc-Light", sans-serif;
	    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	    text-decoration: none;
	    font-weight: 600;
	    transition: 0.25s;
	    border: 3px solid #F59A12;
	    color: #F59A12;aliceblue
	}
	.like{
    	float: right;
    }
   .title_d{
    	font-size : 27px;
    	text-align : center;
    	 font-weight: italic;
    	 margin : 50px; 
    }
    .title{
     font-size : 20px;
   	 font-weight: 600;
   	 margin : 30px; 
    }
    .time{
    
    }
    .result-item {
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        padding: 20px;
        margin: 20px;
        background-color: #fff;
        margin-top : 80px;
    }

    .result-category {
        font-size: 14px;
        font-style: italic;
        margin-bottom: 10px;
    }

    .result-agent {
        font-size: 14px;
        font-style: italic;
        margin-bottom: 10px;
    }

    .result-support {
        font-size: 14px;
        font-style: italic;
        margin-bottom: 10px;
    }

    .result-money1 {
        font-size: 14px;
        font-weight: italic;
        margin-bottom: 10px;
    }

    .result-money2 {
        font-size: 14px;
        font-weight: italic;
        margin-bottom: 10px;
    }

    .result-homepage, .result-viewContents {
        font-size: 14px;
        display: block;
        margin-top: 10px;
        }
    .navbar_menu .nav_contest {
		color: #F59A12;
	}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.5.1/chart.min.js"></script>
<script src="../resources/script/my_chart.js"></script>
</html>