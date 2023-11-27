<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@page import="bbs.bbsDAO"%>
<%@page import="bbs.bbs"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<link href="../resources/css/mainboard.css" rel='stylesheet'>

<link rel="shortcut icon" href="../resources/image/shortcut.png"
	type="image/x-icon" />


<script src="https://kit.fontawesome.com/d6f64dc1ee.js"
	crossorigin="anonymous"></script>

<title>게시판</title>
<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>

<body>
	<%@include file="../include/header.jsp"%>
	<div class='board_wrap'>
		<div class='board_title'>
			<h1>자유게시판</h1>
		</div>
		<%
		id = null;
		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		%>

		<!-- Dynamic generation of posts -->
		<div class="write">
			<a href="../board/writeboard.jsp" class="btn btn-primary pull -right">글쓰기</a>
		</div>
		<div class="container">
			<div class="row">
				<table class="table">
					<thead>
						<tr class="table_row">
							<th>번호</th>
							<!-- 수정 -->
							<th>제목</th>
							<!-- 수정 -->
							<th>작성자</th>
							<!-- 수정 -->
							<th>작성일</th>
							<!-- 수정 -->
						</tr>
					</thead>

					<tbody class="">
						<%
						bbsDAO BbsDAO = new bbsDAO();
						ArrayList<bbs> list = BbsDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
						%>
						<tr class="table_list">
							<td><%=list.get(i).getBbsID()%></td>
							<td><a
								href="../board/textboard.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%></a></td>
							<td><%=list.get(i).getuserid()%></td>
							<td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"
		+ list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
						</tr>
						<%
						}
						%>
					</tbody>

				</table>
			</div>
		</div>
		</div>
		<div class="page_btn">
			<%
			if (pageNumber != 1) {
			%>
			<a class="last"
				href="../board/mainboard.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arraw-left">이전</a>
			<%
			}
			if (BbsDAO.nextPage(pageNumber + 1)) {
			%>
			<a class="next"
				href="../board/mainboard.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arraw-left">다음</a>
		</div>
		<%
		}
		%>
	
</body>
</html>

