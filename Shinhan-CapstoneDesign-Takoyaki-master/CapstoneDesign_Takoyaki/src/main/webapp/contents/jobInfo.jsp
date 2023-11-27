<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
   rel="stylesheet">

<link rel="stylesheet" href="../resources/css/jobinfo.css?ver=1.1">
<link rel="shortcut icon" href="../resources/image/shortcut.png"
   type="image/x-icon" />

<script src="https://kit.fontawesome.com/d6f64dc1ee.js"
   crossorigin="anonymous"></script>

<style>
#RegionS, #EducationS, #CorporateS {
    display: none;
}
</style>

<title>문어빵</title>

</head>
<style>
/* 근무 지역 라벨 스타일 */
.dropdown-label {
   font-size: 18px;
   font-weight: bold;
}


/* 드롭다운 스타일 */
.drpTop {
   margin-left: 15%;
   box-sizing: border-box;
   width: 10%;
   float: left;
}
/* 드롭다운 선택 박스 스타일 */
.dropdown select {
   padding: 10px;
   border: 2px solid #ccc;
   border-radius: 5px;
   background-color: #fff;
   font-size: 16px;
   outline: none;
   transition: border-color 0.3s;
}

.dropdown select:focus {
   border-color: #F59A12; /* 포커스 시 더 강조된 스타일 */
}

.area {
   display: flex;
   margin-left: 20%;
   margin-bottom : 50px;
}

 /*학력별 스타일*/
/* 근무 지역 라벨 스타일 */
.ed {
   text-align: center; /* 오른쪽 정렬 설정 */
   margin-right: 35px; /* 오른쪽 여백 설정 */
   font-size: 18px;
   font-weight: bold;
   margin-bottom: 10px;
}

/* 드롭다운 선택 박스 스타일 */
.ed:focus {
   border-color: #007bff; /* 포커스 시 더 강조된 스타일 */
}
#searchButton2{
   margin-left: 280px;
   margin-top : 30px;
}

#grade label {
color: #666;
font-family: 'Noto Sans KR', sans-serif;
font-weight: 600;
}
#CorporateS label {
color: #666;
font-family: 'Noto Sans KR', sans-serif;
font-weight: 600;
}
.area label {
color: #666;
font-family: 'Noto Sans KR', sans-serif;
font-weight: 600;
}
/*기업별 스타일*/
.coTp {
   text-align: center; /* 오른쪽 정렬 설정 */
   margin-right: 20px;
}
/* 근무 지역 라벨 스타일 */
.coTp {
   font-size: 18px;
   font-weight: bold;
   margin-bottom: 10px;
}

#EducationS{
   
   font-size: 18px;
   font-weight: bold;
   margin-bottom: 60px;
}
.grade>label{
   height : 60px;
   width : 220px;
}
.corp{
   padding : 0px 180px;
}
.corp>label{
   height : 60px;
   width : 220px;
}
#hiddenval2{
   margin-left : 100px 0px 0px 0px;
}

#hiddenval3{
   margin : 70px 0px 0px 100px;
}

.select{
   margin-top : 80px;
}

