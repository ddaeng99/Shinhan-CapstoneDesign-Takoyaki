<%@page import="mainDB.External"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%@ page import="mainDB.MainDB"%>
<%@ page import="mainDB.Competition"%>

<%
class JobData {
	private String title; // 직무 제목
	private String company; // 회사 이름
	private String regDt; // 등록 날짜
	private String closeDt; // 등록 날짜
	private String wantedInfoUrl; // 채용 정보 URL
	private String wantedAuthNo;

	public JobData(String title, String company, String closeDt, String regDt, String wantedInfoUrl, String wantedAuthNo) {
		this.title = title;
		this.company = company;
		this.closeDt = closeDt;
		this.regDt = regDt;
		this.wantedInfoUrl = wantedInfoUrl;
		this.wantedAuthNo = wantedAuthNo;
	}

	public String getTitle() {
		return title;
	}

	public String getCompany() {
		return company;
	}

	public String getRegDt() {
		return regDt;
	}

}

List<JobData> jobDataList = new ArrayList<>(); // jobDataList 선언

String apiKey = "APIKEY"; // API 키
String apiUrl = "http://openapi.work.go.kr/opi/opi/opia/wantedApi.do"; // API 엔드포인트 URL
String callTp = "L"; // 일반 채용정보 조회
String returnType = "XML"; // 결과 형식
String display = "30"; // 한 페이지당 표시할 항목 수
String pageNumberParam = request.getParameter("pageNumber"); // 요청 페이지 번호
String displayParam = request.getParameter("display"); // 표시할 항목 수

int total = 3; // 표시할 총 항목 수
int totalPages = 1; // 총 페이지 수
int currentPage = 1; // 현재 페이지
int startPage = 1; // 시작 페이지
int itemsPerPage = 30; // 한 페이지당 아이템 수

String title = ""; // 직무 제목
String company = ""; // 회사 이름
String regDt = ""; // 등록 날짜
String closeDt = ""; // 마감 날짜
String wantedInfoUrl = "";
String wantedAuthNo = "";
String detailPageUrl = "";

if (pageNumberParam != null && !pageNumberParam.isEmpty()) {
	currentPage = Integer.parseInt(pageNumberParam);
	startPage = (currentPage - 1) * itemsPerPage + 1;
}

String startPageString = String.valueOf(startPage);
String occupation = "132001|132002|132003|133100|133101|133102|133200|133201|133202|133203|133204|133205|133206|133207|133300|133301|133302|133900|134100|134101|134102|134103|134200|134301|134302|134303|134400|134900|135000|135001|214200|214201|214202|415500|415501|415502|415503|415504|415505";

// 나머지 변수 정의 및 URL 생성
String apiParameters = "authKey=" + apiKey + "&callTp=" + callTp + "&returnType=" + returnType + "&startPage="
		+ startPageString + "&display=" + display + "&occupation=" + occupation;

String fullUrl = apiUrl + "?" + apiParameters;

try {
	URL url = new URL(fullUrl);
	HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	conn.setRequestMethod("GET");

	InputStream is = conn.getInputStream();
	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
	Document doc = dBuilder.parse(is);

	NodeList wantedList = doc.getElementsByTagName("wanted"); // "wanted" 태그의 목록 가져오기

	// 데이터 추출 및 리스트에 저장
	for (int i = 0; i < wantedList.getLength(); i++) {
		Node wantedNode = wantedList.item(i);
		if (wantedNode.getNodeType() == Node.ELEMENT_NODE) {
			Element wantedElement = (Element) wantedNode;

			title = wantedElement.getElementsByTagName("title").item(0).getTextContent();
			company = wantedElement.getElementsByTagName("company").item(0).getTextContent();
			regDt = wantedElement.getElementsByTagName("regDt").item(0).getTextContent();
			closeDt = wantedElement.getElementsByTagName("closeDt").item(0).getTextContent();
			wantedInfoUrl = wantedElement.getElementsByTagName("wantedInfoUrl").item(0).getTextContent();
			
			wantedAuthNo = wantedElement.getElementsByTagName("wantedAuthNo").item(0).getTextContent();

	        // Now you can use wantedAuthNo to construct detailPageUrl
	        detailPageUrl = "http://localhost:8080/Takoyaki/contents/Detail.jsp?wantedAuthNo=" + wantedAuthNo;
			
			jobDataList.add(new JobData(title, company, closeDt, regDt, wantedInfoUrl, wantedAuthNo));
		}
	}

	// 등록 날짜("regDt")를 기준으로 리스트를 내림차순으로 정렬
	jobDataList.sort((jd1, jd2) -> jd2.getRegDt().compareTo(jd1.getRegDt()));
} catch (Exception e) {
	e.printStackTrace();
}
%>

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
<link rel="stylesheet" href="../resources/css/style.css?ver=1.3">
<link rel="shortcut icon" href="../resources/image/shortcut.png"
	type="image/x-icon" />

