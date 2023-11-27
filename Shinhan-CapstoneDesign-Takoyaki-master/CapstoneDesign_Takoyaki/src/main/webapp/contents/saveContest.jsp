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
        String contidStr = (String) obj.get("contid");
        int contid = Integer.parseInt(contidStr);
        String sql_comtitle = (String) obj.get("sql_comtitle");
        String sql_comlocation = (String) obj.get("sql_comlocation");
        String sql_comdate = (String) obj.get("sql_comdate");
        String sql_comhref = (String) obj.get("sql_comhref");

        // JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        String dbURL = "AWS_RDS_ADDRESS";
        String dbID = "DBID";
        String dbPW = "DBPW";

        try (Connection conn = DriverManager.getConnection(dbURL, dbID, dbPW);
             PreparedStatement pstmt = conn.prepareStatement("INSERT INTO cbf_cont VALUES (?, ?, ?, ?, ?, ?)")) {
            pstmt.setString(1, id);
            pstmt.setInt(2, contid);
            pstmt.setString(3, sql_comtitle);
            pstmt.setString(4, sql_comlocation);
            pstmt.setString(5, sql_comdate);
            pstmt.setString(6, sql_comhref);
            pstmt.executeUpdate();
        }
    } catch (SQLException e) {
        e.printStackTrace(); // 예외 정보 로깅
        System.out.println("DB 저장 중 오류 발생: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace(); // 예외 정보 로깅
        System.out.println("일반 오류 발생: " + e.getMessage());
    }
    %>
</body>
</html>