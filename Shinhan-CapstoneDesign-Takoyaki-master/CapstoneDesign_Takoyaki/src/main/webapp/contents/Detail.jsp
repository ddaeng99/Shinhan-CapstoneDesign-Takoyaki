<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import ="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>

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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
   <link rel="stylesheet" href="../resources/css/jobinfo.css">
   <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800,900&display=swap">
  
   <link rel="shortcut icon" href="../resources/image/shortcut.png"
      type="image/x-icon" />
   <script src="https://kit.fontawesome.com/d6f64dc1ee.js"
      crossorigin="anonymous"></script>
      <script src="https://code.jquery.com/jquery-3.7.1.js" 
      integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
      
     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">

<script>
     document.addEventListener("DOMContentLoaded", function() {
    // 현재 페이지의 URL을 가져옴
    var currentURL = window.location.href;
    
    // URL에서 wantedAuthNo 파라미터를 추출
    var urlParams = new URLSearchParams(currentURL);
    var wantedAuthNo = urlParams.get('wantedAuthNo');

    // 가져온 wantedAuthNo 값을 동적으로 설정
    var linkElement = document.getElementById("favoriteLink");
    linkElement.setAttribute("data-wantedAuthNo", wantedAuthNo);
});


    </script>

      <title>문어빵</title>
