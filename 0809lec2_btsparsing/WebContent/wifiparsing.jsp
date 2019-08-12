<meta http-equiv="Content-Type" content="text/8html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page import="javax.xml.parsers.*,org.w3c.dom.*" %>
<html>
<head>
</head>
<body>
<h1>전국 무료 와이파이 목록</h1>
<%
//파싱을 위한 준비 과정
DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();

//파일 읽을 때 서버 내부 local path(전체경로)로 지정.. 이 문장이 xml파싱을 한다. 단 위에 xml관련 임포트를 주의하라
Document doc = docBuilder.parse(new File("C:/Users/User/eclipse-workspace/0809lec2_btsparsing/WebContent/freewifi.xml"));

Element root = doc.getDocumentElement(); //root태그를 가져오기도 하지만 이 소스에서는 쓰이는 곳이 없다
NodeList tag_place = doc.getElementsByTagName("설치장소명");
NodeList tag_manager = doc.getElementsByTagName("관리기관명");
NodeList tag_lat = doc.getElementsByTagName("위도");
NodeList tag_long = doc.getElementsByTagName("경도");

out.println("<table cellspacing=1 width=700 border=1");
out.println("<tr>");
out.println("<td width=100>설치장소명</td>");
out.println("<td width=100>관리기관명</td>");
out.println("<td width=100>위도</td>");
out.println("<td width=100>경도</td>");
out.println("</tr>");

for(int i=0; i<tag_place.getLength(); i++){
	out.println("<tr>");
	out.println("<td width=300>"+tag_place.item(i).getFirstChild().getNodeValue()+"</td>");
	out.println("<td width=300>"+tag_manager.item(i).getFirstChild().getNodeValue()+"</td>");
	out.println("<td width=50>"+tag_lat.item(i).getFirstChild().getNodeValue()+"</td>");
	out.println("<td width=50>"+tag_long.item(i).getFirstChild().getNodeValue()+"</td>");
	out.println("</tr>");
}
%>
</body>
</html>