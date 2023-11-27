<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/css/stylelog.css">
    <link rel="stylesheet" href="../resources/css/mypage.css?ver=1.2">
    <link rel="shortcut icon" href="../resources/image/shortcut.png" type="image/x-icon" />
    <script src="https://kit.fontawesome.com/d6f64dc1ee.js" crossorigin="anonymous"></script>
    
    <title>문어빵</title>
</head>
<body>
	
    <%@include file="../include/header.jsp"%>


        <div class="favoriteContainer">
    <div class="profile">
        <div class="hello">
            <p style="font-size: 30px; font-weight: bold; color: #666;">
                안녕하세요, <span style="font-size: 35px; color: #f59a12; justify-content:center;"><%= id %></span> 님            
                <a href="http://localhost:8080/Takoyaki/user/userUpdate.jsp">
    				<button class="alterButton">개인정보 수정</button>
				</a>
            </p>
        </div>
    </div>
        
        
        
            <div class="title">
                즐겨찾기 내역
            </div>
            <div class="status">
                <div class="item">
                    <div>
                        <div class="yello number" id="favoritejob">
                            <%
                            int favoritejob = 0;
                            String url2 = "AWS_RDS_ADDRESS";
                            String user2 = "DBID";
                            String password2 = "DBPW";
                            Connection jobconnection = null;
                            PreparedStatement preparedStatement2 = null;
                            ResultSet resultSet2 = null;
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver"); 
                                jobconnection = DriverManager.getConnection(url2, user2, password2);
                                String countQuery = "SELECT COUNT(*) as count FROM userBookmark WHERE id = ? AND rating > 0";
                                preparedStatement2 = jobconnection.prepareStatement(countQuery);
                                preparedStatement2.setString(1, id); 
                                resultSet2 = preparedStatement2.executeQuery();
                                if (resultSet2.next()) {
                                    favoritejob = resultSet2.getInt("count");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (resultSet2 != null) resultSet2.close();
                                if (preparedStatement2 != null) preparedStatement2.close();
                                if (jobconnection != null) jobconnection.close();
                            }
                            %>
                            <%= favoritejob %>
                        </div>
                        <div class="text">채용공고</div>
                    </div>
                </div>
                <div class="item">
                    <div>
                        <div class="yello number" id="favoriteCont">
                            <%
                            int favoriteCont = 0;
                            Connection contconnection = null;
                            PreparedStatement preparedStatement3 = null;
                            ResultSet resultSet3 = null;
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver"); 
                                contconnection = DriverManager.getConnection(url2, user2, password2);
                                String countQuery = "SELECT COUNT(*) as count FROM contUserBookmark WHERE id = ? AND rating > 0";
                                preparedStatement3 = contconnection.prepareStatement(countQuery);
                                preparedStatement3.setString(1, id); 
                                resultSet3 = preparedStatement3.executeQuery();
                                if (resultSet3.next()) {
                                    favoriteCont = resultSet3.getInt("count");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (resultSet3 != null) resultSet3.close();
                                if (preparedStatement3 != null) preparedStatement3.close();
                                if (contconnection != null) contconnection.close();
                            }
                            %>
                            <%= favoriteCont %>
                        </div>
                        <div class="text">공모전</div>
                    </div>
                </div>
                <div class="item">
                    <div>
                        <div class="yello number" id="favoriteExt">
                            <%
                            int favoriteExt = 0;
                            Connection extconnection = null;
                            PreparedStatement preparedStatement4 = null;
                            ResultSet resultSet4 = null;
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver"); 
                                extconnection = DriverManager.getConnection(url2, user2, password2);
                                String countQuery = "SELECT COUNT(*) as count FROM extUserBookmark WHERE id = ? AND rating > 0";
                                preparedStatement4 = extconnection.prepareStatement(countQuery);
                                preparedStatement4.setString(1, id); 
                                resultSet4 = preparedStatement4.executeQuery();
                                if (resultSet4.next()) {
                                    favoriteExt = resultSet4.getInt("count");
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (resultSet4 != null) resultSet4.close();
                                if (preparedStatement4 != null) preparedStatement4.close();
                                if (extconnection != null) extconnection.close();
                            }
                            %>
                            <%= favoriteExt %>
                        </div>
                        <div class="text">대외활동</div>
                    </div>
                </div>
            </div>
            
