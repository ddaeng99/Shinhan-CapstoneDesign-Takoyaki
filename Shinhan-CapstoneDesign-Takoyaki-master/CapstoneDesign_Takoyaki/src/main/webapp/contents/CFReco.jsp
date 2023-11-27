<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.servlet.*,javax.servlet.http.*"%>

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

<link rel="stylesheet" href="../resources/css/jobinfo.css?ver=1.2">
<link rel="shortcut icon" href="../resources/image/shortcut.png"
	type="image/x-icon" />

<script src="https://kit.fontawesome.com/d6f64dc1ee.js"
	crossorigin="anonymous"></script>

<title>문어빵</title>

<style>
.tong {
	width: 50%;
	margin-right: 25%;
	color: #444;
}

.dbitem-list {
	list-style: none;
	padding: 0;
	font-family: 'Noto Sans KR', sans-serif;
}

.dbitem-list li {
	margin-bottom: 10px;
}

.dbitem a {
	color: #F59A12;
	text-decoration: none;
}

.dbhr {
	width: 70%;
	margin: 10px auto;
	margin-right: 38%;
}

.dbitem_urltitle a {
	color: #F59A12;
	text-decoration: none;
}

.container {
	margin-left: 25%;
	width: 70%;
	margin-right: 25%;
	margin-top: 2%;
}

.help {
	position: relative;
	justify-content: center;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 800;
	width: 100%;
	padding-left: 20%;
}

.helpImg {
	width: 1000px;
}

#recLog {
	position: relative;
	justify-content: center;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 800;
	width: 100%;
	padding-left: 20%;
}

.recImg {
	width: 1019px;
}
.cos_sim, .dbitem_pred_rating{
color: #B24A4A;
}
</style>

