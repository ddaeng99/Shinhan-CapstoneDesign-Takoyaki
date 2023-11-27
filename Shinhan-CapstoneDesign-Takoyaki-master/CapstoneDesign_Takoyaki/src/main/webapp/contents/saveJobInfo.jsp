<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="org.json.simple.JSONObject" %>
	<%@ page import="org.json.simple.parser.JSONParser" %>
	<%@ page import="org.json.simple.parser.ParseException" %>
	<%
	
	String paramsStr = request.getParameter("paramsStr");
	JSONParser parser = new JSONParser();
	JSONObject obj = null;
	obj = (JSONObject)parser.parse(paramsStr);
	
	String id = (String) obj.get("id");
    String wantedAuthNo = (String) obj.get("wantedAuthNo");
    String title = (String) obj.get("title");
    String sal = (String) obj.get("sal");
    String location = (String) obj.get("location");

	
	try {
		Connection conn;
		PreparedStatement pstmt;
		ResultSet rs;
		
		// JDBC 드라이버 로드 및 DB 연결
		Class.forName("com.mysql.cj.jdbc.Driver"); 	
		String dbURL = "AWS_RDS_ADDRESS";
		String dbID = "DBID";
		String dbPW = "DBPW";
		conn = DriverManager.getConnection(dbURL, dbID, dbPW);

		// SQL 문 실행 (예: MySQL을 사용하는 경우)
		String sql = "INSERT INTO reco_tb VALUES (?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, wantedAuthNo);
		pstmt.setString(3, title);
		pstmt.setString(4, sal);
		pstmt.setString(5, location);
		pstmt.executeUpdate();

		// DB 연결 해제
		pstmt.close();
		conn.close();

		out.println("게시물 제목이 DB에 저장되었습니다.");
	} catch (Exception e) {
		out.println("DB 저장 중 오류 발생: " + e.getMessage());
	}
	%>
</body>
</html>