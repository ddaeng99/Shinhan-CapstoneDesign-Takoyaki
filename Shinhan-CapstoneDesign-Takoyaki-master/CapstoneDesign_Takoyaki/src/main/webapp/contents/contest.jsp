<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="en">
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>

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

<link rel="stylesheet" href="../resources/css/jobinfo.css">
<link rel="stylesheet" href="../resources/css/drop.css">
<link rel="shortcut icon" href="../resources/image/shortcut.png"
	type="image/x-icon" />

<script src="https://kit.fontawesome.com/d6f64dc1ee.js"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>문어빵</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>
	<form id="searchForm">
		<nav class="jobMenu">
			<ul class="jobCategory">
				<li><a href="#" id="comall" onclick="setCategory('comall')">전체</a></li>
				<li><a href="#" id="comDeadlineImminent"
					onclick="setCategory('comDeadlineImminent')">마감 임박</a></li>
				<li><a href="#" id="comAccepting"
					onclick="setCategory('comAccepting')">접수 중</a></li>
				<li><a href="#" id="comScheduledAccepted"
					onclick="setCategory('comScheduledAccepted')">접수 예정</a></li>
				<li><a href="#" id="comDeadline"
					onclick="setCategory('comDeadline')">마감 공모전</a></li>
			</ul>
			<!-- 히든 필드 -->
			<input type="hidden" id="categoryHiddenInput" name="category"
				value="">
		</nav>
	</form>

	<%
	String category = request.getParameter("category");
	int itemsPerPage = 20;
	int currentPage = 1;

	if (request.getParameter("page") != null) {
		currentPage = Integer.parseInt(request.getParameter("page"));
	}

	Connection connection = null;
	Statement statement = null;
	ResultSet competitionsResultSet = null;

	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String jdbcUrl = "AWS_RDS_ADDRESS";
		String dbId = "DBID";
		String dbPw = "DBPW";
		connection = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		statement = connection.createStatement();
		out.print("<div class='container'>");

		if ("comall".equals(category)) {
			out.print("<style>");
			out.print(".jobCategory #comall {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print("</style>");
			int startItem = (currentPage - 1) * itemsPerPage;
			String pagingQuery = "SELECT * FROM competitions ORDER BY contid DESC LIMIT " + startItem + ", " + itemsPerPage;
			competitionsResultSet = statement.executeQuery(pagingQuery);
			while (competitionsResultSet.next()) {
		String sql_comtitle = competitionsResultSet.getString("title");
		String sql_comlocation = competitionsResultSet.getString("location");
		String sql_comdate = competitionsResultSet.getString("date");
		String sql_comhref = competitionsResultSet.getString("href");
		int contid = competitionsResultSet.getInt("contid");

		out.print("<div><nav class=\"dbcomlocMenu\">");
		out.print("<ul class = dbcomitem-list>");
		out.print("<li class= dbcomitem_sql_comtitle><a href=\"javascript:void(0);\" onclick=\"contestClick('" + id
				+ "', '" + contid + "', '" + sql_comtitle + "', '" + sql_comlocation + "', '" + sql_comdate + "', '"
				+ sql_comhref + "')\">" + sql_comtitle + "</a> </li>");
		out.print("<li class= dbcomitem_sql_comlocation> 주최자 : " + sql_comlocation + "</li>");
		out.print("<li class= dbcomitem_sql_comdate> 기한 : " + sql_comdate + "</li>");
		out.print("</ul>");
		out.print("<hr class='dbhr'></nav></div>");
			}

			// 전체 항목 수 조회
			int totalCount = 0;
			String countQuery = "SELECT COUNT(*) FROM competitions";
			ResultSet countResultSet = statement.executeQuery(countQuery);
			if (countResultSet.next()) {
		totalCount = countResultSet.getInt(1);
			}

			// 이전 페이지와 다음 페이지를 계산
			int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage);
			int nextPage = currentPage + 1;
			int prevPage = currentPage - 1;
	%>
	<div class="pagination">
		<%
		if (currentPage > 1) {
		%>
		<a href="?page=1&category=<%=request.getParameter("category")%>">&laquo;</a>
		<a
			href="?page=<%=prevPage%>&category=<%=request.getParameter("category")%>">이전</a>
		<%
		}
		%>

		<%
		for (int i = Math.max(1, currentPage - 5); i <= Math.min(totalPages, currentPage + 5); i++) {
		%>
		<%
		if (i == currentPage) {
		%>
		<span class="current"><%=i%></span>
		<%
		} else {
		%>
		<a
			href="?page=<%=i%>&category=<%=request.getParameter("category")%>"><%=i%></a>
		<%
		}
		%>
		<%
		}
		%>

		<%
		if (currentPage < totalPages) {
		%>
		<a
			href="?page=<%=nextPage%>&category=<%=request.getParameter("category")%>">다음</a>
		<a
			href="?page=<%=totalPages%>&category=<%=request.getParameter("category")%>">&raquo;</a>
		<%
		}
		%>
	</div>

	<%
	}
	if ("comDeadlineImminent".equals(category)) {
		out.print("<style>");
		out.print(".navbar_menu .nav_contest {");
		out.print("color: #F59A12;");
		out.print("}");
		out.print(".jobCategory #comDeadlineImminent {");
		out.print("color: #F59A12;");
		out.print("}");
		out.print("</style>");
	int startItem = (currentPage - 1) * itemsPerPage;
	String pagingQuery = "SELECT * FROM competitions WHERE date LIKE '%마감임박%' ORDER BY contid DESC LIMIT " + startItem
			+ ", " + itemsPerPage;
	competitionsResultSet = statement.executeQuery(pagingQuery);

	while (competitionsResultSet.next()) {
		String sql_comtitle = competitionsResultSet.getString("title");
		String sql_comlocation = competitionsResultSet.getString("location");
		String sql_comdate = competitionsResultSet.getString("date");
		String sql_comhref = competitionsResultSet.getString("href");
		int contid = competitionsResultSet.getInt("contid");

		out.print("<div><nav class=\"dbcomlocMenu\">");
		out.print("<ul class = dbcomitem-list>");
		out.print("<li class= dbcomitem_sql_comtitle><a href=\"javascript:void(0);\" onclick=\"contestClick('" + id
				+ "', '" + contid + "', '" + sql_comtitle + "', '" + sql_comlocation + "', '" + sql_comdate + "', '"
				+ sql_comhref + "')\">" + sql_comtitle + "</a> </li>");
		out.print("<li class= dbcomitem_sql_comlocation> 주최자 : " + sql_comlocation + "</li>");
		out.print("<li class= dbcomitem_sql_comdate> 기한 : " + sql_comdate + "</li>");
		out.print("</ul>");
		out.print("<hr class='dbhr'></nav></div>");
	}

	// 전체 항목 수 조회
	int totalCount = 0;
	String countQuery = "SELECT COUNT(*) FROM competitions WHERE date LIKE '%마감임박%' ORDER BY contid DESC";
	ResultSet countResultSet = statement.executeQuery(countQuery);
	if (countResultSet.next()) {
		totalCount = countResultSet.getInt(1);
	}

	// 이전 페이지와 다음 페이지를 계산
	int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage);
	int nextPage = currentPage + 1;
	int prevPage = currentPage - 1;
	%>
	<div class="pagination">
		<%
		if (currentPage > 1) {
		%>
		<a href="?page=1&category=<%=request.getParameter("category")%>">&laquo;</a>
		<a
			href="?page=<%=prevPage%>&category=<%=request.getParameter("category")%>">이전</a>
		<%
		}
		%>

		<%
		for (int i = Math.max(1, currentPage - 5); i <= Math.min(totalPages, currentPage + 5); i++) {
		%>
		<%
		if (i == currentPage) {
		%>
		<span class="current"><%=i%></span>
		<%
		} else {
		%>
		<a
			href="?page=<%=i%>&category=<%=request.getParameter("category")%>"><%=i%></a>
		<%
		}
		%>
		<%
		}
		%>

		<%
		if (currentPage < totalPages) {
		%>
		<a
			href="?page=<%=nextPage%>&category=<%=request.getParameter("category")%>">다음</a>
		<a
			href="?page=<%=totalPages%>&category=<%=request.getParameter("category")%>">&raquo;</a>
		<%
		}
		%>
	</div>


	<%
	}
	if ("comAccepting".equals(category)) {
		out.print("<style>");
		out.print(".navbar_menu .nav_contest {");
		out.print("color: #F59A12;");
		out.print("}");
		out.print(".jobCategory #comAccepting {");
		out.print("color: #F59A12;");
		out.print("}");
		out.print("</style>");
	int startItem = (currentPage - 1) * itemsPerPage;
	String pagingQuery = "SELECT * FROM competitions WHERE date LIKE '%접수중%' ORDER BY contid DESC LIMIT " + startItem + ", "
			+ itemsPerPage;
	competitionsResultSet = statement.executeQuery(pagingQuery);

	while (competitionsResultSet.next()) {
		String sql_comtitle = competitionsResultSet.getString("title");
		String sql_comlocation = competitionsResultSet.getString("location");
		String sql_comdate = competitionsResultSet.getString("date");
		String sql_comhref = competitionsResultSet.getString("href");
		int contid = competitionsResultSet.getInt("contid");

		out.print("<div><nav class=\"dbcomlocMenu\">");
		out.print("<ul class = dbcomitem-list>");
		out.print("<li class= dbcomitem_sql_comtitle><a href=\"javascript:void(0);\" onclick=\"contestClick('" + id
				+ "', '" + contid + "', '" + sql_comtitle + "', '" + sql_comlocation + "', '" + sql_comdate + "', '"
				+ sql_comhref + "')\">" + sql_comtitle + "</a> </li>");
		out.print("<li class= dbcomitem_sql_comlocation> 주최자 : " + sql_comlocation + "</li>");
		out.print("<li class= dbcomitem_sql_comdate> 기한 : " + sql_comdate + "</li>");
		out.print("</ul>");
		out.print("<hr class='dbhr'></nav></div>");
	}

	// 전체 항목 수 조회
	int totalCount = 0;
	String countQuery = "SELECT COUNT(*) FROM competitions WHERE date LIKE '%접수중%'";
	ResultSet countResultSet = statement.executeQuery(countQuery);
	if (countResultSet.next()) {
		totalCount = countResultSet.getInt(1);
	}

	// 이전 페이지와 다음 페이지를 계산
	int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage);
	int nextPage = currentPage + 1;
	int prevPage = currentPage - 1;
	%>
	<div class="pagination">
		<%
		if (currentPage > 1) {
		%>
		<a href="?page=1&category=<%=request.getParameter("category")%>">&laquo;</a>
		<a
			href="?page=<%=prevPage%>&category=<%=request.getParameter("category")%>">이전</a>
		<%
		}
		%>

		<%
		for (int i = Math.max(1, currentPage - 5); i <= Math.min(totalPages, currentPage + 5); i++) {
		%>
		<%
		if (i == currentPage) {
		%>
		<span class="current"><%=i%></span>
		<%
		} else {
		%>
		<a
			href="?page=<%=i%>&category=<%=request.getParameter("category")%>"><%=i%></a>
		<%
		}
		%>
		<%
		}
		%>

		<%
		if (currentPage < totalPages) {
		%>
		<a
			href="?page=<%=nextPage%>&category=<%=request.getParameter("category")%>">다음</a>
		<a
			href="?page=<%=totalPages%>&category=<%=request.getParameter("category")%>">&raquo;</a>
		<%
		}
		%>
	</div>

	<%
	}
	if ("comScheduledAccepted".equals(category)) {
		out.print("<style>");
		out.print(".navbar_menu .nav_contest {");
		out.print("color: #F59A12;");
		out.print("}");
		out.print(".jobCategory #comScheduledAccepted {");
		out.print("color: #F59A12;");
		out.print("}");
		out.print("</style>");
	int startItem = (currentPage - 1) * itemsPerPage;
	String pagingQuery = "SELECT * FROM competitions WHERE date LIKE '%접수예정%' ORDER BY contid DESC LIMIT " + startItem
			+ ", " + itemsPerPage;
	competitionsResultSet = statement.executeQuery(pagingQuery);

	while (competitionsResultSet.next()) {
		String sql_comtitle = competitionsResultSet.getString("title");
		String sql_comlocation = competitionsResultSet.getString("location");
		String sql_comdate = competitionsResultSet.getString("date");
		String sql_comhref = competitionsResultSet.getString("href");
		int contid = competitionsResultSet.getInt("contid");

		out.print("<div><nav class=\"dbcomlocMenu\">");
		out.print("<ul class = dbcomitem-list>");
		out.print("<li class= dbcomitem_sql_comtitle><a href=\"javascript:void(0);\" onclick=\"contestClick('" + id
				+ "', '" + contid + "', '" + sql_comtitle + "', '" + sql_comlocation + "', '" + sql_comdate + "', '"
				+ sql_comhref + "')\">" + sql_comtitle + "</a> </li>");
		out.print("<li class= dbcomitem_sql_comlocation> 주최자 : " + sql_comlocation + "</li>");
		out.print("<li class= dbcomitem_sql_comdate> 기한 : " + sql_comdate + "</li>");
		out.print("</ul>");
		out.print("<hr class='dbhr'></nav></div>");
	}

	// 전체 항목 수 조회
	int totalCount = 0;
	String countQuery = "SELECT COUNT(*) FROM competitions WHERE date LIKE '%접수예정%'";
	ResultSet countResultSet = statement.executeQuery(countQuery);
	if (countResultSet.next()) {
		totalCount = countResultSet.getInt(1);
	}

	// 이전 페이지와 다음 페이지를 계산
	int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage);
	int nextPage = currentPage + 1;
	int prevPage = currentPage - 1;
	%>
	<div class="pagination">
		<%
		if (currentPage > 1) {
		%>
		<a href="?page=1&category=<%=request.getParameter("category")%>">&laquo;</a>
		<a
			href="?page=<%=prevPage%>&category=<%=request.getParameter("category")%>">이전</a>
		<%
		}
		%>

		<%
		for (int i = Math.max(1, currentPage - 5); i <= Math.min(totalPages, currentPage + 5); i++) {
		%>
		<%
		if (i == currentPage) {
		%>
		<span class="current"><%=i%></span>
		<%
		} else {
		%>
		<a
			href="?page=<%=i%>&category=<%=request.getParameter("category")%>"><%=i%></a>
		<%
		}
		%>
		<%
		}
		%>

		<%
		if (currentPage < totalPages) {
		%>
		<a
			href="?page=<%=nextPage%>&category=<%=request.getParameter("category")%>">다음</a>
		<a
			href="?page=<%=totalPages%>&category=<%=request.getParameter("category")%>">&raquo;</a>
		<%
		}
		%>
	</div>

	<%
	}
	if ("comDeadline".equals(category)) {
		out.print("<style>");
		out.print(".navbar_menu .nav_contest {");
		out.print("color: #F59A12;");
		out.print("}");
		out.print(".jobCategory #comDeadline {");
		out.print("color: #F59A12;");
		out.print("}");
		out.print("</style>");
	int startItem = (currentPage - 1) * itemsPerPage;
	String pagingQuery = "SELECT * FROM competitions WHERE date like '%D+%' ORDER BY contid DESC LIMIT " + startItem + ", "
			+ itemsPerPage;
	competitionsResultSet = statement.executeQuery(pagingQuery);

	while (competitionsResultSet.next()) {
		String sql_comtitle = competitionsResultSet.getString("title");
		String sql_comlocation = competitionsResultSet.getString("location");
		String sql_comdate = competitionsResultSet.getString("date");
		String sql_comhref = competitionsResultSet.getString("href");
		int contid = competitionsResultSet.getInt("contid");

		out.print("<div><nav class=\"dbcomlocMenu\">");
		out.print("<ul class = dbcomitem-list>");
		out.print("<li class= dbcomitem_sql_comtitle><a href=\"javascript:void(0);\" onclick=\"contestClick('" + id
				+ "', '" + contid + "', '" + sql_comtitle + "', '" + sql_comlocation + "', '" + sql_comdate + "', '"
				+ sql_comhref + "')\">" + sql_comtitle + "</a> </li>");
		out.print("<li class= dbcomitem_sql_comlocation> 주최자 : " + sql_comlocation + "</li>");
		out.print("<li class= dbcomitem_sql_comdate> 기한 : " + sql_comdate + "</li>");
		out.print("</ul>");
		out.print("<hr class='dbhr'></nav></div>");
	}

	// 전체 항목 수 조회
	int totalCount = 0;
	String countQuery = "SELECT COUNT(*) FROM competitions WHERE date like '%D+%'";
	ResultSet countResultSet = statement.executeQuery(countQuery);
	if (countResultSet.next()) {
		totalCount = countResultSet.getInt(1);
	}

	// 이전 페이지와 다음 페이지를 계산
	int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage);
	int nextPage = currentPage + 1;
	int prevPage = currentPage - 1;
	%>
	<div class="pagination">
		<%
		if (currentPage > 1) {
		%>
		<a href="?page=1&category=<%=request.getParameter("category")%>">&laquo;</a>
		<a
			href="?page=<%=prevPage%>&category=<%=request.getParameter("category")%>">이전</a>
		<%
		}
		%>

		<%
		for (int i = Math.max(1, currentPage - 5); i <= Math.min(totalPages, currentPage + 5); i++) {
		%>
		<%
		if (i == currentPage) {
		%>
		<span class="current"><%=i%></span>
		<%
		} else {
		%>
		<a
			href="?page=<%=i%>&category=<%=request.getParameter("category")%>"><%=i%></a>
		<%
		}
		%>
		<%
		}
		%>

		<%
		if (currentPage < totalPages) {
		%>
		<a
			href="?page=<%=nextPage%>&category=<%=request.getParameter("category")%>">다음</a>
		<a
			href="?page=<%=totalPages%>&category=<%=request.getParameter("category")%>">&raquo;</a>
		<%
		}
		%>
	</div>

	<%
	}
	if ("comRecommend".equals(category)) {
	out.print("없음");
	}

	} catch (ClassNotFoundException e) {
	e.printStackTrace(); // 또는 로깅
	} catch (SQLException e) {
	e.printStackTrace(); // 또는 로깅
	} finally {
	// 연결 및 statement 등 자원 해제 코드 추가
	}
	out.print("</div>");
	%>
	<script>
		function setCategory(category) {
			// 히든 필드에 선택한 카테고리 값을 설정합니다.
			document.getElementById('categoryHiddenInput').value = category;
			// 폼을 서버로 제출합니다.
			document.getElementById('searchForm').submit();
		}
	</script>


	<script>
		//jQuery를 사용하여 AJAX 요청을 보내고 응답을 처리합니다.

		// 페이지가 로드될 때 한 번만 실행되는 코드

		$(document)
				.ready(
						function() {
							// 페이지 로드 시 자동으로 'comall' 카테고리를 선택하도록 합니다.

							// 카테고리를 클릭할 때의 이벤트 핸들러입니다.
							$('.jobCategory a')
									.click(
											function(e) {
												e.preventDefault();

												var categoryId = $(this).attr(
														'contid');

												$
														.ajax({
															type : 'GET',
															url : 'http://localhost:8080/Takoyaki/contents/contest.jsp',
															data : {
																category : categoryId
															},
															dataType : 'json', // 서버에서 JSON 응답을 보낼 것으로 기대합니다.
															success : function(
																	response) {
																// 서버 응답을 JSON 형식으로 받았다고 가정합니다.
																console
																		.log(
																				'서버 응답:',
																				response);

																// JSON 응답의 예시 구조: { "competitions": [ {"title": "대회 제목", "location": "장소", "date": "날짜"}, {...}, ... ] }

																// 여기에서 JSON 데이터를 처리하고 화면에 추가하는 예시입니다.
																if (response
																		&& response.competitions
																		&& response.competitions.length > 0) {
																	// competitions 배열에서 각 대회 정보를 가져와서 화면에 추가하는 예시입니다.
																	response.competitions
																			.forEach(function(
																					competition) {
																				// competition 객체에서 필요한 정보를 추출합니다.
																				var title = competition.title;
																				var location = competition.location;
																				var date = competition.date;

																				// 화면에 대회 정보를 추가하는 예시입니다.
																				var competitionInfo = $('<div><nav class="dbcomlocMenu">'
																						+ '<ul class="dbcomitem-list">'
																						+ '<li class="dbcomitem_sql_comtitle"><a href="' + href + '" target="_blank">'
																						+ title
																						+ '</a></li>'
																						+ '<li class="dbcomitem_sql_comlocation"> 주최자 : '
																						+ location
																						+ '</li>'
																						+ '<li class="dbcomitem_sql_comdate"> 기한 : '
																						+ date
																						+ '</li>'
																						+ '</ul>'
																						+ '<hr class="dbhr"></nav></div>');

																				// competitionInfo를 어떤 요소에 추가할지 선택하고 추가합니다.
																				// 예를 들어, id가 "competitionContainer"인 요소에 추가한다고 가정하면:
																				$(
																						'#competitionContainer')
																						.append(
																								competitionInfo);
																			});
																} else {
																	// 대회 정보가 없는 경우에 대한 처리를 여기에 추가할 수 있습니다.
																	console
																			.log('대회 정보가 없습니다.');
																}
															},
															error : function(
																	error) {
																console
																		.error(
																				'서버 요청 실패:',
																				error);
															}
														});
											});
						});
	</script>

	<style>