</style>
<body>

   <%@include file="../include/header.jsp"%>
   
   <nav class="jobMenu">
      <ul class="jobCategory">
         <li id="RegionSClick" onclick="RegionClick"><a
            href="http://localhost:8080/Takoyaki/contents/jobInfo.jsp">지역별</a></li>
         <li id="EducationSClick" onclick="EducationClick"><a
            href="javascript:void(0);">학력별</a></li>
         <li id="CorporateSClick" onclick="CorporateClick"><a
            href="javascript:void(0);">기업별</a></li>
      </ul>
   </nav>
   <!-- 지역(대분류) 드롭다운 카테고리 -->
   <div class="drpTop">
      <div class="dropdown">
         <select id="RegionS" onchange="showMenu()">
            <option value="default" selected>지역 선택</option>
            <option value="all">전국</option>
            <option value="seoul">서울</option>
            <option value="gyeonggi">경기</option>
            <option value="incheon">인천</option>
            <option value="daejeon">대전</option>
            <option value="sejong">세종</option>
            <option value="chungnam">충남</option>
            <option value="chungbuk">충북</option>
            <option value="gwangju">광주</option>
            <option value="jeonnam">전남</option>
            <option value="jeonbuk">전북</option>
            <option value="daegu">대구</option>
            <option value="gyeongbuk">경북</option>
            <option value="busan">부산</option>
            <option value="ulsan">울산</option>
            <option value="gyeongnam">경남</option>
            <option value="gangwon">강원</option>
            <option value="jeju">제주</option>



         </select>
      </div>
   </div>
   <div class="area">
      <div id="allAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='allArea' value=''
            onclick='selectAll(this)'>전체</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="seoulAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='seoulArea' value='전체'
            onclick="selectAll(this, 'seoulArea')">전체</label> <label><input
            type="checkbox" name="seoulArea" value="11680"
            onclick="onCheckboxChange(this)">서울 강남구</label> <label><input
            type="checkbox" name="seoulArea" value="11740"
            onclick="onCheckboxChange(this)">서울 강동구</label> <label><input
            type="checkbox" name="seoulArea" value="11305"
            onclick="onCheckboxChange(this)">서울 강북구</label> <label><input
            type="checkbox" name="seoulArea" value="11500"
            onclick="onCheckboxChange(this)">서울 강서구</label> <label><input
            type="checkbox" name="seoulArea" value="11620"
            onclick="onCheckboxChange(this)">서울 관악구</label> <label><input
            type="checkbox" name="seoulArea" value="11215"
            onclick="onCheckboxChange(this)">서울 광진구</label> <label><input
            type="checkbox" name="seoulArea" value="11530"
            onclick="onCheckboxChange(this)">서울 구로구</label> <label><input
            type="checkbox" name="seoulArea" value="11545"
            onclick="onCheckboxChange(this)">서울 금천구</label> <label><input
            type="checkbox" name="seoulArea" value="11350"
            onclick="onCheckboxChange(this)">서울 노원구</label> <label><input
            type="checkbox" name="seoulArea" value="11320"
            onclick="onCheckboxChange(this)">서울 도봉구</label> <label><input
            type="checkbox" name="seoulArea" value="11230"
            onclick="onCheckboxChange(this)">서울 동대문구</label> <label><input
            type="checkbox" name="seoulArea" value="11590"
            onclick="onCheckboxChange(this)">서울 동작구</label> <label><input
            type="checkbox" name="seoulArea" value="11440"
            onclick="onCheckboxChange(this)">서울 마포구</label> <label><input
            type="checkbox" name="seoulArea" value="11410"
            onclick="onCheckboxChange(this)">서울 서대문구</label> <label><input
            type="checkbox" name="seoulArea" value="11650"
            onclick="onCheckboxChange(this)">서울 서초구</label> <label><input
            type="checkbox" name="seoulArea" value="11200"
            onclick="onCheckboxChange(this)">서울 성동구</label> <label><input
            type="checkbox" name="seoulArea" value="11290"
            onclick="onCheckboxChange(this)">서울 성북구</label> <label><input
            type="checkbox" name="seoulArea" value="11710"
            onclick="onCheckboxChange(this)">서울 송파구</label> <label><input
            type="checkbox" name="seoulArea" value="11470"
            onclick="onCheckboxChange(this)">서울 양천구</label> <label><input
            type="checkbox" name="seoulArea" value="11560"
            onclick="onCheckboxChange(this)">서울 영등포구</label> <label><input
            type="checkbox" name="seoulArea" value="11170"
            onclick="onCheckboxChange(this)">서울 용산구</label> <label><input
            type="checkbox" name="seoulArea" value="11380"
            onclick="onCheckboxChange(this)">서울 은평구</label> <label><input
            type="checkbox" name="seoulArea" value="11110"
            onclick="onCheckboxChange(this)">서울 종로구</label><label><input
            type="checkbox" name="seoulArea" value="11140"
            onclick="onCheckboxChange(this)">서울 중구</label> <label><input
            type="checkbox" name="seoulArea" value="11260"
            onclick="onCheckboxChange(this)">서울 중랑구</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>


      <div id="gyeonggiAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='gyeonggiArea' value='전체'
            onclick="selectAll(this, 'gyeonggiArea')">전체</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41820"
            onclick="onCheckboxChange(this)">경기 가평군</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41280"
            onclick="onCheckboxChange(this)">경기 고양시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41285"
            onclick="onCheckboxChange(this)">경기 고양시 일산동구</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41287"
            onclick="onCheckboxChange(this)">경기 고양시 일산서구</label> <br> <label><input
            type="checkbox" name="gyeonggiArea" value="41290"
            onclick="onCheckboxChange(this)">경기 과천시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41610"
            onclick="onCheckboxChange(this)">경기 광주시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41310"
            onclick="onCheckboxChange(this)">경기 구리시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41410"
            onclick="onCheckboxChange(this)">경기 군포시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41360"
            onclick="onCheckboxChange(this)">경기 남양주시</label> <br> <label><input
            type="checkbox" name="gyeonggiArea" value="41250"
            onclick="onCheckboxChange(this)">경기 동두천시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41190"
            onclick="onCheckboxChange(this)">경기 부천시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41135"
            onclick="onCheckboxChange(this)">경기 성남시 분당구</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41131"
            onclick="onCheckboxChange(this)">경기 성남시 수정구</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41133"
            onclick="onCheckboxChange(this)">경기 성남시 중원구</label> <br> <label><input
            type="checkbox" name="gyeonggiArea" value="41113"
            onclick="onCheckboxChange(this)">경기 수원시 권선구</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41117"
            onclick="onCheckboxChange(this)">경기 수원시 영통구</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41111"
            onclick="onCheckboxChange(this)">경기 수원시 장안구</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41390"
            onclick="onCheckboxChange(this)">경기 시흥시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41270"
            onclick="onCheckboxChange(this)">경기 안산시</label> <br> <label><input
            type="checkbox" name="gyeonggiArea" value="41273"
            onclick="onCheckboxChange(this)">경기 안산시 단원구</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41550"
            onclick="onCheckboxChange(this)">경기 안성시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41170"
            onclick="onCheckboxChange(this)">경기 안양시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41173"
            onclick="onCheckboxChange(this)">경기 안양시 동안구</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41630"
            onclick="onCheckboxChange(this)">경기 양주시</label> <br> <label><input
            type="checkbox" name="gyeonggiArea" value="41830"
            onclick="onCheckboxChange(this)">경기 양평군</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41670"
            onclick="onCheckboxChange(this)">경기 여주시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41370"
            onclick="onCheckboxChange(this)">경기 오산시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41460"
            onclick="onCheckboxChange(this)">경기 용인시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41463"
            onclick="onCheckboxChange(this)">경기 용인시 기흥구</label> <br> <label><input
            type="checkbox" name="gyeonggiArea" value="41461"
            onclick="onCheckboxChange(this)">경기 용인시 처인구</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41430"
            onclick="onCheckboxChange(this)">경기 의왕시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41150"
            onclick="onCheckboxChange(this)">경기 의정부시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41480"
            onclick="onCheckboxChange(this)">경기 파주시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41220"
            onclick="onCheckboxChange(this)">경기 평택시</label> <br> <label><input
            type="checkbox" name="gyeonggiArea" value="41650"
            onclick="onCheckboxChange(this)">경기 포천시</label> <label><input
            type="checkbox" name="gyeonggiArea" value="41590"
            onclick="onCheckboxChange(this)">경기 화성시</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>


      <div id="incheonAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='incheonArea' value='전체'
            onclick="selectAll(this, 'incheonArea')">전체</label> <label><input
            type="checkbox" name="incheonArea" value="28710"
            onclick="onCheckboxChange(this)">인천 강화군</label> <label><input
            type="checkbox" name="incheonArea" value="28245"
            onclick="onCheckboxChange(this)">인천 계양구</label> <label><input
            type="checkbox" name="incheonArea" value="28140"
            onclick="onCheckboxChange(this)">인천 동구</label> <label><input
            type="checkbox" name="incheonArea" value="28177"
            onclick="onCheckboxChange(this)">인천 미추홀구</label> <br> <label><input
            type="checkbox" name="incheonArea" value="28237"
            onclick="onCheckboxChange(this)">인천 부평구</label> <label><input
            type="checkbox" name="incheonArea" value="28185"
            onclick="onCheckboxChange(this)">인천 연수구</label> <label><input
            type="checkbox" name="incheonArea" value="28720"
            onclick="onCheckboxChange(this)">인천 옹진군</label> <label><input
            type="checkbox" name="incheonArea" value="28110"
            onclick="onCheckboxChange(this)">인천 중구</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="daejeonAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='daejeonArea' value='전체'
            onclick="selectAll(this, 'daejeonArea')">전체</label> <label><input
            type="checkbox" name="daejeonArea" value="30230"
            onclick="onCheckboxChange(this)">대전 대덕구</label> <label><input
            type="checkbox" name="daejeonArea" value="30110"
            onclick="onCheckboxChange(this)">대전 동구</label> <label><input
            type="checkbox" name="daejeonArea" value="30200"
            onclick="onCheckboxChange(this)">대전 유성구</label> <label><input
            type="checkbox" name="daejeonArea" value="30140"
            onclick="onCheckboxChange(this)">대전 중구</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="sejongAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='sejongArea' value='36110'
            onclick="onCheckboxChange(this)">전체</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="chungnamAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='chungnamArea' value='전체'
            onclick="selectAll(this, 'chungnamArea')">전체</label> <label><input
            type="checkbox" name="chungnamArea" value="44250"
            onclick="onCheckboxChange(this)">충남 계룡시</label> <label><input
            type="checkbox" name="chungnamArea" value="44150"
            onclick="onCheckboxChange(this)">충남 공주시</label> <label><input
            type="checkbox" name="chungnamArea" value="44230"
            onclick="onCheckboxChange(this)">충남 논산시</label> <label><input
            type="checkbox" name="chungnamArea" value="44270"
            onclick="onCheckboxChange(this)">충남 당진시</label> <br> <label><input
            type="checkbox" name="chungnamArea" value="44180"
            onclick="onCheckboxChange(this)">충남 보령시</label> <label><input
            type="checkbox" name="chungnamArea" value="44210"
            onclick="onCheckboxChange(this)">충남 서산시</label> <label><input
            type="checkbox" name="chungnamArea" value="44770"
            onclick="onCheckboxChange(this)">충남 서천군</label> <label><input
            type="checkbox" name="chungnamArea" value="44200"
            onclick="onCheckboxChange(this)">충남 아산시</label> <label><input
            type="checkbox" name="chungnamArea" value="44130"
            onclick="onCheckboxChange(this)">충남 천안시</label> <br> <label><input
            type="checkbox" name="chungnamArea" value="44131"
            onclick="onCheckboxChange(this)">충남 천안시 동남구</label> <label><input
            type="checkbox" name="chungnamArea" value="44133"
            onclick="onCheckboxChange(this)">충남 천안시 서북구</label> <label><input
            type="checkbox" name="chungnamArea" value="44825"
            onclick="onCheckboxChange(this)">충남 태안군</label> <label><input
            type="checkbox" name="chungnamArea" value="44800"
            onclick="onCheckboxChange(this)">충남 홍성군</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="chungbukAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='chungbukArea' value='전체'
            onclick="selectAll(this, 'chungbukArea')">전체</label> <label><input
            type="checkbox" name="chungbukArea" value="43760"
            onclick="onCheckboxChange(this)">충북 괴산군</label> <label><input
            type="checkbox" name="chungbukArea" value="43800"
            onclick="onCheckboxChange(this)">충북 단양군</label> <label><input
            type="checkbox" name="chungbukArea" value="43740"
            onclick="onCheckboxChange(this)">충북 영동군</label> <label><input
            type="checkbox" name="chungbukArea" value="43730"
            onclick="onCheckboxChange(this)">충북 옥천군</label> <br> <label><input
            type="checkbox" name="chungbukArea" value="43770"
            onclick="onCheckboxChange(this)">충북 음성군</label> <label><input
            type="checkbox" name="chungbukArea" value="43745"
            onclick="onCheckboxChange(this)">충북 증평군</label> <label><input
            type="checkbox" name="chungbukArea" value="43750"
            onclick="onCheckboxChange(this)">충북 진천군</label> <label><input
            type="checkbox" name="chungbukArea" value="43110"
            onclick="onCheckboxChange(this)">충북 청주시</label> <label><input
            type="checkbox" name="chungbukArea" value="43112"
            onclick="onCheckboxChange(this)">충북 청주시 서원구</label> <br> <label><input
            type="checkbox" name="chungbukArea" value="43114"
            onclick="onCheckboxChange(this)">충북 청주시 청원구</label> <label><input
            type="checkbox" name="chungbukArea" value="43113"
            onclick="onCheckboxChange(this)">충북 청주시 흥덕구</label>
         <form id="hiddenval">
            <!--  버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="gwangjuAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='gwangjuArea' value='전체'
            onclick="selectAll(this, 'gwangjuArea')">전체</label> <label><input
            type="checkbox" name="gwangjuArea" value="29200"
            onclick="onCheckboxChange(this)">광주 광산구</label> <label><input
            type="checkbox" name="gwangjuArea" value="29155"
            onclick="onCheckboxChange(this)">광주 남구</label> <label><input
            type="checkbox" name="gwangjuArea" value="29170"
            onclick="onCheckboxChange(this)">광주 북구</label> <label><input
            type="checkbox" name="gwangjuArea" value="29140"
            onclick="onCheckboxChange(this)">광주 서구</label>
         <form id="hiddenval">
            <!--  버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="jeonnamAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='jeonnamArea' value='전체'
            onclick="selectAll(this, 'jeonnamArea')">전체</label> <label><input
            type="checkbox" name="jeonnamArea" value="46810"
            onclick="onCheckboxChange(this)">전남 강진군</label> <label><input
            type="checkbox" name="jeonnamArea" value="46770"
            onclick="onCheckboxChange(this)">전남 고흥군</label> <label><input
            type="checkbox" name="jeonnamArea" value="46230"
            onclick="onCheckboxChange(this)">전남 광양시</label> <label><input
            type="checkbox" name="jeonnamArea" value="46730"
            onclick="onCheckboxChange(this)">전남 구례군</label> <br> <label><input
            type="checkbox" name="jeonnamArea" value="46170"
            onclick="onCheckboxChange(this)">전남 나주시</label> <label><input
            type="checkbox" name="jeonnamArea" value="46110"
            onclick="onCheckboxChange(this)">전남 목포시</label> <label><input
            type="checkbox" name="jeonnamArea" value="46840"
            onclick="onCheckboxChange(this)">전남 무안군</label> <label><input
            type="checkbox" name="jeonnamArea" value="46780"
            onclick="onCheckboxChange(this)">전남 보성군</label> <label><input
            type="checkbox" name="jeonnamArea" value="46910"
            onclick="onCheckboxChange(this)">전남 신안군</label> <br> <label><input
            type="checkbox" name="jeonnamArea" value="46130"
            onclick="onCheckboxChange(this)">전남 여수시</label> <label><input
            type="checkbox" name="jeonnamArea" value="46870"
            onclick="onCheckboxChange(this)">전남 영광군</label> <label><input
            type="checkbox" name="jeonnamArea" value="46890"
            onclick="onCheckboxChange(this)">전남 완도군</label> <label><input
            type="checkbox" name="jeonnamArea" value="46880"
            onclick="onCheckboxChange(this)">전남 장성군</label> <label><input
            type="checkbox" name="jeonnamArea" value="46800"
            onclick="onCheckboxChange(this)">전남 장흥군</label> <br> <label><input
            type="checkbox" name="jeonnamArea" value="46860"
            onclick="onCheckboxChange(this)">전남 함평군</label> <label><input
            type="checkbox" name="jeonnamArea" value="46820"
            onclick="onCheckboxChange(this)">전남 해남군</label> <label><input
            type="checkbox" name="jeonnamArea" value="46790"
            onclick="onCheckboxChange(this)">전남 화순군</label>
         <form id="hiddenval">
            <!--  버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="jeonbukAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='jeonbukArea' value='전체'
            onclick="selectAll(this, 'jeonbukArea')">전체</label> <label><input
            type="checkbox" name="jeonbukArea" value="45790"
            onclick="onCheckboxChange(this)">전북 고창군</label> <label><input
            type="checkbox" name="jeonbukArea" value="45130"
            onclick="onCheckboxChange(this)">전북 군산시</label> <label><input
            type="checkbox" name="jeonbukArea" value="45190"
            onclick="onCheckboxChange(this)">전북 남원시</label> <label><input
            type="checkbox" name="jeonbukArea" value="45730"
            onclick="onCheckboxChange(this)">전북 무주군</label> <br> <label><input
            type="checkbox" name="jeonbukArea" value="45800"
            onclick="onCheckboxChange(this)">전북 부안군</label> <label><input
            type="checkbox" name="jeonbukArea" value="45710"
            onclick="onCheckboxChange(this)">전북 완주군</label> <label><input
            type="checkbox" name="jeonbukArea" value="45140"
            onclick="onCheckboxChange(this)">전북 익산시</label> <label><input
            type="checkbox" name="jeonbukArea" value="45750"
            onclick="onCheckboxChange(this)">전북 임실군</label> <label><input
            type="checkbox" name="jeonbukArea" value="45110"
            onclick="onCheckboxChange(this)">전북 전주시</label> <br> <label><input
            type="checkbox" name="jeonbukArea" value="45113"
            onclick="onCheckboxChange(this)">전북 전주시 덕진구</label> <label><input
            type="checkbox" name="jeonbukArea" value="45111"
            onclick="onCheckboxChange(this)">전북 전주시 완산구</label> <label><input
            type="checkbox" name="jeonbukArea" value="45720"
            onclick="onCheckboxChange(this)">전북 진안군</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="daeguAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='daeguArea' value='전체'
            onclick="selectAll(this, 'daeguArea')">전체</label> <label><input
            type="checkbox" name="daeguArea" value="27720"
            onclick="onCheckboxChange(this)">대구 군위군</label> <label><input
            type="checkbox" name="daeguArea" value="27200"
            onclick="onCheckboxChange(this)">대구 남구</label> <label><input
            type="checkbox" name="daeguArea" value="27710"
            onclick="onCheckboxChange(this)">대구 달성군</label> <label><input
            type="checkbox" name="daeguArea" value="27140"
            onclick="onCheckboxChange(this)">대구 동구</label> <br> <label><input
            type="checkbox" name="daeguArea" value="27230"
            onclick="onCheckboxChange(this)">대구 북구</label> <label><input
            type="checkbox" name="daeguArea" value="27260"
            onclick="onCheckboxChange(this)">대구 수성구</label> <label><input
            type="checkbox" name="daeguArea" value="27110"
            onclick="onCheckboxChange(this)">대구 중구</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="gyeongbukAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='gyeongbukArea' value='전체'
            onclick="selectAll(this, 'gyeongbukArea')">전체</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47290"
            onclick="onCheckboxChange(this)">경북 경산시</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47130"
            onclick="onCheckboxChange(this)">경북 경주시</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47190"
            onclick="onCheckboxChange(this)">경북 구미시</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47150"
            onclick="onCheckboxChange(this)">경북 김천시</label> <br> <label><input
            type="checkbox" name="gyeongbukArea" value="47280"
            onclick="onCheckboxChange(this)">경북 문경시</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47250"
            onclick="onCheckboxChange(this)">경북 상주시</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47840"
            onclick="onCheckboxChange(this)">경북 성주군</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47170"
            onclick="onCheckboxChange(this)">경북 안동시</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47760"
            onclick="onCheckboxChange(this)">경북 영양군</label> <br> <label><input
            type="checkbox" name="gyeongbukArea" value="47210"
            onclick="onCheckboxChange(this)">경북 영주시</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47230"
            onclick="onCheckboxChange(this)">경북 영천시</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47940"
            onclick="onCheckboxChange(this)">경북 울릉군</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47930"
            onclick="onCheckboxChange(this)">경북 울진군</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47730"
            onclick="onCheckboxChange(this)">경북 의성군</label> <br> <label><input
            type="checkbox" name="gyeongbukArea" value="47750"
            onclick="onCheckboxChange(this)">경북 청송군</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47850"
            onclick="onCheckboxChange(this)">경북 칠곡군</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47110"
            onclick="onCheckboxChange(this)">경북 포항시</label> <label><input
            type="checkbox" name="gyeongbukArea" value="47113"
            onclick="onCheckboxChange(this)">경북 포항시 북구</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="busanAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='busanArea' value='전체'
            onclick="selectAll(this, 'busanArea')">전체</label> <label><input
            type="checkbox" name="busanArea" value="26440"
            onclick="onCheckboxChange(this)">부산 강서구</label> <label><input
            type="checkbox" name="busanArea" value="26410"
            onclick="onCheckboxChange(this)">부산 금정구</label> <label><input
            type="checkbox" name="busanArea" value="26290"
            onclick="onCheckboxChange(this)">부산 남구</label> <label><input
            type="checkbox" name="busanArea" value="26170"
            onclick="onCheckboxChange(this)">부산 동구</label> <br> <label><input
            type="checkbox" name="busanArea" value="26260"
            onclick="onCheckboxChange(this)">부산 동래구</label> <label><input
            type="checkbox" name="busanArea" value="26320"
            onclick="onCheckboxChange(this)">부산 북구</label> <label><input
            type="checkbox" name="busanArea" value="26530"
            onclick="onCheckboxChange(this)">부산 사상구</label> <label><input
            type="checkbox" name="busanArea" value="26380"
            onclick="onCheckboxChange(this)">부산 사하구</label> <label><input
            type="checkbox" name="busanArea" value="26500"
            onclick="onCheckboxChange(this)">부산 수영구</label> <br> <label><input
            type="checkbox" name="busanArea" value="26470"
            onclick="onCheckboxChange(this)">부산 연제구</label> <label><input
            type="checkbox" name="busanArea" value="26200"
            onclick="onCheckboxChange(this)">부산 영도구</label> <label><input
            type="checkbox" name="busanArea" value="26350"
            onclick="onCheckboxChange(this)">부산 해운대구</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="ulsanAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='ulsanArea' value='전체'
            onclick="selectAll(this, 'ulsanArea')">전체</label> <label><input
            type="checkbox" name="ulsanArea" value="31140"
            onclick="onCheckboxChange(this)">울산 남구</label> <label><input
            type="checkbox" name="ulsanArea" value="31170"
            onclick="onCheckboxChange(this)">울산 동구</label> <label><input
            type="checkbox" name="ulsanArea" value="31710"
            onclick="onCheckboxChange(this)">울산 울주군</label> <label><input
            type="checkbox" name="ulsanArea" value="31110"
            onclick="onCheckboxChange(this)">울산 중구</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="gyeongnamAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='gyeongnamArea' value='전체'
            onclick="selectAll(this, 'gyeongnamArea')">전체</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48310"
            onclick="onCheckboxChange(this)">경남 거제시</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48880"
            onclick="onCheckboxChange(this)">경남 거창군</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48250"
            onclick="onCheckboxChange(this)">경남 김해시</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48840"
            onclick="onCheckboxChange(this)">경남 남해군</label> <br> <label><input
            type="checkbox" name="gyeongnamArea" value="48270"
            onclick="onCheckboxChange(this)">경남 밀양시</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48860"
            onclick="onCheckboxChange(this)">경남 산청군</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48330"
            onclick="onCheckboxChange(this)">경남 양산시</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48720"
            onclick="onCheckboxChange(this)">경남 의령군</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48740"
            onclick="onCheckboxChange(this)">경남 창녕군</label> <br> <label><input
            type="checkbox" name="gyeongnamArea" value="48120"
            onclick="onCheckboxChange(this)">경남 창원시</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48125"
            onclick="onCheckboxChange(this)">경남 창원 마산합포구</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48123"
            onclick="onCheckboxChange(this)">경남 창원 성산구</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48121"
            onclick="onCheckboxChange(this)">경남 창원 의창구</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48129"
            onclick="onCheckboxChange(this)">경남 창원 진해구</label> <br> <label><input
            type="checkbox" name="gyeongnamArea" value="48850"
            onclick="onCheckboxChange(this)">경남 하동군</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48730"
            onclick="onCheckboxChange(this)">경남 함안군</label> <label><input
            type="checkbox" name="gyeongnamArea" value="48870"
            onclick="onCheckboxChange(this)">경남 함양군</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="gangwonAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='gangwonArea' value='전체'
            onclick="selectAll(this, 'gangwonArea')">전체</label> <label><input
            type="checkbox" name="gangwonArea" value="51150"
            onclick="onCheckboxChange(this)">강원 강릉시</label> <label><input
            type="checkbox" name="gangwonArea" value="51820"
            onclick="onCheckboxChange(this)">강원 고성군</label> <label><input
            type="checkbox" name="gangwonArea" value="51230"
            onclick="onCheckboxChange(this)">강원 삼척시</label> <label><input
            type="checkbox" name="gangwonArea" value="51210"
            onclick="onCheckboxChange(this)">강원 속초시</label> <br> <label><input
            type="checkbox" name="gangwonArea" value="51800"
            onclick="onCheckboxChange(this)">강원 양구군</label> <label><input
            type="checkbox" name="gangwonArea" value="51750"
            onclick="onCheckboxChange(this)">강원 영월군</label> <label><input
            type="checkbox" name="gangwonArea" value="51130"
            onclick="onCheckboxChange(this)">강원 원주시</label> <label><input
            type="checkbox" name="gangwonArea" value="51810"
            onclick="onCheckboxChange(this)">강원 인제군</label> <label><input
            type="checkbox" name="gangwonArea" value="51780"
            onclick="onCheckboxChange(this)">강원 철원군</label> <br> <label><input
            type="checkbox" name="gangwonArea" value="51110"
            onclick="onCheckboxChange(this)">강원 춘천시</label> <label><input
            type="checkbox" name="gangwonArea" value="51190"
            onclick="onCheckboxChange(this)">강원 태백시</label> <label><input
            type="checkbox" name="gangwonArea" value="51720"
            onclick="onCheckboxChange(this)">강원 홍천군</label> <label><input
            type="checkbox" name="gangwonArea" value="51790"
            onclick="onCheckboxChange(this)">강원 화천군</label> <label><input
            type="checkbox" name="gangwonArea" value="51730"
            onclick="onCheckboxChange(this)">강원 횡성군</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>

      <div id="jejuAreas" style="display: none" class="areaDiv">
         <label><input type='checkbox' name='jejuArea' value='전체'
            onclick="selectAll(this, 'jejuArea')">전체</label> <label><input
            type="checkbox" name="jejuArea" value="50130"
            onclick="onCheckboxChange(this)">제주 서귀포시</label> <label><input
            type="checkbox" name="jejuArea" value="50110"
            onclick="onCheckboxChange(this)">제주 제주시</label>
         <form id="hiddenval">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton" value="검 색" onclick="search()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedRegionsInput"
               name="selectedRegions" value="" />
         </form>
      </div>



   </div>

   <script>
      //지역(대분류) 체크박스에 대한 값
      function showMenu() {
         var selectedValue = document.getElementById("RegionS").value;
         var allAreaDivs = document.querySelectorAll(".areaDiv");

         for (var i = 0; i < allAreaDivs.length; i++) {
            allAreaDivs[i].style.display = "none"; // 모든 지역 div 요소를 숨김
         }

         if (selectedValue !== 'default') {
            console.log(selectedValue);
            document.getElementById(selectedValue + "Areas").style.display = "block"; // 선택한 지역의 div 요소를 보이도록 설정
         }
      }
      //지역(대분류) 선택 후 지역(소분류)에서 전체 체크박스 클릭시
      function selectAll(checkbox, areaName) {
         var areaCheckboxes = document.querySelectorAll("input[name='"
               + areaName + "']");
         var checkedCheckboxes = [];

         for (var i = 0; i < areaCheckboxes.length; i++) {
            areaCheckboxes[i].checked = checkbox.checked;
            if (areaCheckboxes[i].checked
                  && areaCheckboxes[i].value !== '전체') {
               checkedCheckboxes.push(areaCheckboxes[i].value);
            }
         }
         if (selectAll.checked) {
            console.log("전체 체크박스가 선택되었습니다.");
         } else {
            console.log("전체 체크박스가 해제되었습니다.");
         }
         // 선택된 모든 체크박스를 콘솔에 출력
         console.log("선택된 체크박스들: " + checkedCheckboxes.join(", "));
      }
      //체크박스 변경사항
      function onCheckboxChange(checkbox) {
         if (checkbox.checked) {
            console.log(checkbox.value + " 체크박스가 선택되었습니다.");
         } else {
            console.log(checkbox.value + " 체크박스가 해제되었습니다.");
         }
      }
   </script>

   <div id="EducationS" class=ed>
      <div id="grade">
         	<label><input
            type="checkbox" name="Education" value="00"
            onclick="onCheckboxChange2(this)">학력무관</label> <label><input
            type="checkbox" name="Education" value="01"
            onclick="onCheckboxChange2(this)">초졸이하</label> <label><input
            type="checkbox" name="Education" value="02"
            onclick="onCheckboxChange2(this)">중졸</label> <label><input
            type="checkbox" name="Education" value="03"
            onclick="onCheckboxChange2(this)">고졸</label><br><label><input
            type="checkbox" name="Education" value="04"
            onclick="onCheckboxChange2(this)">대졸(2~3년)</label> <label><input
            type="checkbox" name="Education" value="05"
            onclick="onCheckboxChange2(this)">대졸(4년)</label> <label><input
            type="checkbox" name="Education" value="06"
            onclick="onCheckboxChange2(this)">석사</label> <label><input
            type="checkbox" name="Education" value="07"
            onclick="onCheckboxChange2(this)">박사</label><br>
             <label><input type='checkbox' id='selectAll2'
            onclick='selectAllCheckboxes2()'>전체</label> 
         <form id="hiddenval2">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton2" value="검 색"
               onclick="search2()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedEducationsInput"
               name="selectedEducations" value="" />
         </form>

      </div>
   </div>
   <script>
      //학력별에 대한 전체 클릭시
      function selectAllCheckboxes2() {
         var selectAllCheckbox2 = document.getElementById("selectAll2");
         var checkboxes = document.getElementsByName("Education");
         var checkedCheckboxes = [];

         for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = selectAllCheckbox2.checked;
            if (checkboxes[i].checked) {
               checkedCheckboxes.push(checkboxes[i].value);
            }
         }

         // 전체 체크박스 상태를 확인하고 콘솔에 로그 출력
         console.log("전체 체크박스가 선택되었습니다.");

         console.log("선택된 체크박스들: " + checkedCheckboxes.join(", "));
      }

      // 개별 체크박스에 대한 이벤트 핸들러
      function onCheckboxChange2(checkbox2) {
         if (checkbox2.checked) {
            console.log(checkbox2.value + " 체크박스가 선택되었습니다.");
         } else {
            console.log(checkbox2.value + " 체크박스가 해제되었습니다.");
         }
      }
   </script>

   <div id="CorporateS" class=coTp>
      <div class="dropdown-label corp">
           <label><input type="checkbox" name="Corporate type" value="01"
            onclick="onCheckboxChange3(this)">대기업</label> <label><input
            type="checkbox" name="Corporate type" value="03"
            onclick="onCheckboxChange3(this)">벤처기업</label> <label><input
            type="checkbox" name="Corporate type" value="04"
            onclick="onCheckboxChange3(this)">공공기관</label> <label><input
            type="checkbox" name="Corporate type" value="05"
            onclick="onCheckboxChange3(this)">외국계기업</label> <label><input
            type="checkbox" name="Corporate type" value="09"
            onclick="onCheckboxChange3(this)">청년친화강소기업</label>
            <label><input type='checkbox' name="Corporate type"
            id='selectAllcheck3' onclick='selectAll3()'>전체</label>
         <form id="hiddenval3">
            <!-- 검 색 버튼을 눌렀을 때 search() 함수 호출 -->
            <input type="button" id="searchButton3" value="검 색"
               onclick="search3()">
            <!-- 선택된 지역 값을 담을 hidden input 엘리먼트 -->
            <input type="hidden" id="selectedCoTpsInput" name="selectedCoTps"
               value="" />
         </form>


      </div>
   </div>
   <script>
      //기업별에 대한 전체 클릭시
      function selectAll3() {
         var selectAll3 = document.getElementById("selectAllcheck3");
         var checkboxes = document.getElementsByName("Corporate type");
         var checkedCheckboxes = [];

         for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = selectAll3.checked;
            if (checkboxes[i].checked && checkboxes[i].value !== "on") {
               checkedCheckboxes.push(checkboxes[i].value);
            }
         }

         // 전체 체크박스 상태를 확인하고 콘솔에 로그 출력
         if (selectAll3.checked) {
            console.log("전체 체크박스가 선택되었습니다.");
         } else {
            console.log("전체 체크박스가 해제되었습니다.");
         }

         // 선택된 모든 체크박스를 콘솔에 출력
         console.log("선택된 체크박스들: " + checkedCheckboxes.join(", "));
      }

      // 개별 체크박스에 대한 이벤트 핸들러
      function onCheckboxChange3(checkbox) {
         if (checkbox.checked) {
            console.log(checkbox.value + " 체크박스가 선택되었습니다.");
         } else {
            console.log(checkbox.value + " 체크박스가 해제되었습니다.");
         }
      }
   </script>

   <script>
      //지역, 학력, 기업별 클릭시 서로 안보이게 하는 스크립트
      //hideElementsWithPattern("Areas");를 넣는이유 대분류는 안보이지만 소분류 체크박스들은 보여서
      document
            .addEventListener(
                  "DOMContentLoaded",
                  function() {

                     // 초기에는 학력별과 기업별을 숨김
                     document.getElementById("RegionS").style.display = "block";
                     document.getElementById("EducationS").style.display = "none";
                     document.getElementById("CorporateS").style.display = "none";

                     // 클릭 이벤트 핸들러 설정
                     document.getElementById("RegionSClick").onclick = RegionClick;
                     document.getElementById("EducationSClick").onclick = EducationClick;
                     document.getElementById("CorporateSClick").onclick = CorporateClick;

                     function RegionClick() {
                        // 지역별을 클릭했을 때
                        document.getElementById("RegionS").style.display = "block";
                        document.getElementById("EducationS").style.display = "none";
                        document.getElementById("CorporateS").style.display = "none";
                        // 모든 Areas로 끝나는 요소를 숨김
                        hideElementsWithPattern("Areas");
                     }

                     function EducationClick() {
                        // 학력별을 클릭했을 때
                        document.getElementById("RegionS").style.display = "none";
                        document.getElementById("EducationS").style.display = "block";
                        document.getElementById("CorporateS").style.display = "none";
                        // 모든 Areas로 끝나는 요소를 숨김
                        hideElementsWithPattern("Areas");
                     }

                     function CorporateClick() {
                        // 기업별을 클릭했을 때
                        document.getElementById("RegionS").style.display = "none";
                        document.getElementById("EducationS").style.display = "none";
                        document.getElementById("CorporateS").style.display = "block";
                        // 모든 Areas로 끝나는 요소를 숨김
                        hideElementsWithPattern("Areas");
                     }

                     // 모든 요소를 숨기는 함수
                     function hideElementsWithPattern(pattern) {
                        var elements = document
                              .querySelectorAll("[id$=" + pattern
                                    + "]");
                        for (var i = 0; i < elements.length; i++) {
                           elements[i].style.display = "none";
                        }
                     }
                  });
   </script>
   <script>
      //지역별 체크박스 값 받아오는 함수
      function getSelectedRegions(checkboxes) {
         var selectedRegions = [];
         for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked && checkboxes[i].value !== '전체') {
               selectedRegions.push(checkboxes[i].value);
            }
         }
         return selectedRegions;
      }
      //지역별에서 검 색 버튼을 클릭시
      function search() {
         var regions = [ document.getElementsByName("seoulArea"),
               document.getElementsByName("gyeonggiArea"),
               document.getElementsByName("incheonArea"),
               document.getElementsByName("daejeonArea"),
               document.getElementsByName("sejongArea"),
               document.getElementsByName("chungnamArea"),
               document.getElementsByName("chungbukArea"),
               document.getElementsByName("gwangjuArea"),
               document.getElementsByName("jeonnamArea"),
               document.getElementsByName("jeonbukArea"),
               document.getElementsByName("daeguArea"),
               document.getElementsByName("gyeongbukArea"),
               document.getElementsByName("busanArea"),
               document.getElementsByName("ulsanArea"),
               document.getElementsByName("gyeongnamArea"),
               document.getElementsByName("gangwonArea"),
               document.getElementsByName("JejuArea"),
               document.getElementsByName("allArea"), ];
         //선택된 체크박스 값들을 히든을 사용해서 jsp서버로 보냄 (ajax도 사용가능 하지만 ajax를 사용시 cors 위배 이유는 클라이언트에서 바로 워크넷서버로 전송해서)
         //우리는 클라이언트 값 받아서 jsp서버에 보내고 jsp서버에서 워크넷 서버로 api값 요청(이렇게 하는이유는 서버끼리의 통신은 cors위배가 안됨) 
         var selectedRegions = [];
         regions.forEach(function(checkboxes) {
            selectedRegions = selectedRegions
                  .concat(getSelectedRegions(checkboxes));
         });

         var region = selectedRegions.join("|");
         document.getElementById("selectedRegionsInput").value = region;

         console.log("선택된 지역: " + region);

         var form = document.getElementById("hiddenval");
         form.submit();
         if (selectedRegions.length === 0) {
            console.log("선택된 값이 없습니다.");
         }
      }
   </script>
   <script>
      //학력별 체크박스값 받아오는 함수
      function getSelectedEducations(checkboxes) {
         var selectedEducations = [];
         for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked && checkboxes[i].value !== '전체') {
               selectedEducations.push(checkboxes[i].value);
            }
         }
         return selectedEducations;
      }
      //학력별에서 검 색버튼 클릭시
      function search2() {
         var educations = [ document.getElementsByName("Education"), ];

         var selectedEducations = [];
         educations.forEach(function(checkboxes) {
            selectedEducations = selectedEducations
                  .concat(getSelectedEducations(checkboxes));
         });

         var education = selectedEducations.join("|");
         document.getElementById("selectedEducationsInput").value = education;

         console.log("선택된 지역: " + education);

         var form = document.getElementById("hiddenval2");
         form.submit();
         if (selectedEducations.length === 0) {
            console.log("선택된 값이 없습니다.");
         }
      }
   </script>

   <script>
      //기업별 체크박스값 받아오는 함수
      function getSelectedCoTps(checkboxes) {
         var selectedCoTps = [];
         for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked && checkboxes[i].value !== '전체') {
               selectedCoTps.push(checkboxes[i].value);
            }
         }
         return selectedCoTps;
      }
      //기업별에서 검 색 클릭시
      function search3() {
         var coTps = [ document.getElementsByName("Corporate type"), ];

         var selectedCoTps = [];
         coTps.forEach(function(checkboxes) {
            selectedCoTps = selectedCoTps
                  .concat(getSelectedCoTps(checkboxes));
         });

         var coTp = selectedCoTps.join("|");
         document.getElementById("selectedCoTpsInput").value = coTp;

         console.log("선택된 지역: " + coTp);

         var form = document.getElementById("hiddenval3");
         form.submit();
         if (selectedCoTps.length === 0) {
            console.log("선택된 값이 없습니다.");
         }
      }
   </script>
   <div class="jobGroup">
      <div class="select1" style="text-align: center;">
         <nav class="locMenu">
            <ul class="item-list1">
               <li class="item1">공고제목</li>
               <li class="item1">회사</li>
               <li class="item1">지역</li>
               <li class="item1">급여</li>
               <li class="item1">마감일자</li>
            </ul>
         </nav>
      </div>
      <hr>
   </div>

   <!-- 원하는 위치에 하이퍼링크를 생성합니다. -->


   <%
   // 1. API 키를 저장합니다.

   String apiKey = "APIKEY";

   // 2. API 요청을 위한 URL을 생성합니다.
   String apiUrl = "http://openapi.work.go.kr/opi/opi/opia/wantedApi.do";
   String callTp = "L"; // 일반 채용정보 조회
   String returnType = "XML";
   String display = "30";
   String pageNumberParam = request.getParameter("pageNumber");
   String displayParam = request.getParameter("display");
   
   int total = 0; // 기본적으로 총 건수를 0으로 초기화합니다.
   int totalPages = 1;
   int currentPage = 1; // 기본적으로 1페이지로 설정
   int startPage = 1;
   int itemsPerPage = 30; //총건수에서 몇개씩 자를건지 display와 맞춰야함
   if (pageNumberParam != null && !pageNumberParam.isEmpty()) {
      currentPage = Integer.parseInt(pageNumberParam);
      // startPage는 한 번 계산된 후에는 고정된 값으로 사용
      startPage = (currentPage - 1) + 1;
   }

   String startPageString = String.valueOf(startPage);

   //직업 카테고리 it로 한정
   String occupation = "132001|132002|132003|133100|133101|133102|133200|133201|133202|133203|133204|133205|133206|133207|133300|133301|133302|133900|134100|134101|134102|134103|134200|134301|134302|134303|134400|134900|135000|135001|214200|214201|214202|415500|415501|415502|415503|415504|415505";
   //지역 선택 안되면 전체값받아옴

   String[] selectedRegions = request.getParameterValues("selectedRegions");
   String[] selectedEducations = request.getParameterValues("selectedEducations");
   String[] selectedCoTps = request.getParameterValues("selectedCoTps");

   String region = "";
   String education = "";
   String coTp = "";

   if (selectedRegions != null && selectedRegions.length > 0) {
      region = String.join("|", selectedRegions);
   }

   if (selectedEducations != null && selectedEducations.length > 0) {
      education = String.join("|", selectedEducations);
   }

   if (selectedCoTps != null && selectedCoTps.length > 0) {
      coTp = String.join("|", selectedCoTps);
   }

   // 기존의 API 파라미터와 함께 region 파라미터를 추가하여 API 호출 URL을 생성합니다.
   String apiParameters = "authKey=" + apiKey + "&callTp=" + callTp + "&returnType=" + returnType + "&startPage="
         + startPageString + "&display=" + display + "&occupation=" + occupation + "&region=" + region + "&education="
         + education + "&coTp=" + coTp;
   String fullUrl = apiUrl + "?" + apiParameters;
   // 변수를 선언
   String title = "";
   String company = "";
   String location = "";
   String salary = "";
   String wantedInfoUrl = "";
   String closeDt = "";
   String wantedAuthNo = "";

   try {
      // 3. HTTP 요청을 보내고 XML 데이터를 가져옴
      URL url = new URL(fullUrl);
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("GET");

      InputStream is = conn.getInputStream();
      DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
      DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
      Document doc = dBuilder.parse(is);

      // 4. XML 파싱 
      NodeList wantedList = doc.getElementsByTagName("wanted");
      NodeList wantedRootList = doc.getElementsByTagName("wantedRoot");

      if (wantedRootList.getLength() > 0) {
         Node wantedRootNode = wantedRootList.item(0);
         if (wantedRootNode.getNodeType() == Node.ELEMENT_NODE) {
      Element wantedRootElement = (Element) wantedRootNode;
      NodeList totalList = wantedRootElement.getElementsByTagName("total");

      if (totalList.getLength() > 0) {
         Node totalNode = totalList.item(0);
         String totalValue = totalNode.getTextContent();
         total = Integer.parseInt(totalValue);

         totalPages = (int) Math.ceil((double) total / itemsPerPage);
         // 채용 정보 출력
         for (int i = 0; i < wantedList.getLength(); i++) {
            Node wantedNode = wantedList.item(i);
            if (wantedNode.getNodeType() == Node.ELEMENT_NODE) {
               Element wantedElement = (Element) wantedNode;
               
               List<String> validJobCodes = Arrays.asList("132001", "132002", "132003", "133100", "133101", "133102", "133200", "133201", "133202", "133203", "133204", "133205", "133206", "133207", "133300", "133301", "133302", "133900", "134100", "134101", "134102", "134103", "134200", "134301", "134302", "134303", "134400", "134900", "135000", "135001", "214200", "214201", "214202", "415500", "415501", "415502", "415503", "415504", "415505");
                    String jobsCdString = wantedElement.getElementsByTagName("jobsCd").item(0).getTextContent();
                    int jobsCd = Integer.parseInt(jobsCdString);
                    
                    if (validJobCodes.contains(jobsCdString)) {
               title = wantedElement.getElementsByTagName("title").item(0).getTextContent();
               company = wantedElement.getElementsByTagName("company").item(0).getTextContent();
               location = wantedElement.getElementsByTagName("region").item(0).getTextContent();
               salary = wantedElement.getElementsByTagName("sal").item(0).getTextContent();
               wantedInfoUrl = wantedElement.getElementsByTagName("wantedInfoUrl").item(0).getTextContent();
               closeDt = wantedElement.getElementsByTagName("closeDt").item(0).getTextContent();
               wantedAuthNo = wantedElement.getElementsByTagName("wantedAuthNo").item(0).getTextContent();
               // 검 색어가 없을 경우 모든 구인 정보 출력
               out.print("<div><nav class=\"locMenu1\">");
               out.print("<ul class=\"item-list\">");
               out.print("<li class=\"item\"><a href=\"javascript:void(0);\" onclick=\"jobInfoClick('"+ id + "', '" + wantedAuthNo + "', '"+ title + "', '"+ salary + "', '" + location + "', '" + wantedInfoUrl + "')\">"+ title + "</a> </li>");
               out.print("<li class=\"item\">" + company + "</li>");
               out.print("<li class=\"item\">" + location + "</li>");
               out.print("<li class=\"item\">" + salary + "</li>");
               out.print("<li class=\"item\"><h3 class = \"clseDt\"> "+closeDt+"</h3></li>");
               out.print("</ul>");
               out.print("<hr></nav></div>");

            }
         }
         }
      } else {
         out.println("총 건수 정보가 없습니다.");
      }
         } else {
      out.println("wantedRoot 정보가 없습니다.");
         }
      } else {
         out.println("wantedRoot 정보가 없습니다.");
      }

      is.close();
   } catch (Exception e) {
      e.printStackTrace();
   }
   %>
   <!-- 페이지네이션 + 지역 학력 기업을 선택했을떄 초기화하지않고 그값을 계속 가지고 검 색 만약 3개중 다른것을 누를땐 초기화 -->
   <div class="pagination">
      <%
      if (totalPages > 0) {
         // 이전 페이지로 가는 링크
         if (currentPage > 1) {
            String prevPageUrl = "?pageNumber=" + (currentPage - 1) + "&display=" + itemsPerPage + "&selectedRegions="
            + URLEncoder.encode(region, "UTF-8") + "&selectedEducations=" + URLEncoder.encode(education, "UTF-8")
            + "&selectedCoTps=" + URLEncoder.encode(coTp, "UTF-8");
      %>
      <span><a href="<%=prevPageUrl%>">이전</a></span>
      <%
      }

      // 현재 페이지 주변의 페이지 번호 표시
      for (int i = Math.max(1, currentPage - 2); i <= Math.min(currentPage + 2, totalPages); i++) {
      String pageUrl = "?pageNumber=" + i + "&display=" + itemsPerPage + "&selectedRegions="
            + URLEncoder.encode(region, "UTF-8") + "&selectedEducations=" + URLEncoder.encode(education, "UTF-8")
            + "&selectedCoTps=" + URLEncoder.encode(coTp, "UTF-8");
      %>
      <span><a href="<%=pageUrl%>"
         <%=(i == currentPage) ? "class='active'" : ""%>><%=i%></a></span>
      <%
      }

      // 다음 페이지로 가는 링크
      if (currentPage < totalPages) {
      String nextPageUrl = "?pageNumber=" + (currentPage + 1) + "&display=" + itemsPerPage + "&selectedRegions="
            + URLEncoder.encode(region, "UTF-8") + "&selectedEducations=" + URLEncoder.encode(education, "UTF-8")
            + "&selectedCoTps=" + URLEncoder.encode(coTp, "UTF-8");
      %>
      <span><a href="<%=nextPageUrl%>">다음</a></span>
      <%
      }
      }
      %>
   </div>
	<script>
	//여기부터 밑에 스타일까지 지역별,학력별,기업별 선택했을때 불 들어오는거
	var activeMenuItem = null;

	  function setActiveMenuItem(menuItem) {
	    if (activeMenuItem) {
	      activeMenuItem.classList.remove('active');
	    }
	    menuItem.classList.add('active');
	    activeMenuItem = menuItem;
	  }
	  
	  window.addEventListener('load', function() {
		    var regionMenuItem = document.getElementById('RegionSClick');
		    setActiveMenuItem(regionMenuItem);
		  });
	  document.getElementById('RegionSClick').addEventListener('click', function () {
	    setActiveMenuItem(this);
	  });
	  document.getElementById('EducationSClick').addEventListener('click', function () {
	    setActiveMenuItem(this);
	  });
	  document.getElementById('CorporateSClick').addEventListener('click', function () {
	    setActiveMenuItem(this);
	  });
</script>


   <style>
.jobCategory li {
  list-style: none;
  display: inline-block;
  margin-right: 20px;
}

.jobCategory a {
  text-decoration: none;
}

/* 강조된(클릭된) 메뉴 항목 스타일 */
.jobCategory li.active a {
  color: #F59A12; 
  font-weight: bold; 
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
	color: #F59A12;
	font-weight: bold;
	border: 1.5px solid #F59A12;
	padding: 5px 10px;
	border-radius: 5px;
}

.pagination a.active {
	background-color: #F59A12;
	color: white;
}

.pagination a:hover {
	background-color: #ebe9e9;
	color: #F59A12;
}
</style>
   <%@include file="../include/footer.jsp"%>
</body>
<script src="../resources/script/jobInfoSaveDb.js?ver=1.1"></script>
</html>