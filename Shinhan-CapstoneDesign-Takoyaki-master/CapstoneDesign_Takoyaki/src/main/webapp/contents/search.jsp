<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import ="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.*,javax.servlet.http.*"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
   rel="stylesheet">

<link rel="stylesheet" href="../resources/css/jobinfo.css">
<link rel="stylesheet" href="../resources/css/drop.css">
<link rel="shortcut icon" href="../resources/image/shortcut.png"
   type="image/x-icon" />

<script src="https://kit.fontawesome.com/d6f64dc1ee.js"
   crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>문어빵</title>
</head>
<body>


 <%@include file="../include/header.jsp"%>
    
    
    
    
    
    <% 
    
   
    int itemsPerPage = 5; // 처음 페이지에서 보여줄 항목 수
    int detailitemsPerPage = 20;
    int currentPage = 1;// 시작 아이템 인덱스
    int offset;
    String query ="";
    String comquery = "";
    String exquery = "";
    String userInput = request.getParameter("searchkeyword");
    String returnnum = request.getParameter("returnnum");
    String wantedAuthNo ="";
    
    
    
    
    %>
    
    <input type="hidden" id="returnnum" name="returnnum" value="<%= returnnum %>">
    
    <%
    
    
    Connection connection = null;
    Statement statement = null;
    ResultSet countResultSet = null;
    ResultSet resultSet = null;
    ResultSet job_moreResultSet = null;
    ResultSet comcountResultSet = null;
    ResultSet competitionsResultSet = null;
    ResultSet excountResultSet = null;
    ResultSet externalsResultSet = null;
    
   
    if(userInput != null && !userInput.isBlank()){
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcUrl = "AWS_RDS_ADDRESS";
        String dbId = "DBID";
        String dbPw = "DBPW";
        connection = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
        statement = connection.createStatement();
        out.print("<div class='tong'><h1>통합검색</h1></div>");
        
        
     // 페이지 파라미터가 있을 때
        if (request.getParameter("page") != null) {
             currentPage = Integer.parseInt(request.getParameter("page"));
             offset = (currentPage - 1) * detailitemsPerPage;

            if ("1".equals(returnnum)) {
                // returnnum이 1일 때의 처리
                query = "SELECT * FROM worknet WHERE title LIKE '%" + userInput + "%' OR company LIKE '%" + userInput + "%' OR location LIKE '%" + userInput + "%' OR sal LIKE '%" + userInput + "%' ORDER BY location LIMIT " + detailitemsPerPage + " OFFSET " + offset;
                String countQuery = "SELECT COUNT(*) AS count FROM worknet WHERE title LIKE '%" + userInput + "%' OR company LIKE '%" + userInput + "%' OR location LIKE '%" + userInput + "%' OR sal LIKE '%" + userInput + "%'";
                countResultSet = statement.executeQuery(countQuery);
                int count = 0;
                if (countResultSet.next()) {
                    count = countResultSet.getInt("count");
                }
            resultSet = statement.executeQuery(query);

            out.print("<div class='container'>");
            out.print("<h3><span class='user-input'>" + userInput + "</span>에 대한 검색결과입니다. <br>채용정보: " + count + " 건</h3>");
            if(count != 0 && itemsPerPage == 5 && request.getParameter("page") == null){
            out.print(" <span class='job_more' >더보기 +</span>");
            }
            while (resultSet.next()) {
                String title = resultSet.getString("title");
                String sql_company = resultSet.getString("company");
                String location = resultSet.getString("location");
                String sal = resultSet.getString("sal");
                String url = resultSet.getString("wantedInfoUrl");
                wantedAuthNo = resultSet.getString("wantedAuthNo");
                String sql_closeDt = resultSet.getString("closeDt");
                /* String detailPageUrl = "http://localhost:8080/Takoyaki/contents/Detail.jsp?wantedAuthNo=" + sql_wantedAuthNo; */

               
                out.print("<div><nav class=\"dblocMenu\">");
                out.print("<ul class = dbitem-list>");
                out.print("<li class= dbitem_urltitle><a href=\"javascript:void(0);\" onclick=\"jobInfoClick('"+ id + "', '" + wantedAuthNo + "', '"+ title + "', '"+ sal + "', '" + location + "', '" + url + "')\">"+ title + "</a> </li>");
                out.print("<li class= dbitem_company>" + sql_company + "</li>");
                out.print("<li class= dbitem_loc> 지역 : " + location + "</li>");
                out.print("<li class= dbitem_sal> 급여 : " + sal + "</li>");
                out.print("<li class= dbitem_close> 마감일자 : " + sql_closeDt + "</li>");
                out.print("</ul>");
                out.print("<hr class='dbhr'></nav></div>");
                
            }
            out.print("</div>");%>
            <div class="pagination">
<%  //페이징
int totalPages = (int) Math.ceil((double) count / detailitemsPerPage);
int range = 2; // 현재 페이지 주변에 표시할 페이지 범위
int startPage = Math.max(1, currentPage - range);
int endPage = Math.min(totalPages, currentPage + range);

if (currentPage > 1) { %>
  <a href="?page=1&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">&laquo;</a>
  <a href="?page=<%= currentPage - 1 %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">이전</a>
<% } %>

<% for (int i = startPage; i <= endPage; i++) { 
   if (i == currentPage) { %>
      <span class="current"><%= i %></span>
  <% } else { %>
      <a href="?page=<%= i %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>"><%= i %></a>
  <% } 
} %>

<% if (currentPage < totalPages) { %>
  <a href="?page=<%= currentPage + 1 %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">다음</a>
  <a href="?page=<%= totalPages %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">&raquo;</a>
<% } %>
</div><%
          
            
            } else if ("2".equals(returnnum)) {
                // returnnum이 2일 때의 처리 
                comquery = "SELECT * FROM competitions WHERE title LIKE '%" + userInput + "%' OR location LIKE '%" + userInput + "%'  ORDER BY contid DESC LIMIT " + detailitemsPerPage + " OFFSET " + offset;
                String comcountQuery = "SELECT COUNT(*) AS count FROM competitions WHERE title LIKE '%"  + userInput + "%' OR location LIKE '%" + userInput + "%'";
                comcountResultSet = statement.executeQuery(comcountQuery);
                int comcount = 0;
                if (comcountResultSet.next()) {
                    comcount = comcountResultSet.getInt("count");
                }
                competitionsResultSet = statement.executeQuery(comquery);

                out.print("<div class='comcontainer'>");
                out.print("<h3><span class='user-input'>" + userInput + "</span>에 대한 검색결과입니다. <br>공모전: " + comcount + " 건</h3>");
                if(comcount != 0 && itemsPerPage == 5 && request.getParameter("page") == null){
                out.print(" <span class='com_more' >더보기 +</span>");
                }
                while (competitionsResultSet.next()) {
                  String sql_comtitle = competitionsResultSet.getString("title");
                    String sql_comlocation = competitionsResultSet.getString("location");
                    String sql_comdate = competitionsResultSet.getString("date");
                    String sql_comhref = competitionsResultSet.getString("href");
                    int contid = competitionsResultSet.getInt("contid");
                    
                    out.print("<div><nav class=\"dbcomlocMenu\">");
                    out.print("<ul class = dbcomitem-list>");
                    out.print("<li class= dbcomitem_sql_comtitle><a href=\"javascript:void(0);\" onclick=\"contestClick('" + id
            				+ "', '" + contid + "', '" + sql_comtitle + "', '" + sql_comlocation + "', '" + sql_comdate + "', '"
            				+ sql_comhref + "')\">" + sql_comtitle + "</a> </li>");
                    out.print("<li class= dbcomitem_sql_comlocation> 주최자 : " + sql_comlocation + "</li>");
                    out.print("<li class= dbcomitem_sql_comdate> 기한 : " + sql_comdate + "</li>");
                    out.print("</ul>");
                    out.print("<hr class='dbhr'></nav></div>");
                    
                }
                
                out.print("</div>");%>
                <div class="pagination">
  <%  //페이징
  int totalPages = (int) Math.ceil((double) comcount / detailitemsPerPage);
  int range = 2; // 현재 페이지 주변에 표시할 페이지 범위
  int startPage = Math.max(1, currentPage - range);
  int endPage = Math.min(totalPages, currentPage + range);
  
  if (currentPage > 1) { %>
      <a href="?page=1&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">&laquo;</a>
      <a href="?page=<%= currentPage - 1 %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">이전</a>
  <% } %>

  <% for (int i = startPage; i <= endPage; i++) { 
       if (i == currentPage) { %>
          <span class="current"><%= i %></span>
      <% } else { %>
          <a href="?page=<%= i %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>"><%= i %></a>
      <% } 
   } %>

  <% if (currentPage < totalPages) { %>
      <a href="?page=<%= currentPage + 1 %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">다음</a>
      <a href="?page=<%= totalPages %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">&raquo;</a>
  <% } %>
</div><%
            } else if ("3".equals(returnnum)) {
                // returnnum이 3일 때의 처리
                exquery = "SELECT * FROM externals WHERE title LIKE '%" + userInput + "%' OR location LIKE '%" + userInput + "%'  ORDER BY extid DESC LIMIT " + detailitemsPerPage + " OFFSET " + offset;
                String excountQuery = "SELECT COUNT(*) AS count FROM externals WHERE title LIKE '%"  + userInput + "%' OR location LIKE '%" + userInput + "%'";
                excountResultSet = statement.executeQuery(excountQuery);
                int excount = 0;
                if (excountResultSet.next()) {
                    excount = excountResultSet.getInt("count");
                }
               
                externalsResultSet = statement.executeQuery(exquery);


                out.print("<div class='excontainer'>");
                out.print("<h3><span class='user-input'>" + userInput + "</span>에 대한 검색결과입니다. <br>대외활동: " + excount + " 건</h3>");
                if(excount != 0 && itemsPerPage == 5 && request.getParameter("page") == null){
                out.print(" <span class='ex_more' >더보기 +</span>");
                }
                while (externalsResultSet.next()) {
                  String sql_extitle = externalsResultSet.getString("title");
                    String sql_exlocation = externalsResultSet.getString("location");
                    String sql_exdate = externalsResultSet.getString("date");
                    String sql_exhref = externalsResultSet.getString("href");
                    int extid = externalsResultSet.getInt("extid");
                    
                    out.print("<div><nav class=\"dbexlocMenu\">");
                    out.print("<ul class = dbexitem-list>");
                    out.print("<li class= dbexitem_sql_comtitle><a href=\"javascript:void(0);\" onclick=\"extClick('"+ id + "', '" + extid + "', '"+ sql_extitle + "', '"+ sql_exlocation + "', '" + sql_exdate + "', '" + sql_exhref + "')\">"+ sql_extitle + "</a> </li>");
                    out.print("<li class= dbexitem_sql_comlocation> 주최자 : " + sql_exlocation + "</li>");
                    out.print("<li class= dbexitem_sql_comdate> 기한 : " + sql_exdate + "</li>");
                    out.print("</ul>");
                    out.print("<hr class='dbhr'></nav></div>");
                    
                }
              
                out.print("</div>");%>
                <div class="pagination">
  <%  //페이징
  int totalPages = (int) Math.ceil((double) excount / detailitemsPerPage);
  int range = 2; // 현재 페이지 주변에 표시할 페이지 범위
  int startPage = Math.max(1, currentPage - range);
  int endPage = Math.min(totalPages, currentPage + range);
  
  if (currentPage > 1) { %>
      <a href="?page=1&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">&laquo;</a>
      <a href="?page=<%= currentPage - 1 %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">이전</a>
  <% } %>

  <% for (int i = startPage; i <= endPage; i++) { 
       if (i == currentPage) { %>
          <span class="current"><%= i %></span>
      <% } else { %>
          <a href="?page=<%= i %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>"><%= i %></a>
      <% } 
   } %>

  <% if (currentPage < totalPages) { %>
      <a href="?page=<%= currentPage + 1 %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">다음</a>
      <a href="?page=<%= totalPages %>&searchkeyword=<%= URLEncoder.encode(userInput, "UTF-8") %>&returnnum=<%= returnnum %>">&raquo;</a>
  <% } %>
</div><%
            }
        } else {
           
           
            // 페이지 파라미터가 없을 때 (첫 번째 페이지를 불러올 때)
             offset = 0;
            query = "SELECT * FROM worknet WHERE title LIKE '%" + userInput + "%' OR company LIKE '%" + userInput + "%' OR location LIKE '%" + userInput + "%' OR sal LIKE '%" + userInput + "%' ORDER BY location LIMIT " + itemsPerPage + " OFFSET " + offset;
            comquery = "SELECT * FROM competitions WHERE title LIKE '%" + userInput + "%'  OR location LIKE '%" + userInput + "%'  ORDER BY contid DESC LIMIT " + itemsPerPage + " OFFSET " + offset;
            exquery = "SELECT * FROM externals WHERE title LIKE '%" + userInput + "%'  OR location LIKE '%" + userInput + "%'  ORDER BY extid DESC LIMIT " + itemsPerPage + " OFFSET " + offset;
       
            String countQuery = "SELECT COUNT(*) AS count FROM worknet WHERE title LIKE '%" + userInput + "%' OR company LIKE '%" + userInput + "%' OR location LIKE '%" + userInput + "%' OR sal LIKE '%" + userInput + "%'";
            countResultSet = statement.executeQuery(countQuery);
            int count = 0;
            if (countResultSet.next()) {
                count = countResultSet.getInt("count");
            }
        
        resultSet = statement.executeQuery(query);
        out.print("<div class='container'>");
        out.print("<h3><span class='user-input'>" + userInput + "</span>에 대한 검색결과입니다. <br>채용정보: " + count + " 건</h3>");
        if(count != 0 && itemsPerPage == 5 && request.getParameter("page") == null){
        out.print(" <span class='job_more' >더보기 +</span>");
        }
        while (resultSet.next()) {
        	
        	String title = resultSet.getString("title");
            String sql_company = resultSet.getString("company");
            String location = resultSet.getString("location");
            String sal = resultSet.getString("sal");
            String url = resultSet.getString("wantedInfoUrl");
            wantedAuthNo = resultSet.getString("wantedAuthNo");
            String sql_closeDt = resultSet.getString("closeDt");
            
            /* String detailPageUrl = "http://localhost:8080/Takoyaki/contents/Detail.jsp?wantedAuthNo=" + sql_wantedAuthNo; */

           
            out.print("<div><nav class=\"dblocMenu\">");
            out.print("<ul class = dbitem-list>");
            
            
            out.print("<li class= dbitem_urltitle><a href=\"javascript:void(0);\" onclick=\"jobInfoClick('"+ id + "', '" + wantedAuthNo + "', '"+ title + "', '"+ sal + "', '" + location + "', '" + url + "')\">"+ title + "</a> </li>");
            out.print("<li class= dbitem_company>" + sql_company + "</li>");
            out.print("<li class= dbitem_loc> 지역 : " + location + "</li>");
            out.print("<li class= dbitem_sal> 급여 : " + sal + "</li>");
            out.print("<li class= dbitem_close> 마감일자 : " + sql_closeDt + "</li>");
            out.print("</ul>");
            out.print("<hr class='dbhr'></nav></div>");
            
        }
        out.print("</div>");

        
        
        
        String comcountQuery = "SELECT COUNT(*) AS count FROM competitions WHERE title LIKE '%"  + userInput + "%' OR location LIKE '%" + userInput + "%'";
        comcountResultSet = statement.executeQuery(comcountQuery);
        int comcount = 0;
        if (comcountResultSet.next()) {
            comcount = comcountResultSet.getInt("count");
        }
        competitionsResultSet = statement.executeQuery(comquery);

        out.print("<div class='comcontainer'>");
        out.print("<h3><span class='user-input'>" + userInput + "</span>에 대한 검색결과입니다. <br>공모전: " + comcount + " 건</h3>");
        if(comcount != 0 && itemsPerPage == 5 && request.getParameter("page") == null){
        out.print(" <span class='com_more' >더보기 +</span>");
        }
        while (competitionsResultSet.next()) {
          String sql_comtitle = competitionsResultSet.getString("title");
            String sql_comlocation = competitionsResultSet.getString("location");
            String sql_comdate = competitionsResultSet.getString("date");
            String sql_comhref = competitionsResultSet.getString("href");
            int contid = competitionsResultSet.getInt("contid");
            
            out.print("<div><nav class=\"dbcomlocMenu\">");
            out.print("<ul class = dbcomitem-list>");
            out.print("<li class= dbcomitem_sql_comtitle><a href=\"javascript:void(0);\" onclick=\"contestClick('" + id
    				+ "', '" + contid + "', '" + sql_comtitle + "', '" + sql_comlocation + "', '" + sql_comdate + "', '"
    				+ sql_comhref + "')\">" + sql_comtitle + "</a> </li>");
            out.print("<li class= dbcomitem_sql_comlocation> 주최자 : " + sql_comlocation + "</li>");
            out.print("<li class= dbcomitem_sql_comdate> 기한 : " + sql_comdate + "</li>");
            out.print("</ul>");
            out.print("<hr class='dbhr'></nav></div>");
            
        }
        out.print("</div>");

        
        
        
        
        String excountQuery = "SELECT COUNT(*) AS count FROM externals WHERE title LIKE '%"  + userInput + "%' OR location LIKE '%" + userInput + "%'";
        excountResultSet = statement.executeQuery(excountQuery);
        int excount = 0;
        if (excountResultSet.next()) {
            excount = excountResultSet.getInt("count");
        }
       
        externalsResultSet = statement.executeQuery(exquery);


        out.print("<div class='excontainer'>");
        out.print("<h3><span class='user-input'>" + userInput + "</span>에 대한 검색결과입니다. <br>대외활동: " + excount + " 건</h3>");
        if(excount != 0 && itemsPerPage == 5 && request.getParameter("page") == null){
        out.print(" <span class='ex_more' >더보기 +</span>");
        }
        while (externalsResultSet.next()) {
          String sql_extitle = externalsResultSet.getString("title");
            String sql_exlocation = externalsResultSet.getString("location");
            String sql_exdate = externalsResultSet.getString("date");
            String sql_exhref = externalsResultSet.getString("href");
            int extid = externalsResultSet.getInt("extid");
            
            out.print("<div><nav class=\"dbexlocMenu\">");
            out.print("<ul class = dbexitem-list>");
            out.print("<li class= dbexitem_sql_comtitle><a href=\"javascript:void(0);\" onclick=\"extClick('"+ id + "', '" + extid + "', '"+ sql_extitle + "', '"+ sql_exlocation + "', '" + sql_exdate + "', '" + sql_exhref + "')\">"+ sql_extitle + "</a> </li>");
            out.print("<li class= dbexitem_sql_comlocation> 주최자 : " + sql_exlocation + "</li>");
            out.print("<li class= dbexitem_sql_comdate> 기한 : " + sql_exdate + "</li>");
            out.print("</ul>");
            out.print("<hr class='dbhr'></nav></div>");
            
        }
      
        out.print("</div>");
        }
    
        
        
        //결과 건수 불러오는 코드 만약 아래의 쿼리 셀렉문이랑 자리바꾸면 결과값이 안나옴 전달이 안되나봄 이 순서를 유지
        



        
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        try {
            // ResultSet을 먼저 닫음
            if (resultSet != null) {
                resultSet.close();
            }
            // Statement를 닫음
            if (statement != null) {
                statement.close();
            }
            // Connection을 닫음
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
   
    }
    
    else{
       %>
       <script>
   alert("검색어를 입력해주세요");
   history.back();
   </script>
       <%
    }

        
    

%>
<script>
//ajax요청
$(document).ready(function() {
    var currentPage = 1;
    var itemsPerPage = 5;
    var additionalItemsPerPage = 30;
    var returnnum = 1;
    var userInput = '<%= userInput %>'; // 서버에서 받은 검색어 값을 JavaScript 변수로 사용
    
    // 채용정보 더보기 버튼 클릭 이벤트 핸들러
    $('.job_more').click(function() {
        var offset = (currentPage - 1) * additionalItemsPerPage;
        returnnum = 1; // 채용정보 검색 타입으로 설정
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/Takoyaki/contents/search.jsp?searchkeyword=' + encodeURIComponent('<%= userInput %>'),
            data: {
                page: currentPage,
                itemsPerPage: additionalItemsPerPage,
                offset: offset,
                userInput: userInput,
                returnnum: returnnum
            },
            // 성공하면 어떤 것을 반환할지
            success: function(response) {
                $('body').html(response);
                $('.comcontainer').hide();
                $('.excontainer').hide();
                $('html, body').animate({ scrollTop: 0 }, 'fast');
                $('.job_more').hide();
            }
        });
    });

    // 공모전 정보 더보기 버튼 클릭 이벤트 핸들러
    $('.com_more').click(function() {
        var offset = (currentPage - 1) * additionalItemsPerPage;
        returnnum = 2; // 공모전 정보 검색 타입으로 설정
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/Takoyaki/contents/search.jsp?searchkeyword=' + encodeURIComponent('<%= userInput %>'),
            data: {
                page: currentPage,
                itemsPerPage: additionalItemsPerPage,
                offset: offset,
                userInput: userInput,
                returnnum: returnnum
            },
            // 성공하면 어떤 것을 반환할지
            success: function(response) {
                $('body').html(response);
                $('.container').hide();
                $('.excontainer').hide();
                $('html, body').animate({ scrollTop: 0 }, 'fast');
                $('.com_more').hide();
            }
        });
    });

    // 대외활동 정보 더보기 버튼 클릭 이벤트 핸들러
    $('.ex_more').click(function() {
        var offset = (currentPage - 1) * additionalItemsPerPage;
        returnnum = 3; // 대외활동 정보 검색 타입으로 설정
        $.ajax({
            type: 'GET',
            url: 'http://localhost:8080/Takoyaki/contents/search.jsp?searchkeyword=' + encodeURIComponent('<%= userInput %>'),
            data: {
                page: currentPage,
                itemsPerPage: additionalItemsPerPage,
                offset: offset,
                userInput: userInput,
                returnnum: returnnum
            },
            // 성공하면 어떤 것을 반환할지
            success: function(response) {
                $('body').html(response);
                $('.container').hide();
                $('.comcontainer').hide();
                $('html, body').animate({ scrollTop: 0 }, 'fast');
                $('.ex_more').hide();
            }
        });
    });
});


