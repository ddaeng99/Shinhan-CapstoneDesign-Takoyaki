<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
    <%@ page import="java.sql.*" %>
    <%@ page import="org.json.simple.JSONObject" %>
    <%@ page import="org.json.simple.parser.JSONParser" %>
    <%@ page import="org.json.simple.parser.ParseException" %>
    <%
    try {
        String paramsStr = request.getParameter("paramsStr");
        JSONParser parser = new JSONParser();
        JSONObject obj = (JSONObject) parser.parse(paramsStr);
        
        String id = (String) obj.get("id");
        String bbsidStr = (String) obj.get("bbsid");
        int bbsid = Integer.parseInt(bbsidStr);
        
        // JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        String dbURL = "AWS_RDS_ADDRESS";
        String dbID = "DBID";
        String dbPW = "DBPW";

        try (Connection conn = DriverManager.getConnection(dbURL, dbID, dbPW);
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM bbs WHERE id=? AND bbsid=?")) {
            pstmt.setString(1, id);
            pstmt.setInt(2, bbsid);
            pstmt.executeUpdate();
        }
    } catch (SQLException e) {
        e.printStackTrace(); // 예외 정보 로깅
        System.out.println("DB 삭제 중 오류 발생: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace(); // 예외 정보 로깅
        System.out.println("일반 오류 발생: " + e.getMessage());
    }
    %>
</body>
</html>