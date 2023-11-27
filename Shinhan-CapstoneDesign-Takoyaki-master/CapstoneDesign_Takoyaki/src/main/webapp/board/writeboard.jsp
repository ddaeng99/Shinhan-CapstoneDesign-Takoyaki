<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<title>문어빵 게시판 글</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">


<link rel="shortcut icon" href="../resources/image/shortcut.png"
	type="image/x-icon" />


<script src="https://kit.fontawesome.com/d6f64dc1ee.js"
	crossorigin="anonymous"></script>
</head>
<%@include file="../include/header.jsp"%>
<%
id = null;
if (session.getAttribute("id") !=null) {
   id = (String) session.getAttribute("id");
}
%>
    <div class ="container">
      <div class ="row">
         <form method="post" action="writeAction.jsp">
            <table class ="table"> 
                  <thead>
                     <tr class="title_s">
                        <th class="title" colspan="2">문어빵 글쓰기</th><!-- 수정 -->
                     </tr>
                  </thead>
                  <tbody>
                     <tr class = "write_title">
                        <td><input type = "text" class ="write" placeholder=" 제목을 입력하세요" name="bbsTitle" maxlength="50" > </td>
                     </tr>
                     <tr class = "write_content">
                        <td><textarea class ="content" placeholder=" 내용을 입력하세요" name="bbsContent" maxlength="2048" style = "height: 500px; width : 1100px;"> </textarea> </td>
                     </tr>
                  </tbody>
             </table>
          <div  class="submit_write">
             <input type ="submit" class="btn btn-primary pull -right" value="작성">
          </div>
         </form>
         
      
      </div>
   </div>
   <style>
     .navbar_menu .nav_bbs {
		color: #F59A12;
		}
      .submit_write{
         display: inline-block;
      }
      .btn-primary{
         float: right;
         text-align:center;
         width :80px;
         height: 40px;
         font-size : 18px;
         border : 1px solid #fff;
         border-radius: 8px;
         font-family: 'Noto Sans KR', sans-serif;
         cursor: pointer;
         color : #fff;
         background-color : #F59A12; 
      }      
      
      .btn-primary:hover{
         color : #F59A12;
          background-color: white;
          border : 1px solid #999999;
      }

         
      .write{
         width: 1100px;
         height: 50px;
         text-align: left;
         font-size: 20px;
         font-family: 'Noto Sans KR', sans-serif;
         
      }
      .title{
         text-align: center;
         font-size: 20px;
         font-family: 'Noto Sans KR', sans-serif;
      
      }
      .title_s{
         margin-top : 20px;
      }
      .container{
         width: 100%;
         padding: 0 10%
      }
      .content{
         width: 1100px;
         height: 500px;
         font-size: 18px;
         font-family: 'Noto Sans KR', sans-serif;
      }
      
   </style>
</body>
</html>