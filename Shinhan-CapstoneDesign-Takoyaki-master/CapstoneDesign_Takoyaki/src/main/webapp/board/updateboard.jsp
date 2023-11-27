<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "bbs.bbs" %>
<%@ page import = "bbs.bbsDAO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=, initial-scale=1.0">
    <title>문어빵 게시판 글</title>
</head>
<body>

<%@include file="../include/header.jsp"%>
<% 
id = null;
if (session.getAttribute("id") !=null) {
   id = (String) session.getAttribute("id");
}
   if (id == null){
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('로그인을 하세요.')");
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
      }
   %>
    <div class ="container">
      <div class ="row">
      <form method="post" action="../board/updateAction.jsp?bbsID=<%= bbsID %>">
      <table class ="table"> 
            <thead>
               <tr class="title_s">
                  <th class="title" colspan="2">문어빵 글쓰기</th>
               </tr>
            </thead>
            <tbody>
               <tr class = "write_title">
                  <td><input type = "text" class ="write" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= Bbs.getBbsTitle()%>"> </td>
               </tr>
               <tr>
                  <td><textarea class ="content" placeholder="글 내용" name="bbsContent" maxlength="2048" style = "height: 500px; width : 1100px"><%= Bbs.getBbsContent()%> </textarea> </td>
               </tr>
            </tbody>
       </table>
       <div class = "submit_write">
       <input type ="submit" class="btn btn-primary pull -right" value="수정">
       </div>
      </form>               
      </div>
   </div>
   <style>
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