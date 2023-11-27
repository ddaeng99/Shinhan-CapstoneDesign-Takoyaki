<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.UserDTO" scope="page" />
<jsp:setProperty name="user" property="id" />
<jsp:setProperty name="user" property="pw" />
<jsp:setProperty name="user" property="email1" />
<jsp:setProperty name="user" property="email2" />
<jsp:setProperty name="user" property="year" />
<jsp:setProperty name="user" property="month" />
<jsp:setProperty name="user" property="day" />
<jsp:setProperty name="user" property="mobile" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문어빵</title>
</head>
<body>
	<%
	String id = null;
	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}
	if (id != null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = '../main/main.jsp'");
		script.println("</script>");
	}

	if (user.getId() == null || user.getPw() == null || user.getEmail() == null || user.getBirth() == null
			|| user.getMobile() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('모든 항목을 입력해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.join(user);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			session.setAttribute("id", user.getId());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('문어빵 회원가입이 완료되었습니다!')");
			script.println("location.href = '../main/main.jsp'");
			script.println("</script>");
		}
	}
	//
	%>
</body>
</html>