</head>
<body>
	<%@include file="../include/header.jsp"%>
	<form id="searchForm">
		<nav class="jobMenu">
			<ul class="jobCategory">
				<li><a href="#" id="job" onclick="setCategory('job')">채용공고</a></li>
				<li><a href="#" id="contest" onclick="setCategory('contest')">공모전</a></li>
				<li><a href="#" id="externals"
					onclick="setCategory('externals')">대외활동</a></li>
			</ul>
			<ul class="recoCategory">
				<li><a href="#" id="cbfReco"
					onclick="setRecoCategory('cbfReco')">컨텐츠 기반 추천 컨텐츠</a></li>
				<li><a href="#" id="cfReco" onclick="setRecoCategory('cfReco')">사용자
						맞춤 추천 컨텐츠</a></li>
			</ul>
		</nav>
		<!-- 히든 필드 -->
		<input type="hidden" id="categoryHiddenInput" name="category" value="">
		<input type="hidden" id="categoryHiddenInputReco" name="recoCategory"
			value="">
	</form>
	<%
	String category = request.getParameter("category");
	String recoCategory = request.getParameter("recoCategory");

	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
	String query = "";
	String userId = id;

	Class.forName("com.mysql.cj.jdbc.Driver");
	String jdbcUrl = "AWS_RDS_ADDRESS";
	String dbId = "DBID";
	String dbPw = "DBPW";
	connection = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
	statement = connection.createStatement();
	if (userId == null) {
		out.print("<style>");
		out.print(".navbar_menu .nav_recoContent {");
		out.print("color: #F59A12;");
		out.print("}");
		out.print("</style>");
		out.print("<div id= 'recLog'>");
		out.print(
		"<a href=\"http://localhost:8080/Takoyaki/login/login.jsp\"><img src=\"../resources/image/loginRec.png\" class='recImg'></a>");
		out.print("</div>");
	} else {
		if (category == null || recoCategory == null) {
			out.print("<div class = 'help'>");
			out.print("<img src=\"../resources/image/help.png\" class = 'helpImg'>");
			out.print("</div>");
		}
		// Python 프로세스의 출력을 읽어서 wantedAuthNo 값을 받아옴
		if ("job".equals(category) && "cbfReco".equals(recoCategory)) {
			out.print("<style>");
			out.print(".navbar_menu .nav_recoContent {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".jobCategory #job {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".recoCategory #cbfReco {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print("</style>");
			// 알고리즘 파일 주소
			String pythonReco = "C:\\Users\\skg06\\git\\Capstone-Project\\Capstone-Takoyaki\\Capstone-Takoyaki\\src\\main\\python\\cbf.py";

			// 파이썬 프로세스 실행
			ProcessBuilder processBuilder = new ProcessBuilder("python", pythonReco);
			Process process = processBuilder.start();
			BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

			// 데이터를 Python 프로세스로 보내기
			OutputStream outputStream = process.getOutputStream();
			PrintWriter writer = new PrintWriter(outputStream);
			writer.println(userId); // userId 값을 Python 프로세스로 보냅니다.
			writer.flush();

			try {
		out.print("<div class='container'>");
		out.print("<div class='tong'><h1>컨텐츠 기반 추천 채용공고</h1></div>");
		String pythonOutput;
		while ((pythonOutput = reader.readLine()) != null) {
			if (pythonOutput.startsWith("wantedAuthNo: ")) {
				// wantedAuthNo 값을 읽어옴
				String wantedAuthNo = pythonOutput.substring("wantedAuthNo: ".length());
				// wantedAuthNo 값을 사용하여 공고 정보 조회
				query = "SELECT title, company, location, sal, wantedInfoUrl, closeDt FROM worknet WHERE wantedAuthNo = '"
						+ wantedAuthNo + "'";
				resultSet = statement.executeQuery(query);

				while (resultSet.next()) {
					String sql_title = resultSet.getString("title");
					String sql_company = resultSet.getString("company");
					String sql_location = resultSet.getString("location");
					String sql_salary = resultSet.getString("sal");
					String sql_wantedInfoUrl = resultSet.getString("wantedInfoUrl");
					String sql_closeDt = resultSet.getString("closeDt");
					String cos_sim = "";
					if ((pythonOutput = reader.readLine()) != null
							&& pythonOutput.startsWith("cosine_similarity: ")) {
						cos_sim = pythonOutput.substring("cosine_similarity: ".length());
					}
					// 공고 정보 출력
					out.print("<div><nav class=\"dblocMenu\">");
					out.print("<ul class = dbitem-list>");
					out.print("<li class= dbitem_urltitle><a href=\""
							+ "http://localhost:8080/Takoyaki/contents/Detail.jsp?wantedAuthNo=" + wantedAuthNo
							+ "\" target='_blank'>" + sql_title + "</a></li>");
					out.print("<li class= dbitem_company>" + sql_company + "</li>");
					out.print("<li class= dbitem_loc> 지역 : " + sql_location + "</li>");
					out.print("<li class= dbitem_sal> 급여 : " + sql_salary + "</li>");
					out.print("<li class= dbitem_close> 마감일자 : " + sql_closeDt + "</li>");
					out.print("<li class= cos_sim> 코사인 유사도 : " + cos_sim + "</li>");
					out.print("</ul>");
					out.print("<hr class='dbhr'></nav></div>");
				}
			}
		} // 프로세스 종료 대기
		int exitCode = process.waitFor();
		System.out.println("Python 프로세스 종료 코드: " + exitCode);
			} catch (Exception e) {
		e.printStackTrace();
			} finally {
		// 연결 및 리소스 정리
		try {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
			}
			out.print("</div>");
		}

		else if ("job".equals(category) && "cfReco".equals(recoCategory)) {
			out.print("<style>");
			out.print(".navbar_menu .nav_recoContent {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".jobCategory #job {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".recoCategory #cfReco {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print("</style>");

			String pythonReco = "C:\\Users\\skg06\\git\\Capstone-Project\\Capstone-Takoyaki\\Capstone-Takoyaki\\src\\main\\python\\mlcbf.py";

			// 파이썬 프로세스 실행
			ProcessBuilder processBuilder = new ProcessBuilder("python", pythonReco);
			Process process = processBuilder.start();
			BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

			// 데이터를 Python 프로세스로 보내기
			OutputStream outputStream = process.getOutputStream();
			PrintWriter writer = new PrintWriter(outputStream);
			writer.println(userId); // userId 값을 Python 프로세스로 보냅니다.
			writer.flush();

		try {
		out.print("<div class='container'>");
		out.print("<div class='tong'><h1>사용자 맞춤 추천 채용공고</h1></div>");
		String pythonOutput;
		while ((pythonOutput = reader.readLine()) != null) {
			if (pythonOutput.startsWith("wantedAuthNo: ")) {
				// wantedAuthNo 값을 읽어옴
				String wantedAuthNo = pythonOutput.substring("wantedAuthNo: ".length());
				// wantedAuthNo 값을 사용하여 공고 정보 조회
				query = "SELECT title, company, location, sal, occupation FROM worknet WHERE wantedAuthNo = '"
						+ wantedAuthNo + "'";
				resultSet = statement.executeQuery(query);

				while (resultSet.next()) {
					String sql_title = resultSet.getString("title");
					String sql_company = resultSet.getString("company");
					String sql_location = resultSet.getString("location");
					String sql_salary = resultSet.getString("sal");
					String sql_occupation = resultSet.getString("occupation");
					String pred_rating = "";
					
					if ((pythonOutput = reader.readLine()) != null
							&& pythonOutput.startsWith("pred_rating: ")) {
						pred_rating = pythonOutput.substring("pred_rating: ".length());
					}
					
					// 공고 정보 출력
					out.print("<div><nav class=\"dblocMenu\">");
					out.print("<ul class = dbitem-list>");
					out.print("<li class= dbitem_urltitle><a href=\""
							+ "http://localhost:8080/Takoyaki/contents/Detail.jsp?wantedAuthNo=" + wantedAuthNo
							+ "\" target='_blank'>" + sql_title + "</a></li>");
					out.print("<li class= dbitem_company>" + sql_company + "</li>");
					out.print("<li class= dbitem_loc> 지역 : " + sql_location + "</li>");
					out.print("<li class= dbitem_sal> 급여 : " + sql_salary + "</li>");
					out.print("<li class= dbitem_occupation> 직종 : " + sql_occupation + "</li>");
					out.print("<li class= dbitem_pred_rating> 예측 평점 : " + pred_rating + "</li>");
					out.print("</ul>");
					out.print("<hr class='dbhr'></nav></div>");

				}
			}
		} // 프로세스 종료 대기
		int exitCode = process.waitFor();
		System.out.println("Python 프로세스 종료 코드: " + exitCode);
		out.print("</div>");
			} catch (Exception e) {
		e.printStackTrace();
			} finally {
		// 연결 및 리소스 정리
		try {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
			}
		} else if ("contest".equals(category) && "cbfReco".equals(recoCategory)) {
			out.print("<style>");
			out.print(".navbar_menu .nav_recoContent {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".jobCategory #contest {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".recoCategory #cbfReco {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print("</style>");
			// 알고리즘 파일 주소
			String pythonReco = "C:\\Users\\skg06\\git\\Capstone-Project\\Capstone-Takoyaki\\Capstone-Takoyaki\\src\\main\\python\\contestCBF.py";

			// 파이썬 프로세스 실행
			ProcessBuilder processBuilder = new ProcessBuilder("python", pythonReco);
			Process process = processBuilder.start();
			BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

			// 데이터를 Python 프로세스로 보내기
			OutputStream outputStream = process.getOutputStream();
			PrintWriter writer = new PrintWriter(outputStream);
			writer.println(userId); // userId 값을 Python 프로세스로 보냅니다.
			writer.flush();

		try {
		out.print("<div class='container'>");
		out.print("<div class='tong'><h1>컨텐츠 기반 추천 공모전</h1></div>");
		String pythonOutput;
		while ((pythonOutput = reader.readLine()) != null) {
			if (pythonOutput.startsWith("contid: ")) {
				// contid 값을 읽어옴
				int startIndex = pythonOutput.indexOf("contid: ") + "contid: ".length();
				String contidString = pythonOutput.substring(startIndex);
				int contid = Integer.parseInt(contidString);
				// contid 값을 사용하여 공고 정보 조회
				query = "SELECT title, location, date, href FROM competitions WHERE contid = '" + contid + "'";
				resultSet = statement.executeQuery(query);

				while (resultSet.next()) {
					String sql_comtitle = resultSet.getString("title");
					String sql_comlocation = resultSet.getString("location");
					String sql_comdate = resultSet.getString("date");
					String sql_comhref = resultSet.getString("href");
					String cos_sim = "";
					if ((pythonOutput = reader.readLine()) != null
							&& pythonOutput.startsWith("cosine_similarity: ")) {
						cos_sim = pythonOutput.substring("cosine_similarity: ".length());
					}
					// 공고 정보 출력
					out.print("<div><nav class=\"dblocMenu\">");
					out.print("<ul class = dbitem-list>");
					out.print("<li class= dbitem_urltitle><a href=\""
							+ "http://localhost:8080/Takoyaki/contents/contDetail.jsp?contid=" + contid
							+ "\" target='_blank'>" + sql_comtitle + "</a></li>");
					out.print("<li class= dbitem_loc> 주최자 : " + sql_comlocation + "</li>");
					out.print("<li class= dbitem_date> 기한 : " + sql_comdate + "</li>");
					out.print("<li class= cos_sim> 코사인 유사도 : " + cos_sim + "</li>");
					out.print("</ul>");
					out.print("<hr class='dbhr'></nav></div>");
				}
			}
		} // 프로세스 종료 대기
		int exitCode = process.waitFor();
		System.out.println("Python 프로세스 종료 코드: " + exitCode);
			} catch (Exception e) {
		e.printStackTrace();
			} finally {
		// 연결 및 리소스 정리
		try {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
			}
			out.print("</div>");
		} else if ("contest".equals(category) && "cfReco".equals(recoCategory)) {
			out.print("<style>");
			out.print(".navbar_menu .nav_recoContent {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".jobCategory #contest {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".recoCategory #cfReco {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print("</style>");
			
			String pythonReco = "C:\\Users\\skg06\\git\\Capstone-Project\\Capstone-Takoyaki\\Capstone-Takoyaki\\src\\main\\python\\mlcontestcbf.py";

			ProcessBuilder processBuilder = new ProcessBuilder("python", pythonReco);
			Process process = processBuilder.start();
			BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

			// 데이터를 Python 프로세스로 보내기
			OutputStream outputStream = process.getOutputStream();
			PrintWriter writer = new PrintWriter(outputStream);
			writer.println(userId); // userId 값을 Python 프로세스로 보냅니다.
			writer.flush();

		try {
			out.print("<div class='container'>");
			out.print("<div class='tong'><h1>공모전 사용자 맞춤 추천</h1></div>");
			String pythonOutput;
		while ((pythonOutput = reader.readLine()) != null) {
			if (pythonOutput.startsWith("contid: ")) {
				// contid 값을 읽어옴
				int startIndex = pythonOutput.indexOf("contid: ") + "contid: ".length();
				String contidString = pythonOutput.substring(startIndex);
				int contid = Integer.parseInt(contidString);
				// contid 값을 사용하여 공고 정보 조회
				query = "SELECT title, location, date, href FROM competitions WHERE contid = '" + contid + "'";
				resultSet = statement.executeQuery(query);

				while (resultSet.next()) {
					String sql_comtitle = resultSet.getString("title");
					String sql_comlocation = resultSet.getString("location");
					String sql_comdate = resultSet.getString("date");
					String sql_comhref = resultSet.getString("href"); // 얘 필요없음
					String pred_rating = "";
					if ((pythonOutput = reader.readLine()) != null
							&& pythonOutput.startsWith("pred_rating: ")) {
						pred_rating = pythonOutput.substring("pred_rating: ".length());
					}

					// 공고 정보 출력
					out.print("<div><nav class=\"dblocMenu\">");
					out.print("<ul class = dbitem-list>");
					out.print("<li class= dbitem_urltitle><a href=\""
							+ "http://localhost:8080/Takoyaki/contents/contDetail.jsp?contid=" + contid
							+ "\" target='_blank'>" + sql_comtitle + "</a></li>");
					out.print("<li class= dbitem_loc> 주최자 : " + sql_comlocation + "</li>");
					out.print("<li class= dbitem_date> 기한 : " + sql_comdate + "</li>");
					out.print("<li class= dbitem_pred_rating> 예측 평점 : " + pred_rating + "</li>");
					out.print("</ul>");
					out.print("<hr class='dbhr'></nav></div>");
				}
			}
		} // 프로세스 종료 대기
		int exitCode = process.waitFor();
		System.out.println("Python 프로세스 종료 코드: " + exitCode);
			} catch (Exception e) {
		e.printStackTrace();
			} finally {
		// 연결 및 리소스 정리
		try {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
			}
			out.print("</div>");
		}
		else if ("externals".equals(category) && "cbfReco".equals(recoCategory)) {
			out.print("<style>");
			out.print(".navbar_menu .nav_recoContent {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".jobCategory #externals {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".recoCategory #cbfReco {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print("</style>");
			// 알고리즘 파일 주소
			String pythonReco = "C:\\Users\\skg06\\git\\Capstone-Project\\Capstone-Takoyaki\\Capstone-Takoyaki\\src\\main\\python\\externalsCBF.py";

			// 파이썬 프로세스 실행
			ProcessBuilder processBuilder = new ProcessBuilder("python", pythonReco);
			Process process = processBuilder.start();
			BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

			// 데이터를 Python 프로세스로 보내기
			OutputStream outputStream = process.getOutputStream();
			PrintWriter writer = new PrintWriter(outputStream);
			writer.println(userId); // userId 값을 Python 프로세스로 보냅니다.
			writer.flush();

			try {
		out.print("<div class='container'>");
		out.print("<div class='tong'><h1>컨텐츠 기반 추천 대외활동</h1></div>");
		String pythonOutput;
		while ((pythonOutput = reader.readLine()) != null) {
			if (pythonOutput.startsWith("extid: ")) {
				// contid 값을 읽어옴
				int startIndex = pythonOutput.indexOf("extid: ") + "extid: ".length();
				String extidString = pythonOutput.substring(startIndex);
				int extid = Integer.parseInt(extidString);
				// contid 값을 사용하여 공고 정보 조회
				query = "SELECT title, location, date, href FROM externals WHERE extid = '" + extid + "'";
				resultSet = statement.executeQuery(query);

				while (resultSet.next()) {
					String sql_extitle = resultSet.getString("title");
					String sql_exlocation = resultSet.getString("location");
					String sql_exdate = resultSet.getString("date");
					String sql_exhref = resultSet.getString("href");
					String cos_sim = "";
					if ((pythonOutput = reader.readLine()) != null
							&& pythonOutput.startsWith("cosine_similarity: ")) {
						cos_sim = pythonOutput.substring("cosine_similarity: ".length());
					}
					// 공고 정보 출력
					out.print("<div><nav class=\"dblocMenu\">");
					out.print("<ul class = dbitem-list>");
					out.print("<li class= dbitem_urltitle><a href=\""
							+ "http://localhost:8080/Takoyaki/contents/extDetail.jsp?extid=" + extid
							+ "\" target='_blank'>" + sql_extitle + "</a></li>");
					out.print("<li class= dbitem_loc> 주최자 : " + sql_exlocation + "</li>");
					out.print("<li class= dbitem_date> 기한 : " + sql_exdate + "</li>");
					out.print("<li class= cos_sim> 코사인 유사도 : " + cos_sim + "</li>");
					out.print("</ul>");
					out.print("<hr class='dbhr'></nav></div>");
				}
			}
		} // 프로세스 종료 대기
		int exitCode = process.waitFor();
		System.out.println("Python 프로세스 종료 코드: " + exitCode);
			} catch (Exception e) {
		e.printStackTrace();
			} finally {
		// 연결 및 리소스 정리
		try {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
			}
			out.print("</div>");
		} else if ("externals".equals(category) && "cfReco".equals(recoCategory)) {
			out.print("<style>");
			out.print(".navbar_menu .nav_recoContent {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".jobCategory #externals {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print(".recoCategory #cfReco {");
			out.print("color: #F59A12;");
			out.print("}");
			out.print("</style>");
			
			// 파이썬 프로세스 실행
			String pythonReco = "C:\\Users\\skg06\\git\\Capstone-Project\\Capstone-Takoyaki\\Capstone-Takoyaki\\src\\main\\python\\mlexternalscbf.py";
			ProcessBuilder processBuilder = new ProcessBuilder("python", pythonReco);
		    Process process = processBuilder.start();
		    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
		    
		 	// 데이터를 Python 프로세스로 보내기
		    OutputStream outputStream = process.getOutputStream();
		    PrintWriter writer = new PrintWriter(outputStream);
		    writer.println(userId); // userId 값을 Python 프로세스로 보냅니다.
		    writer.flush();
			
			try {
				out.print("<div class='container'>");
		        out.print("<div class='tong'><h1>대외활동 사용자 맞춤 추천</h1></div>");
		        String pythonOutput;
		        while ((pythonOutput = reader.readLine()) != null) {
		    if (pythonOutput.startsWith("extid: ")) {
		         // contid 값을 읽어옴
		         int startIndex = pythonOutput.indexOf("extid: ") + "extid: ".length();
		         String extidString = pythonOutput.substring(startIndex);
		         int extid = Integer.parseInt(extidString);
		         // contid 값을 사용하여 공고 정보 조회
		         query = "SELECT title, location, date, href FROM externals WHERE extid = '" + extid + "'";
		         resultSet = statement.executeQuery(query);

		         while (resultSet.next()) {
		            String sql_extitle = resultSet.getString("title");
		            String sql_exlocation = resultSet.getString("location");
		            String sql_exdate = resultSet.getString("date");
		            String sql_exhref = resultSet.getString("href"); //필요없음
		            String pred_rating = "";
		            if ((pythonOutput = reader.readLine()) != null
							&& pythonOutput.startsWith("pred_rating: ")) {
						pred_rating = pythonOutput.substring("pred_rating: ".length());
					}
		            
		            // 공고 정보 출력
		            out.print("<div><nav class=\"dblocMenu\">");
		            out.print("<ul class = dbitem-list>");
		            out.print("<li class= dbitem_urltitle><a href=\""
							+ "http://localhost:8080/Takoyaki/contents/extDetail.jsp?extid=" + extid
							+ "\" target='_blank'>" + sql_extitle + "</a></li>");
		            out.print("<li class= dbitem_loc> 주최자 : " + sql_exlocation + "</li>");
		            out.print("<li class= dbitem_date> 기한 : " + sql_exdate + "</li>");
		            out.print("<li class= dbitem_pred_rating> 예측 평점 : " + pred_rating + "</li>");
		            out.print("</ul>");
		            out.print("<hr class='dbhr'></nav></div>");
		         }
		      }
		         } // 프로세스 종료 대기
		         int exitCode = process.waitFor();
		         System.out.println("Python 프로세스 종료 코드: " + exitCode);
		      } catch (Exception e) {
		         e.printStackTrace();
		      } finally {
		         // 연결 및 리소스 정리
		         try {
		      if (resultSet != null)
		         resultSet.close();
		      if (statement != null)
		         statement.close();
		      if (connection != null)
		         connection.close();
		         } catch (SQLException e) {
		      e.printStackTrace();
		         }
		      }
		   }
			out.print("</div>");
		}
	
	%>


</body>
<%@include file="../include/footer.jsp"%>
<script src="../resources/script/cbfReco.js?=ver1.1"></script>
</html>