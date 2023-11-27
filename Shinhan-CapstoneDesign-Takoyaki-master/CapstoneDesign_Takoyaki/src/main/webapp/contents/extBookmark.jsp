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
        String extid = request.getParameter("extid");
        String rating = request.getParameter("rating");

        // 클라이언트에서 보낸 name, category, agent 값 가져오기
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String agent = request.getParameter("agent");

        if (agent.length() > 30) {
            agent = agent.substring(0, 30);
        }
        pstmt = conn.prepareStatement("SELECT * FROM extUserBookmark WHERE id = ? AND extid = ?");
        pstmt.setString(1, id);
        pstmt.setString(2, extid);
        ResultSet resultSet = pstmt.executeQuery();

        if (resultSet.next()) {
            // 레코드가 있다면 UPDATE 문을 사용하여 별점 업데이트
            pstmt = conn.prepareStatement("UPDATE extUserBookmark SET rating = ? WHERE id = ? AND extid = ?");
            pstmt.setString(1, rating);
            pstmt.setString(2, id);
            pstmt.setString(3, extid);
            pstmt.executeUpdate();
        } else {
            // 레코드가 없다면 INSERT 문을 사용하여 새 레코드 삽입
            pstmt = conn.prepareStatement("INSERT INTO extUserBookmark (id, extid, name, category, agent, rating) VALUES (?, ?, ?, ?, ?, ?)");
            pstmt.setString(1, id);
            pstmt.setString(2, extid);
            pstmt.setString(3, name);
            pstmt.setString(4, category);
            pstmt.setString(5, agent);
            pstmt.setString(6, rating);
            pstmt.executeUpdate();
        }
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