</script>
  
   
    <style>
   body {
   font-family: 'Noto Sans KR', sans-serif;
   }
   .tong {
	width: 50%;
	margin-left: 25%;
	margin-right: 25%;
	color: #444;
	margin-top: 2%;
}
    .dbitem-list {
        list-style: none;
        padding: 0;
        
    }
    
    .dbitem-list li {
        margin-bottom: 10px;
       
    }
    
    .dbitem a {
        color: #F59A12;
        text-decoration: none;
    }
    
    .dbitem hr {
        width: 80%; /* hr 요소의 너비를 조정합니다. */
        margin: 10px auto; /* 화면 중앙에 위치하도록 설정합니다. */
    }
    .dbitem_urltitle a {
        color: #F59A12;
        text-decoration: none; /* 이 부분은 밑줄을 없애기 위한 스타일입니다. */
    }
   
    .container { 
    width: 50%; 
    margin-left : 25%;
    margin-right : 25%;
    margin-top: 2%;
     }
     
     .container h3{ 
    width: 50%;
     }
    
   
    .user-input { 
    color: #F59A12;
    } 
    
    .dbitem_close{
    color : #B24A4A   ;
    }
    .job_more{
    display: inline-block;
    margin-left: 90%;
    border: 1.5px solid #000;
    padding: 5px 10px; 
    cursor: pointer; 
    font-size: 16px;
    width: 8%;
    border-radius: 6px;
    }
    
      .comcontainer { 
    width: 50%; 
    margin-left : 25%;
    margin-right : 25%;
   margin-top: 5%;
    
     }
     .dbcomitem-list{
     list-style: none;
        padding: 0;
     }
