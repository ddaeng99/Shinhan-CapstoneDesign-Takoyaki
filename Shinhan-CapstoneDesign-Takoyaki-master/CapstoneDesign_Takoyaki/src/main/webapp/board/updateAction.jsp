<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.bbs" %>
<%@ page import="bbs.bbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta charset="UTF-8">
<title>문어빵</title>
</head>
<body>
	<%
		String id = null;
		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
		}
	if(id == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 후 이용 가능합니다.')");
		script.println("location.href = '../login/login.jsp'"); 
		script.println("</script>");
	} 
	
	int bbsID = 0;
	if (request.getParameter("bbsID") != null ) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID==0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 글입니다.')");
		script.println("location.href = '../board/mainboard.jsp'"); 
		script.println("</script>");
	}
	bbs Bbs = new bbsDAO().getbbs(bbsID);
	if (!id.equals(Bbs.getuserid())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = '../board/mainboard.jsp'"); 
		script.println("</script>");
	} else {
		if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null
			||request.getParameter("bbsTitle").equals("") || request.getParameter("bbsContent").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); 
			script.println("</script>");
		} else {
			bbsDAO BbsDAO = new bbsDAO();
			int result = BbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 수정에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = '../board/mainboard.jsp'");
				script.println("</script>");	
			}
		}
	}
	
	%>
</body>


</body>
</html>