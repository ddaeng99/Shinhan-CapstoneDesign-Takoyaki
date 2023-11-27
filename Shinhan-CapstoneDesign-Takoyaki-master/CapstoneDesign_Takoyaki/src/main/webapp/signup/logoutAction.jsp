<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문어빵</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<script>
		location.href = '../main/main.jsp'
	</script>
</body>
</html>