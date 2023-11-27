<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%@ page import="java.sql.*"%>
    <%
    // JDBC 드라이버 로드
    Class.forName("com.mysql.cj.jdbc.Driver");

    String dbURL = "AWS_RDS_ADDRESS";
    String dbID = "DBID";
    String dbPW = "DBPW";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        conn = DriverManager.getConnection(dbURL, dbID, dbPW);
        String id = (String) session.getAttribute("id");
        
        if (request.getParameter("rating") != null) {
            String wantedAuthNo = request.getParameter("wantedAuthNo");
            String rating = request.getParameter("rating");
            
            // wantedAuthNo를 사용하여 worknet 테이블에서 정보 가져오기
            String title, company, location, sal, occupation;
            title = "title"; 
            company = "company";
            location = "location";
            sal = "sal";
            occupation = "occupation";
            pstmt = conn.prepareStatement("SELECT title, company, location, sal, occupation FROM worknet WHERE wantedAuthNo = ?");
            pstmt.setString(1, wantedAuthNo);
            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                title = resultSet.getString("title");
                company = resultSet.getString("company");
                location = resultSet.getString("location");
                sal = resultSet.getString("sal");
                occupation = resultSet.getString("occupation");
            }
            
            // userBookmark 테이블에 정보 삽입
            pstmt = conn.prepareStatement("INSERT INTO userBookmark (id, wantedAuthNo, title, company, location, sal, occupation, rating) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setString(1, id);
            pstmt.setString(2, wantedAuthNo);
            pstmt.setString(3, title);
            pstmt.setString(4, company);
            pstmt.setString(5, location);
            pstmt.setString(6, sal);
            pstmt.setString(7, occupation);
            pstmt.setString(8, rating);
            pstmt.executeUpdate();
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("DB 작업 중 오류 발생: " + e.getMessage());
    } finally {
    	 try {
    	        if (pstmt != null) {
    	            pstmt.close();
    	        }
    	        if (conn != null) {
    	            conn.close();
    	        }
    	    } catch (SQLException e) {
    	        e.printStackTrace();
    	    }
    }
    %>
</body>
</html>