<script src="https://kit.fontawesome.com/d6f64dc1ee.js"
	crossorigin="anonymous"></script>
<title>문어빵</title>
</head>
<body>
	<%@include file="../include/header.jsp"%>
	<div class="bannerSlide">
		<input type="radio" name="slide" id="slide01" checked> <input
			type="radio" name="slide" id="slide02"> <input type="radio"
			name="slide" id="slide03">
		<ul class="slidelist">
			<li class="slideitem">
				<div>
					<label for="slide03" class="left"></label> <label for="slide02"
						class="right"></label> <a href=><img
						src=../resources/image/image01.png></a>
				</div>
			</li>
			<li class="slideitem"><label for="slide01" class="left"></label>
				<label for="slide03" class="right"></label> <a href=""><img
					src="../resources/image/image02.png"></a></li>
			<li class="slideitem"><label for="slide02" class="left"></label>
				<label for="slide01" class="right"></label> <a href=""><img
					src="../resources/image/image03.png"></a></li>
		</ul>
	</div>
	<div id="text01">
		<h2>최신 채용공고</h2>
	</div>
	<div id="text02">
		<h3>최근에 게시된 채용공고</h3>
	</div>
	<div id="boxList">
		<%
		for (int i = 0; i < total && i < jobDataList.size(); i++) {
			JobData jobData = jobDataList.get(i);
		%>
		<div id="box">
			<h3 class="heading"><a href="http://localhost:8080/Takoyaki/contents/Detail.jsp?wantedAuthNo=<%=jobData.wantedAuthNo%>"><%=jobData.getTitle()%></a></h3>
			<div class="data">
				<span class="date">등록 날짜 : <%=jobData.getRegDt()%></span>
				<span class="date">마감 날짜 : <%=jobData.closeDt%></span> 
				<span class="jobCompany">회사명 : <%=jobData.getCompany()%></span>
			</div>
			<div>
				<a href="<%=detailPageUrl%>"><button class="btn fifth">상세정보</button></a>
			</div>
		</div>
		<%
		}
		%>
	</div>
	<%
	if (id == null) {
	%>
	<div id="recLog">
		<a href="http://localhost:8080/Takoyaki/login/login.jsp"><img
			src="../resources/image/loginRec.png" class="recImg"></a>
	</div>
	<%
	} else {
	%>
	<div id="text01">
		<h2>최신 공모전</h2>
	</div>
	<div id="text02">
		<h3>최근에 게시된 공모전</h3>
	</div>
	<div id="boxList">
		<%
		MainDB cont = new MainDB();
		List<Competition> competitionList = cont.recentContent(); // recentContent() 메서드를 호출하여 데이터를 가져옴

		for (Competition competition : competitionList) {
		%>
		<div id="box">
			<h3 class="heading"><a href="http://localhost:8080/Takoyaki/contents/contDetail.jsp?contid=<%=competition.getContid()%>"><%=competition.getTitle()%></a></h3>
			<div class="data">
				<span class="date"><%=competition.getDate()%></span> <span
					class="jobCompany"><%=competition.getLocation()%></span>
			</div>
			<div>
				<a href="<%=competition.getHref()%>">
					<button class="btn fifth">상세정보</button>
				</a>
			</div>
		</div>
		<%
		}
		%>

	</div>
	<div id="text01">
		<h2>최신 대외활동</h2>
	</div>
	<div id="text02">
		<h3>최근에 게시된 대외활동</h3>
	</div>
	<div id="boxList">
		<%
		MainDB ext = new MainDB();
		List<External> externalList = ext.recentExternal(); // recentContent() 메서드를 호출하여 데이터를 가져옴

		for (External external : externalList) {
		%>
		<div id="box">
			<h3 class="heading"><a href="http://localhost:8080/Takoyaki/contents/extDetail.jsp?extid=<%=external.getExtid()%>"><%=external.getTitle()%></a></h3>
			<div class="data">
				<span class="date"><%=external.getDate()%></span> <span
					class="jobCompany"><%=external.getLocation()%></span>
			</div>
			<div>
				<a href="<%=external.getHref()%>">
					<button class="btn fifth">상세정보</button>
				</a>
			</div>
		</div>
		<%
		}
		%>
	</div>
	<%
	}
	%>


	<%@include file="../include/footer.jsp"%>

</body>
</html>