<div class="listContainer">
   <div class = "titlePlusGroup">
        <div class="title">
            채용공고 내역
        </div>
        
        <div class = "plus">
           <form id="myForm" action="http://localhost:8080/Takoyaki/user/myPage.jsp" method="post">
             <input type="hidden" id="hiddenField" name="hiddenField" value="1">
             <button type="submit" class="favoritemore">더보기</button>
         </form>
        </div>
	</div>
       
        
        <div class="container">
            <%
            String hiddenFieldValue = request.getParameter("hiddenField");
            Connection connection = null;
            PreparedStatement preparedStatement5 = null;
            ResultSet resultSet5 = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url2, user2, password2);
                if ("1".equals(hiddenFieldValue)) {
                   String sqlQuery = "SELECT * FROM userBookmark WHERE id = ? AND rating > 0 ";
                    PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
                    preparedStatement.setString(1, id);
                    ResultSet resultSet = preparedStatement.executeQuery();
                    while (resultSet.next()) {
                        String title = resultSet.getString("title");
                        String company = resultSet.getString("company");
                        String location = resultSet.getString("location");
                        String sal = resultSet.getString("sal");
                        String rating = resultSet.getString("rating");
                        String wantedAuthNo = resultSet.getString("wantedAuthNo");

                %>
                <div class="result-item">
                	<a href="http://localhost:8080/Takoyaki/contents/Detail.jsp?wantedAuthNo=<%= wantedAuthNo %>" class="result-title">제목: <%= title %></a>
                    <div class="result-company">회사: <%= company %></div>
                    <div class="result-location">위치: <%= location %></div>
                    <div class="result-salary">급여: <%= sal %></div>
                    <div class="result-salary">평가: <%= rating %></div>
                    <button class="deleteBookMark" onclick="jobDelete('<%= id %>', '<%= wantedAuthNo %>');">즐겨찾기 삭제</button>
                    
                </div>
                <%
                    }
                }
                
                else{
                String sqlQuery = "SELECT * FROM userBookmark WHERE id = ? AND rating > 0 limit 5";
                PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setString(1, id);
                ResultSet resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    String title = resultSet.getString("title");
                    String company = resultSet.getString("company");
                    String location = resultSet.getString("location");
                    String sal = resultSet.getString("sal");
                    String rating = resultSet.getString("rating");
                    String wantedAuthNo = resultSet.getString("wantedAuthNo");

            %>
            <div class="result-item">
                <a href="http://localhost:8080/Takoyaki/contents/Detail.jsp?wantedAuthNo=<%= wantedAuthNo %>" class="result-title">제목: <%= title %></a>
                <div class="result-company">회사: <%= company %></div>
                <div class="result-location">위치: <%= location %></div>
                <div class="result-salary">급여: <%= sal %></div>
                <div class="result-salary">평가: <%= rating %></div>
                <button class="deleteBookMark" onclick="jobDelete('<%= id %>', '<%= wantedAuthNo %>');">즐겨찾기 삭제</button>
                
            </div>
             <%
                }
                }%>
                <form id="myForm" action="http://localhost:8080/Takoyaki/user/myPage.jsp" method="post">
                <input type="hidden" id="hiddenField" name="hiddenField" value="4">
                <button type="submit" id="job_favorclose" class = "favorclose"  onclick = "jobclose" >접기</button>
            </form><%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
               
                if (connection != null) connection.close();

            }
            
            %>

        </div>
    </div>

    <!-- Display contest listings -->
    <div class="listContainer">
    	<div class = "titlePlusGroup">
        	<div class="title">
            	공모전 내역
        	</div>
        <div class = "plus">
           <form id="myForm" action="http://localhost:8080/Takoyaki/user/myPage.jsp" method="post">
             <input type="hidden" id="hiddenField" name="hiddenField" value="2">
             <button type="submit" class="favoritemore">더보기</button>
         	</form>
     	 </div>
   		</div>
   
   
        <div class="container">
    <%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url2, user2, password2);
        if ("2".equals(hiddenFieldValue)) {
            String contestSqlQuery = "SELECT * FROM contUserBookmark WHERE id = ? AND rating > 0 ";
            PreparedStatement preparedStatement = connection.prepareStatement(contestSqlQuery);
            preparedStatement.setString(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String category = resultSet.getString("category");
                String agent = resultSet.getString("agent");
                String rating = resultSet.getString("rating");
                int contid = resultSet.getInt("contid");
        %>
        <div class="result-item">
            <a href="http://localhost:8080/Takoyaki/contents/contDetail.jsp?contid=<%= contid %>" class="result-title">분야: <%= name %></a>
            <div class="result-category">응모대상: <%= category %></div>
            <div class="result-agent">주최/주관: <%= agent %></div>
            <div class="result-salary">평가: <%= rating %></div>
            <button class="deleteBookMark" onclick="contestDelete('<%= id %>', '<%= contid %>');">즐겨찾기 삭제</button>
        </div>
        <%										
            }
        }
        else {
            String contestSqlQuery = "SELECT * FROM contUserBookmark WHERE id = ? AND rating > 0 limit 5";
            PreparedStatement preparedStatement = connection.prepareStatement(contestSqlQuery);
            preparedStatement.setString(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String category = resultSet.getString("category");
                String agent = resultSet.getString("agent");
                String rating = resultSet.getString("rating");
                int contid = resultSet.getInt("contid");
        %>
        <div class="result-item">
            <a href="http://localhost:8080/Takoyaki/contents/contDetail.jsp?contid=<%= contid %>" class="result-title">분야: <%= name %></a>
            <div class="result-category">응모대상: <%= category %></div>
            <div class="result-agent">주최/주관: <%= agent %></div>
            <div class="result-salary">평가: <%= rating %></div>
            <button class="deleteBookMark" onclick="contestDelete('<%= id %>', '<%= contid %>');">즐겨찾기 삭제</button>
        </div>
         <%
                }
                }%>
                <form id="myForm" action="http://localhost:8080/Takoyaki/user/myPage.jsp" method="post">
                <input type="hidden" id="hiddenField" name="hiddenField" value="5">
                <button type="submit" id="job_favorclose" class = "favorclose"  onclick = "jobclose" >접기</button>
            </form><%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
               
                if (connection != null) connection.close();

            }
            
            %>