.dbcomitem_sql_comdate{
color : #B24A4A   ;
}    
.dbcomitem_sql_comtitle a{
        color: #F59A12;
        text-decoration: none;
}
.com_more{
    display: inline-block;
    margin-left: 90%;
    border: 1.5px solid #000;
    padding: 5px 10px; 
    cursor: pointer; 
    font-size: 16px;
    width: 8%;
    border-radius: 6px;
    }
    
      .excontainer { 
    width: 50%; 
    margin-left : 25%;
    margin-right : 25%;
   margin-top: 5%;
    
     }
    .dbexitem_sql_comdate{
color : #B24A4A   ;
}    
.dbexitem_sql_comtitle a{
        color: #F59A12;
        text-decoration: none;
}
.ex_more{
    display: inline-block;
    margin-left: 90%;
    border: 1.5px solid #000;
    padding: 5px 10px; 
    cursor: pointer; 
    font-size: 16px;
    width: 8%;
    border-radius: 6px;
    }
     .dbexitem-list{
     list-style: none;
        padding: 0;
     }
.pagination {
    text-align: center;
    margin-top: 20px;
}

.pagination span {
    margin: 0 5px;
}

.pagination a {
    text-decoration: none;
    color: #F59A12;;
    font-weight: bold;
    border: 1px solid #F59A12;;
    padding: 5px 10px;
    border-radius: 5px;
}

.pagination a.active {
    background-color: #F59A12;;
    color: white;
}

.pagination a:hover {
    background-color: #f0f0f0;
}

</style>
<%@include file="../include/footer.jsp"%>
</body>
<script src="../resources/script/jobInfoSaveDb.js?ver=1.1"></script>
<script src="../resources/script/contestSaveDb.js"></script>
<script src="../resources/script/extSaveDb.js?ver=1.1"></script>
</html>