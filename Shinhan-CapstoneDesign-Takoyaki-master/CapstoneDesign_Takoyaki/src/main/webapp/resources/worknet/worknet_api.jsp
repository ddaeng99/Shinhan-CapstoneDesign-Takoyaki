<!-- ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ 워크넷 api 데이터베이스에 전체 저장하는 코드★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★새로운 데이터 업데이트 할때 truncate table worknet으로 테이블을 비운뒤 실행★★★★★★★★★★★ -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*"%>
<%@ page import="java.io.*,java.net.HttpURLConnection,java.net.URL,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*"%>
<%@ page import="java.sql.*" %>
<%@ page import ="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>

<%@ page import="java.sql.SQLException" %>
<%


// 1. API 키를 저장합니다.
Class.forName("com.mysql.cj.jdbc.Driver");
String apiKey = "APIKEY";

// 2. API 요청을 위한 URL을 생성합니다.
String apiUrl = "http://openapi.work.go.kr/opi/opi/opia/wantedApi.do";
String callTp = "L"; // 일반 채용정보 조회
String returnType = "XML";
String display = "100";
String pageNumberParam = request.getParameter("pageNumber");
String displayParam = request.getParameter("display");


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
int total = 0; // 기본적으로 총 건수를 0으로 초기화합니다.
int totalPages = 1; 
int currentPage = 1; // 기본적으로 1페이지로 설정
int startPage = 1;
int itemsPerPage = 100; //총건수에서 몇개씩 자를건지 display와 맞춰야함
if (pageNumberParam != null && !pageNumberParam.isEmpty()) {
    currentPage = Integer.parseInt(pageNumberParam);
    // startPage는 한 번 계산된 후에는 고정된 값으로 사용
    startPage = (currentPage - 1)  + 1;
}


// 변수를 선언
String title = "";
String company = "";
String location = "";
String sal = "";
String wantedInfoUrl = "";
String closeDt = "";
String wantedAuthNo = "";
int jobsCd;


try {
    for (currentPage = 1; currentPage <= totalPages; currentPage++) {
       String startPageString = String.valueOf(currentPage);
        String apiParameters = "authKey=" + apiKey + "&callTp=" + callTp + "&returnType=" + returnType + "&startPage=" + startPageString + "&display=" + display + "&occupation=" + occupation + "&region=" + region + "&education=" + education + "&coTp=" + coTp  ;
        String fullUrl = apiUrl + "?" + apiParameters;
        // 3. HTTP 요청을 보내고 XML 데이터를 가져옵니다.
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

                    for (int i = 0; i < wantedList.getLength(); i++) {
                        Node wantedNode = wantedList.item(i);
                        if (wantedNode.getNodeType() == Node.ELEMENT_NODE) {
                            Element wantedElement = (Element) wantedNode;
                            
                            List<String> validJobCodes = Arrays.asList("132001", "132002", "132003", "133100", "133101", "133102", "133200", "133201", "133202", "133203", "133204", "133205", "133206", "133207", "133300", "133301", "133302", "133900", "134100", "134101", "134102", "134103", "134200", "134301", "134302", "134303", "134400", "134900", "135000", "135001", "214200", "214201", "214202", "415500", "415501", "415502", "415503", "415504", "415505");
                            String jobsCdString = wantedElement.getElementsByTagName("jobsCd").item(0).getTextContent();
                            jobsCd = Integer.parseInt(jobsCdString);
                            
                            if (validJobCodes.contains(jobsCdString)) {
                            title = wantedElement.getElementsByTagName("title").item(0).getTextContent();
                            company = wantedElement.getElementsByTagName("company").item(0).getTextContent();
                            location = wantedElement.getElementsByTagName("region").item(0).getTextContent();
                            sal = wantedElement.getElementsByTagName("sal").item(0).getTextContent();
                            wantedInfoUrl = wantedElement.getElementsByTagName("wantedInfoUrl").item(0).getTextContent();
                            closeDt = wantedElement.getElementsByTagName("closeDt").item(0).getTextContent();
                            wantedAuthNo = wantedElement.getElementsByTagName("wantedAuthNo").item(0).getTextContent();
                                             
                            String jdbcUrl = "AWS_RDS_ADDRESS";
                            String dbId = "DBID";
                            String dbPw = "DBPW";

                            // MySQL에 데이터 삽입
                            try (Connection con = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
                                 PreparedStatement statement = con.prepareStatement("INSERT INTO worknet (title, company, location, sal, wantedInfoUrl, closeDt, wantedAuthNo, jobsCd) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {
                                statement.setString(1, title);
                                statement.setString(2, company);
                                statement.setString(3, location);
                                statement.setString(4, sal);
                                statement.setString(5, wantedInfoUrl);
                                statement.setString(6, closeDt);
                                statement.setString(7, wantedAuthNo);
                                statement.setInt(8, jobsCd);
                                statement.executeUpdate();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                            }
                        }
                    }
                }
            }
        }
        is.close();
    }
} catch (Exception e) {
    e.printStackTrace();
}

%>