</div>



    <!-- Display external activity listings -->
<div class="listContainer">
    <div class = "titlePlusGroup">
        <div class="title">
            대외활동 내역
        </div>
        <div class = "plus">
           <form id="myForm" action="http://localhost:8080/Takoyaki/user/myPage.jsp" method="post">
             <input type="hidden" id="hiddenField" name="hiddenField" value="3">
             <button type="submit" class="favoritemore">더보기</button>
         </form>
      </div>
   </div>
        <div class="container">
            <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url2, user2, password2);
                if("3".equals(hiddenFieldValue)){
                   String activitySqlQuery = "SELECT * FROM extUserBookmark WHERE id = ? AND rating > 0";
                    PreparedStatement preparedStatement = connection.prepareStatement(activitySqlQuery);
                    preparedStatement.setString(1, id);
                    ResultSet resultSet = preparedStatement.executeQuery();
                    while (resultSet.next()) {
                        String name = resultSet.getString("name");
                        String category = resultSet.getString("category");
                        String agent = resultSet.getString("agent");
                        String rating = resultSet.getString("rating");
                        int extid = resultSet.getInt("extid");
             
                %>
                <div class="result-item">
                	
                    <a href="http://localhost:8080/Takoyaki/contents/extDetail.jsp?extid=<%= extid %>" class="result-title">분야: <%= name %></a>
                    <div class="result-category">카테고리: <%= category %></div>
                    <div class= "result-organizer">주최/주관: <%= agent %></div>
                    <div class="result-salary">평가: <%= rating %></div>
                    <button class="deleteBookMark" onclick="extDelete('<%= id %>', '<%= extid %>');">즐겨찾기 삭제</button>
                    
                    
                </div>
                <%
                    }
                }
                else{
                String activitySqlQuery = "SELECT * FROM extUserBookmark WHERE id = ? AND rating > 0 limit 5";
                PreparedStatement preparedStatement = connection.prepareStatement(activitySqlQuery);
                preparedStatement.setString(1, id);
                ResultSet resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    String name = resultSet.getString("name");
                    String category = resultSet.getString("category");
                    String agent = resultSet.getString("agent");
                    String rating = resultSet.getString("rating");
                    int extid = resultSet.getInt("extid");
         
            %>
            <div class="result-item">
                <a href="http://localhost:8080/Takoyaki/contents/extDetail.jsp?extid=<%= extid %>" class="result-title">분야: <%= name %></a>
                <div class="result-category">카테고리: <%= category %></div>
                <div class= "result-organizer">주최/주관: <%= agent %></div>
                <div class="result-salary">평가: <%= rating %></div>
                <button class="deleteBookMark" onclick="extDelete('<%= id %>', '<%= extid %>');">즐겨찾기 삭제</button>
                
                
            </div>
 				<%
                }
                }%>
                <form id="myForm" action="http://localhost:8080/Takoyaki/user/myPage.jsp" method="post">
                <input type="hidden" id="hiddenField" name="hiddenField" value="6">
                <button type="submit" id="job_favorclose" class = "favorclose"  onclick = "jobclose" >접기</button>
            </form>
            <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
               
                if (connection != null) connection.close();

            }
            
            %>

        </div>
    </div>
   

      <div class="listContainer">
    <div class = "titlePlusGroup">
        <div class="title">
            게시판 내역
        </div>
        <div class = "plus">
           <form id="myForm" action="http://localhost:8080/Takoyaki/user/myPage.jsp" method="post">
             <input type="hidden" id="hiddenField" name="hiddenField" value="4">
             <button type="submit" class="favoritemore">더보기</button>
         </form>
      </div>
   </div>

    <div class="container">
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url2, user2, password2);
            
            if("4".equals(hiddenFieldValue)){
                String sqlQuery = "SELECT * FROM bbs WHERE id = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(sqlQuery);
                preparedStatement.setString(1, id);
                ResultSet resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    String bbsTitle = resultSet.getString("bbsTitle");
                    String use_id = resultSet.getString("id");
                    String bbsDate = resultSet.getString("bbsDate");
                    int bbsId = resultSet.getInt("bbsId");
            %>
            <div class="result-item">
                <a href="http://localhost:8080/Takoyaki/board/textboard.jsp?bbsID=<%= bbsId %>" class="result-title">제목: <%= bbsTitle %></a>
                <div class="result-company">작성자: <%= use_id %></div>
                <div class="result-location">작성일: <%= bbsDate %></div>
                <button class="deleteBookMark" onclick="bbsDelete('<%= id %>', '<%= bbsId %>');">게시글 삭제</button>
            	
            	
            
       
        
        
        </div>
        <%
            }
        }
        else{
            String SqlQuery = "SELECT * FROM bbs WHERE id = ? limit 5";
            PreparedStatement preparedStatement = connection.prepareStatement(SqlQuery);
            preparedStatement.setString(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
            	String bbsTitle = resultSet.getString("bbsTitle");
                String use_id = resultSet.getString("id");
                String bbsDate = resultSet.getString("bbsDate");
                int bbsId = resultSet.getInt("bbsId");
     
        %>
        <div class="result-item">
				<a href="http://localhost:8080/Takoyaki/board/textboard.jsp?bbsID=<%= bbsId %>" class="result-title">제목: <%= bbsTitle %></a>
                <div class="result-company">작성자: <%= use_id %></div>
                <div class="result-location">작성일: <%= bbsDate %></div>
                <button class="deleteBookMark" onclick="bbsDelete('<%= id %>', '<%= bbsId %>');">게시글 삭제</button>
        </div>
         <%
                }
                }%>
                <form id="myForm" action="http://localhost:8080/Takoyaki/user/myPage.jsp" method="post">
                <input type="hidden" id="hiddenField" name="hiddenField" value="7">
                <button type="submit" id="job_favorclose" class = "favorclose"  onclick = "jobclose" >접기</button>
            </form><%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
               
                if (connection != null) connection.close();

            }
            
            %>

    		</div>
		</div>
    </div>
</div>
    <!-- Display job listings -->
    

    <%@include file="../include/footer.jsp"%>
</body>
<script src="../resources/script/delJobBookmark.js?=ver1.2"></script>
<script src="../resources/script/delContBookmark.js?=ver1.2"></script>
<script src="../resources/script/delExtBookmark.js?=ver1.2"></script>
<script src="../resources/script/delbbs.js?=ver1.2"></script>

</html>