/* CSS 코드 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    }
.jobCategory {
margin-bottom: 3%;
}
.jobCategory li a.active {
	text-decoration: underline;
}
.jobCategory a{
font-weight: 600;
}

.container {
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	font-weight: 580;
}

.dbcomitem_sql_comdate {
	color: #B24A4A;
}

.dbcomitem_sql_comtitle a {
	color: #F59A12;
	text-decoration: none;
}

.pagination {
	text-align: center;
	margin-top: 20px;
}

.pagination span {
	text-decoration: none;
	font-weight: bold;
	border: 1.5px solid #F59A12;
	padding: 5px 10px;
	border-radius: 5px;
	background-color: #F59A12;
	color: white;
}

.pagination a {
	text-decoration: none;
	color: #F59A12;
	font-weight: bold;
	border: 1.5px solid #F59A12;
	padding: 5px 10px;
	border-radius: 5px;
}

.pagination a.active {
	background-color: #F59A12;
	color: white;
}

.pagination a:hover {
	background-color: #ebe9e9;
	color: #F59A12;
}

.container {
	min-height: 70%; /* 최소한의 높이를 화면 높이로 설정합니다. */
	/* 바디의 패딩을 제거합니다. */
}

.dbcomitem-list {
	list-style: none;
	padding: 0;
}
</style>


	<%@include file="../include/footer.jsp"%>
</body>
<script src="../resources/script/contestSaveDb.js?ver=1.1"></script>
</html>