</head>
<body>
   <%@include file="../include/header.jsp"%>

   <%
   String getwantedAuthNo = request.getParameter("wantedAuthNo");
   
    String apiKey = "APIKEY";
    
    String apiUrl = "http://openapi.work.go.kr/opi/opi/opia/wantedApi.do";
    String callTp = "D";
    String returnType = "XML";
    String infoSvc = "VALIDATION";
    String apiParameters = "authKey=" + apiKey + "&wantedAuthNo=" + getwantedAuthNo + "&callTp=" + callTp + "&returnType=" + returnType + "&infoSvc=" + infoSvc;
    String fullUrl = apiUrl + "?" + apiParameters;

    String corpNm = "";
    String reperNm = "";
    int totPsncnt = 0;
    int capitalAmt = 0;
    int yrSalesAmt = 0;
    String indTpCdNm = "";
    String busiCont = "";
    String corpAddr = "";
    String homePg = "";
    String busiSize = "";
    
    String jobsNm = "";
    String wantedTitle = "";
    String relJobsNm = "";
    String jobCont = "";
    String receiptCloseDt = "";
    String empTpNm = "";
    String collectPsncnt = "";
    String salTpNm = "";
    String enterTpNm = "";
    String eduNm = "";
    String forLang = "";
    String major = "";
    String certificate = "";
    String mltsvcExcHope = "";
    String compAbl = "";
    String pfCond = "";
    String etcPfCond = "";
    String selMthd = "";
    String rcptMthd = "";
    String submitDoc = "";
    String etcHopeCont = "";
    String workRegion = "";
    String nearLine = "";
    String workdayWorkhrCont = "";
    String fourIns = "";
    String retirepay = "";
    String etcWelfare = "";
    String disableCvntl = "";
    
    String attachFileUrl1= "";
    String attachFileUrl2= "";
    String srchKeywordNm= "";
    
    
    String dtlRecrContUrl = "";
    String jobsCd = "";
    String minEdubgIcd = "";
    String maxEdubgIcd = "";
    String regionCd = "";
    String empTpCd = "";
    String enterTpCd = "";
    String salTpCd = "";
    String staAreaRegionCd = "";
    String lineCd = "";
    String staNmCd = "";
    String exitNoCd = "";
    String walkDistCd = "";
    
    
    String empChargerDpt = "";
    String contactTelno = "";
    String chargerFaxNo = "";
    
    
    

    try {
        URL url = new URL(fullUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        InputStream is = conn.getInputStream();
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        Document doc = dBuilder.parse(is);

        // XML 파싱
        NodeList wantedDtlList = doc.getElementsByTagName("wantedDtl");
        NodeList corpInfoList = doc.getElementsByTagName("corpInfo");
        NodeList wantedInfoList = doc.getElementsByTagName("wantedInfo");
        NodeList empchargeInfoList = doc.getElementsByTagName("empchargeInfo");
        NodeList attachFileInfoList = doc.getElementsByTagName("attachFileInfo");
        NodeList corpAttachList = doc.getElementsByTagName("corpAttachList");
        NodeList keywordList = doc.getElementsByTagName("keywordList");

        if (wantedDtlList.getLength() > 0) {
            Node wantedDtlNode = wantedDtlList.item(0);
            if (wantedDtlNode.getNodeType() == Node.ELEMENT_NODE) {
                Element wantedDtlElement = (Element) wantedDtlNode;

                // 구인 정보 파싱
                getwantedAuthNo = wantedDtlElement.getElementsByTagName("wantedAuthNo").item(0).getTextContent();

                // 회사 정보 파싱
                Node corpInfoNode = corpInfoList.item(0);
                if (corpInfoNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element corpInfoElement = (Element) corpInfoNode;
                    corpNm = corpInfoElement.getElementsByTagName("corpNm").item(0).getTextContent();
                    reperNm = corpInfoElement.getElementsByTagName("reperNm").item(0).getTextContent();
                    indTpCdNm = corpInfoElement.getElementsByTagName("indTpCdNm").item(0).getTextContent();
                    busiCont = corpInfoElement.getElementsByTagName("busiCont").item(0).getTextContent();
                    corpAddr = corpInfoElement.getElementsByTagName("corpAddr").item(0).getTextContent();
                    homePg = corpInfoElement.getElementsByTagName("homePg").item(0).getTextContent();
                    busiSize = corpInfoElement.getElementsByTagName("busiSize").item(0).getTextContent();
                   
                    NodeList totPsncntList = corpInfoElement.getElementsByTagName("totPsncnt");
                    if (totPsncntList.getLength() > 0) {
                        Node totPsncntNode = totPsncntList.item(0);
                        String totPsncntValue = totPsncntNode.getTextContent().trim().replaceAll("[^\\d]", ""); // 숫자 이외의 문자 제거
                        totPsncnt = Integer.parseInt(totPsncntValue);
                    }

                    NodeList capitalAmtList = corpInfoElement.getElementsByTagName("capitalAmt");
                    if (capitalAmtList.getLength() > 0) {
                        Node capitalAmtNode = capitalAmtList.item(0);
                        String capitalAmtValue = capitalAmtNode.getTextContent().trim().replaceAll("[^\\d]", ""); // 숫자 이외의 문자 제거
                        capitalAmt = Integer.parseInt(capitalAmtValue);
                    }

                    NodeList yrSalesAmtList = corpInfoElement.getElementsByTagName("yrSalesAmt");
                    if (yrSalesAmtList.getLength() > 0) {
                        Node yrSalesAmtNode = yrSalesAmtList.item(0);
                        String yrSalesAmtValue = yrSalesAmtNode.getTextContent().trim().replaceAll("[^\\d]", ""); // 숫자 이외의 문자 제거
                        yrSalesAmt = Integer.parseInt(yrSalesAmtValue);
                    }

                }
                Node wantedInfoNode = wantedInfoList.item(0);
                if (wantedInfoNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element wantedInfoElement = (Element) wantedInfoNode;
                    wantedTitle = wantedInfoElement.getElementsByTagName("wantedTitle").item(0).getTextContent();
                     relJobsNm = wantedInfoElement.getElementsByTagName("relJobsNm").item(0).getTextContent();
                    jobCont = wantedInfoElement.getElementsByTagName("jobCont").item(0).getTextContent();
                    
                    receiptCloseDt = wantedInfoElement.getElementsByTagName("receiptCloseDt").item(0).getTextContent();
                    empTpNm = wantedInfoElement.getElementsByTagName("empTpNm").item(0).getTextContent();
                    collectPsncnt = wantedInfoElement.getElementsByTagName("collectPsncnt").item(0).getTextContent();
                    salTpNm = wantedInfoElement.getElementsByTagName("salTpNm").item(0).getTextContent();
                    enterTpNm = wantedInfoElement.getElementsByTagName("enterTpNm").item(0).getTextContent();
                    eduNm = wantedInfoElement.getElementsByTagName("eduNm").item(0).getTextContent();
                    forLang = wantedInfoElement.getElementsByTagName("forLang").item(0).getTextContent();
                    major = wantedInfoElement.getElementsByTagName("major").item(0).getTextContent();
                    certificate = wantedInfoElement.getElementsByTagName("certificate").item(0).getTextContent();
                    mltsvcExcHope = wantedInfoElement.getElementsByTagName("mltsvcExcHope").item(0).getTextContent();
                    compAbl = wantedInfoElement.getElementsByTagName("compAbl").item(0).getTextContent();
                    pfCond = wantedInfoElement.getElementsByTagName("pfCond").item(0).getTextContent();
                    etcPfCond = wantedInfoElement.getElementsByTagName("etcPfCond").item(0).getTextContent();
                    selMthd = wantedInfoElement.getElementsByTagName("selMthd").item(0).getTextContent();
                    rcptMthd = wantedInfoElement.getElementsByTagName("rcptMthd").item(0).getTextContent();
                    submitDoc = wantedInfoElement.getElementsByTagName("submitDoc").item(0).getTextContent();
                    etcHopeCont = wantedInfoElement.getElementsByTagName("etcHopeCont").item(0).getTextContent();
                    workRegion = wantedInfoElement.getElementsByTagName("workRegion").item(0).getTextContent();
                    nearLine = wantedInfoElement.getElementsByTagName("nearLine").item(0).getTextContent();
                    workdayWorkhrCont = wantedInfoElement.getElementsByTagName("workdayWorkhrCont").item(0).getTextContent();
                    fourIns = wantedInfoElement.getElementsByTagName("fourIns").item(0).getTextContent();
                    retirepay = wantedInfoElement.getElementsByTagName("retirepay").item(0).getTextContent();
                    etcWelfare = wantedInfoElement.getElementsByTagName("etcWelfare").item(0).getTextContent();
                    disableCvntl = wantedInfoElement.getElementsByTagName("disableCvntl").item(0).getTextContent();
                    
                    Node attachFileInfoNode = attachFileInfoList.item(0);
                    if (attachFileInfoNode.getNodeType() == Node.ELEMENT_NODE) {
                        Element attachFileInfoElement = (Element) attachFileInfoNode;
                        
                        attachFileUrl1 = attachFileInfoElement.getElementsByTagName("attachFileUrl").item(0).getTextContent();
                    }
                    Node corpAttachListNode = corpAttachList.item(0);
                    if (corpAttachListNode.getNodeType() == Node.ELEMENT_NODE) {
                        Element corpAttachElement = (Element) corpAttachListNode;
                        attachFileUrl2 = corpAttachElement.getElementsByTagName("attachFileUrl").item(0).getTextContent();
                    }
                    Node keywordListNode = keywordList.item(0);
                    if (keywordListNode.getNodeType() == Node.ELEMENT_NODE) {
                        Element keywordElement = (Element) keywordListNode;
                        srchKeywordNm = keywordElement.getElementsByTagName("srchKeywordNm").item(0).getTextContent();
                    }
                    
                     dtlRecrContUrl = wantedInfoElement.getElementsByTagName("dtlRecrContUrl").item(0).getTextContent();
                    jobsCd = wantedInfoElement.getElementsByTagName("jobsCd").item(0).getTextContent();
                    minEdubgIcd = wantedInfoElement.getElementsByTagName("minEdubgIcd").item(0).getTextContent();
                     maxEdubgIcd = wantedInfoElement.getElementsByTagName("maxEdubgIcd").item(0).getTextContent();
                     regionCd = wantedInfoElement.getElementsByTagName("regionCd").item(0).getTextContent();
                     empTpCd = wantedInfoElement.getElementsByTagName("empTpCd").item(0).getTextContent();
                     enterTpCd = wantedInfoElement.getElementsByTagName("enterTpCd").item(0).getTextContent();
                     salTpCd = wantedInfoElement.getElementsByTagName("salTpCd").item(0).getTextContent();
                     staAreaRegionCd = wantedInfoElement.getElementsByTagName("staAreaRegionCd").item(0).getTextContent();
                     lineCd = wantedInfoElement.getElementsByTagName("lineCd").item(0).getTextContent();
                     staNmCd = wantedInfoElement.getElementsByTagName("staNmCd").item(0).getTextContent();
                     exitNoCd = wantedInfoElement.getElementsByTagName("exitNoCd").item(0).getTextContent();
                     walkDistCd = wantedInfoElement.getElementsByTagName("walkDistCd").item(0).getTextContent();
                    
                    
                }
                Node empchargeInfoNode = empchargeInfoList.item(0);
                if (empchargeInfoNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element empchargeInfoElement = (Element) empchargeInfoNode;
                    
                     empChargerDpt = empchargeInfoElement.getElementsByTagName("empChargerDpt").item(0).getTextContent();
                     contactTelno = empchargeInfoElement.getElementsByTagName("contactTelno").item(0).getTextContent();
                     chargerFaxNo = empchargeInfoElement.getElementsByTagName("walkDistCd").item(0).getTextContent();
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<div class="wrap">   
   <div>
   <div>
         <div class="title_d"><%= wantedTitle %></div>
   </div>
   <hr>
   <div class="time">
      접수마감일: <%= receiptCloseDt %>
   </div>
      <div class="like">
            <script> console.log('wantedAuthNo from URL:', wantedAuthNo);</script>
         <!-- 별점을 줘보아요 -->
         
         <button id="bookmarkButton" type = "button">즐겨찾기</button>
         <div class="starbox" style="display: none;">
            <span class="star">
                ★★★★★
                <span>★★★★★</span>
                <input type="range" oninput="drawStar(this)" value="1" step="1" min="0" max="10">
            </span>
            <p id="rating-value">평가: <span id="current-rating">0</span> / 5.0</p>
            <button type="submit" id="favoriteLink" onclick="addToFavorites()">저장</button>
            <button type="button" id="cancelButton" onclick="toggleRating()">취소</button>
         </div>
      </div>
      <%
          String wantedAuthNo = request.getParameter("wantedAuthNo");
      %>
      <form id="bookmarkForm" action="saveDetail.jsp?wantedAuthNo=<%=wantedAuthNo%>" method="post">
          <input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
          <input type="hidden" name="wantedAuthNo" id="wantedAuthNo">
          <input type="hidden" name="wantedTitle" value="<%= wantedTitle %>">
          <input type="hidden" name="corpNm" value="<%= corpNm %>">
          <input type="hidden" name="regionCd" value="<%= regionCd %>">
          <input type="hidden" name="salTpNm" value="<%= salTpNm %>">
          <input type="hidden" name="jobsNm" value="<%= jobsNm %>">
          <input type="hidden" name="rating" id="rating">
       </form>
   </div>
             <div class="jiwon title">
         <img class="img" src="../resources/image/check.svg" alt="체크그림" width="25px" height="25px"  /> 
         지원자격</div>
      <div class="ji_wrap content">
         <% if (compAbl != null && !compAbl.isEmpty()) { %>
            <p>· 컴퓨터활용능력: <%= compAbl %></p>
         <% } %>
         <% if (pfCond != null && !pfCond.isEmpty()) { %>
            <p>· 우대조건: <%= pfCond %></p>
         <% } %>
         <% if (etcPfCond != null && !etcPfCond.isEmpty()) { %>
            <p>· 기타우대조건: <%= etcPfCond %></p>
         <% } %>
         <% if (enterTpNm != null && !enterTpNm.isEmpty()) { %>
            <p>· 경력조건: <%= enterTpNm %></p>
         <% } %>
         <% if (eduNm != null && !eduNm.isEmpty()) { %>
            <p>· 학력: <%= eduNm %></p>
         <% } %>
         <% if (forLang != null && !forLang.isEmpty()) { %>
            <p>· 외국어: <%= forLang %></p>
         <% } %>
         <% if (major != null && !major.isEmpty()) { %>
            <p>· 전공: <%= major %></p>
         <% } %>
         <% if (certificate != null && !certificate.isEmpty()) { %>
            <p>· 자격면허: <%= certificate %></p>
         <% } %>
         <% if (mltsvcExcHope != null && !mltsvcExcHope.isEmpty()) { %>
            <p>· 병역특례채용희망: <%= mltsvcExcHope %></p>
         <% } %>
         <% if (selMthd != null && !selMthd.isEmpty()) { %>
            <p>· 전형방법: <%= selMthd %></p>
         <% } %>
      </div>
         
         <div>
            <div class="jogeon title">
         <img class="img" src="../resources/image/check.svg" alt="체크그림" width="25px" height="25px"  /> 
         근무조건</div>
      <div class="jo_wrap content">
         <% if (jobsNm != null && !jobsNm.isEmpty()) { %>
            <p>· 모집집종: <%= jobsNm %></p>
         <% } %>
         <% if (relJobsNm != null && !relJobsNm.isEmpty()) { %>
            <p>· 관련직종: <%= relJobsNm %></p>
         <% } %>
         <% if (jobCont != null && !jobCont.isEmpty()) { %>
            <p>· 직무내용: <%= jobCont %></p>
         <% } %>
         <% if (empTpNm != null && !empTpNm.isEmpty()) { %>
            <p>· 고용형태: <%= empTpNm %></p>
         <% } %>
         <% if (collectPsncnt != null && !collectPsncnt.isEmpty()) { %>
            <p>· 모집인원: <%= collectPsncnt %></p>
         <% } %>
         <% if (salTpNm != null && !salTpNm.isEmpty()) { %>
            <p>· 임금조건: <%= salTpNm %></p>
         <% } %>
      </div>
         </div>
         <div>
         <div>
             <div class="geunmu title">
         <img class="img" src="../resources/image/check.svg" alt="체크그림" width="25px" height="25px"   /> 
         근무환경</div>
      <div class="geun_wrap content">
         <% if (workRegion != null && !workRegion.isEmpty()) { %>
            <p>· 근무예정지: <%= workRegion %></p>
         <% } %>
         <% if (nearLine != null && !nearLine.isEmpty()) { %>
            <p>· 인근전철역: <%= nearLine %></p>
         <% } %>
         <% if (workdayWorkhrCont != null && !workdayWorkhrCont.isEmpty()) { %>
            <p>· 근무시간/형태: <%= workdayWorkhrCont %></p>
         <% } %>
         <% if (fourIns != null && !fourIns.isEmpty()) { %>
            <p>· 연금4대 보험: <%= fourIns %></p>
         <% } %>
         <% if (retirepay != null && !retirepay.isEmpty()) { %>
            <p>· 퇴직금: <%= retirepay %></p>
         <% } %>
         <% if (etcWelfare != null && !etcWelfare.isEmpty()) { %>
            <p>· 기타복리후생: <%= etcWelfare %></p>
         <% } %>
      </div>
   </div>
   <div>
       <div class="gieop">
          <img class="img" src="../resources/image/check.svg" alt="체크그림" width="20px" height="20px"  /> 
       기업정보</div>
       <div class="gi_wrap ">
         <table class ="table"> 
            <tr class="table_row">
               <td class="gray">회사명:</td>
                 <td> <%= corpNm %></td>
               <td class="gray">대표자명:</td>
               <td><%= reperNm %></td>
            </tr>
            <tr class="table_row">
               <td class="gray">회사규모: </td>
                 <td> <%= busiSize %></td>
               <td class="gray">근로자수:</td>
               <td><%= totPsncnt %></td>
            </tr>
             <tr class="table_list"> 
                 <td class="gray">연매출액 </td>
                 <td> <%= yrSalesAmt %></td>
                 <td class="gray">업종:</td>
               <td><%= indTpCdNm %></td>
              </tr>
               <tr class="table_list"> 
                 <td class="gray">회사주소 </td>
                 <td colspan="3"> <%= corpAddr %></td>
              </tr>
            <tr>
                <td class="gray">회사홈페이지:</td>
                  <td colspan="3"><a id="companyLink" href="<%
                  if (homePg.startsWith("http://") || homePg.startsWith("https://")) {
                      out.print(homePg);
                  } else if (homePg.startsWith("http:/")) {
                      out.print("http://" + homePg.substring(6));
                  } else {
                      out.print("http://" + homePg);
                  }
              %>" target="_blank"><%= homePg %></a>
                </td>
              </tr>
         </table>
         
      </div>
   </div>
   <%@include file="../include/footer.jsp"%>
     <script>
     window.onload = function() {
          var link = document.querySelector('#companyLink');
          if (link) {
              if (!link.href.startsWith('http') && !link.href.startsWith('https')) {
                  link.href = 'http://' + link.textContent;
              }
          }
      };
    </script>
</body>

</html>

<script>
document.addEventListener("DOMContentLoaded", function() {
   var wantedAuthNo = '<%= wantedAuthNo %>'
    var currentURL = window.location.href;
    var wantedAuthNo = urlParams.get('wantedAuthNo');
   
    var title = urlParams.get('title');
    var company = urlParams.get('company');
    var location = urlParams.get('location');
    var sal = urlParams.get('sal');
    var occupation = urlParams.get('occupation');
    
    document.getElementById("wantedAuthNo").value = wantedAuthNo;
    document.getElementById("title").value = title;
    document.getElementById("company").value = company;
    document.getElementById("location").value = location;
    document.getElementById("sal").value = sal;
    document.getElementById("occupation").value = occupation;
});

let currentRating = 0;
let ratingEnabled = false;

   function drawStar(input) {
       var value = input.value;
       document.querySelector('.star span').style.width = ((value / 10) * 100) + '%';
       currentRating = (value / 2).toFixed(1);
       document.getElementById('current-rating').textContent = currentRating;
   }
   function addToFavorites() {
       var form = document.getElementById('bookmarkForm');
       var rating = document.getElementById('rating');

    rating.value = currentRating;

    var xhr = new XMLHttpRequest();
    xhr.open(form.method, form.action);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            alert('즐겨찾기에 저장되었습니다!');
        } else if (xhr.readyState === 4) {
            alert('즐겨찾기 저장에 실패하였습니다. 다시 시도해주세요.');
        }
    };

    var formData = new FormData(form);
    var encodedData = new URLSearchParams(formData).toString();
    xhr.send(encodedData);

    return false;
}
   function toggleRating() {
       var starbox = document.querySelector('.starbox');
       var bookmarkButton = document.getElementById('bookmarkButton');
       
       if (starbox.style.display === 'none') {
           starbox.style.display = 'block';
           bookmarkButton.style.display = 'none'; // 즐겨찾기 버튼 숨기기
       } else {
           starbox.style.display = 'block';
           bookmarkButton.style.display = 'block'; // 즐겨찾기 버튼 보이기
       }
   }
   document.getElementById('bookmarkForm').addEventListener('submit', function(event) {
       var wantedAuthNo = document.getElementById('wantedAuthNo').value;
       console.log('wantedAuthNo at form submit:', wantedAuthNo);
});

   var isLoggedIn = <%= (request.getSession().getAttribute("id") != null) ? "true" : "false" %>;

   document.getElementById('bookmarkButton').addEventListener('click', function() {
    if (!isLoggedIn) {
        alert('로그인을 하세요!');
        window.location.href = "http://localhost:8080/Takoyaki/login/login.jsp";
        return false; // 이벤트 전파 막기
    }

    var starbox = document.querySelector('.starbox');
    if (starbox.style.display === 'none') {
        starbox.style.display = 'block';
        ratingEnabled = true;
    } else {
        var form = document.getElementById('bookmarkForm');
        var rating = document.getElementById('rating');

        rating.value = currentRating;

        starbox.style.display = 'none';
        ratingEnabled = false;
    }

    return false; // 이벤트 전파 막기
});


   document.getElementById('cancelButton').addEventListener('click', function() {
       var starbox = document.querySelector('.starbox');
       starbox.style.display = 'none';
       ratingEnabled = false;
   
       return false; 
   });


</script>
    <style>
   #favoriteLink, #cancelButton {
    position: relative;
    border: none;
    display: inline-block;
    padding: 10px 20px;
    border-radius: 10px;
    font-family: "paybooc-Light", sans-serif;
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
    background-color: #F59A12;
    color: aliceblue;
    font-size: 0.8em;
   }

   #favoriteLink:hover, #cancelButton:hover {
       background-color: aliceblue;
       color: #F59A12;
   } 
   
    #bookmarkButton { position: relative;
    border: none;
    display: inline-block;
    padding: 15px 30px;
    border-radius: 15px;
    font-family: "paybooc-Light", sans-serif;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
    background-color: #F59A12;
    color: aliceblue;
   }
   #bookmarkButton-outline {
       position: relative;
       padding: 15px 30px;
       border-radius: 15px;
       font-family: "paybooc-Light", sans-serif;
       box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
       text-decoration: none;
       font-weight: 600;
       transition: 0.25s;
       border: 3px solid #F59A12;
       color: #F59A12;aliceblue
   }
    .wrap{
       width : 90%;
       margin : Auto;
    }
    .time{
    
    }
    .like{
       float: right;
    }
    .img{
       white-space : nowrap;
    }
    .title_d{
       font-size : 27px;
       text-align : center;
        font-weight: bold;
        margin : 50px; 
    }
    .title{
     font-size : 20px;
       font-weight: 600;
       margin : 30px; 
    }
    .gieop{
    font-size : 20px;
       font-weight: 600;
       margin : 30px; 
    }
    .content{
       width : 90%;
       margin: Auto;
    }
    .table{
         font-size : 17px;
    }
    .table>td{
       height : 50px;
    }
   .gray{
       color :gray;
    }
    .gi_wrap{
       border : solid 1px;
       width : 55%;
       margin-left : 50px;
       padding :20px 50px;
       border-radius : 0.5rem;
    }
    .star {
        position: relative;
        font-size: 4rem;
        color: #ddd;
    }

    .star input {
        width: 100%;
        height: 100%;
        position: absolute;
        left: 0;
        opacity: 0;
        cursor: pointer;
    }

    .star span {
        width: 0;
        position: absolute;
        left: 0;
        color: #F59A12;
        overflow: hidden;
        pointer-events: none;
    }
    
    .navbar_menu .nav_jobinfo {
      color: #F59A12;
   }
   </style>