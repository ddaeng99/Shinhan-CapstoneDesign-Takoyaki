<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.bbs"%>
<%@ page import="bbs.bbsDAO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=, initial-scale=1.0">
<title>문어빵 게시판 글</title>
<link rel="stylesheet" href="../resources/css/boardlist.css">

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
</head>
<body>
	<header>
		<%@include file="../include/header.jsp"%>
	</header>
	<%
	id = null;
	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 글입니다.')");
		script.println("location.href = '../board/mainboard.jsp'");
		script.println("</script>");
	}
	bbs Bbs = new bbsDAO().getbbs(bbsID);
	%>

	<div class="container">
		<div>
			<table class="table">

				<tbody>
					<tr class="row_t">
						<td>제목</td>
						<td colspan="3" class="title_s"><%=Bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n",
		"<br>")%>
						</td>
					</tr>
					<tr class="row_s">
						<td class="title writwer">작성자</td>
						<td class><%=Bbs.getuserid()%></td>
						<td class="title date">작성일자</td>
						<td><%=Bbs.getBbsDate().substring(0, 11) + Bbs.getBbsDate().substring(11, 13) + "시"
		+ Bbs.getBbsDate().substring(14, 16) + "분"%>
						</td>
					</tr>
					<tr class="content">
						<td class="content_s" colspan="4"><%=Bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n",
		"<br>")%>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="submit_write">
				<%
				if (id != null && id.equals(Bbs.getuserid())) {
				%>
				<a onclick="return confirm('정말로 삭제하시겠습니까?)"
					href="../board/deleteAction.jsp?bbsID=<%=bbsID%>"
					class="btn btn-primary">삭제</a> <a
					href="../board/updateboard.jsp?bbsID=<%=bbsID%>"
					class="btn btn-primary">수정</a>

				<%
				}
				%>
				<a href="../board/mainboard.jsp" class="btn btn-primary">목록</a>
			</div>
		</div>
	</div>
</body>
</html>
