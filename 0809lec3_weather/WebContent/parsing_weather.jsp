<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ page import= "org.apache.http.HttpEntity" %>
<%@ page import= "org.apache.http.HttpResponse" %>
<%@ page import= "org.apache.http.NameValuePair" %>
<%@ page import= "org.apache.http.ParseException" %>
<%@ page import= "org.apache.http.client.HttpClient" %>
<%@ page import= "org.apache.http.client.entity.UrlEncodedFormEntity" %>
<%@ page import= "org.apache.http.client.methods.HttpGet" %>
<%@ page import= "org.apache.http.client.methods.HttpPost" %>
<%@ page import= "org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import= "org.apache.http.message.BasicNameValuePair" %>
<%@ page import= "org.apache.http.params.HttpConnectionParams" %>
<%@ page import= "org.apache.http.util.EntityUtils" %>
<%@ page import= "org.apache.http.conn.ClientConnectionManager" %>
<%@ page import= "org.apache.http.params.HttpParams" %>
<%@ page import= "org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>

<html>
<head>
<%!
/* DefaultHttpClient client;

// HttpClient재사용 관련 서버 통신 시 세션을 유지하기 위함..
public DefaultHttpClient getThreadSafeClient() {
	if (client != null)
		return client;
	client = new DefaultHttpClient();
	ClientConnectionManager mgr = client.getConnectionManager();
	HttpParams params = client.getParams();
	client = new DefaultHttpClient(new ThreadSafeClientConnManager(params, mgr.getSchemeRegistry()), params);
	return client;
}
public String goXML(String getURL) {
	String Result = null;
	//세션유지 체크
	HttpClient client = getThreadSafeClient();
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if (false){ //여기가 post/get 파라미터 전달하는 곳
		nameValuePairs.add(new BasicNameValuePair("input1", "kopoctc"));
	}
	
	try {
		post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
		HttpResponse responsePost = null;
		
		responsePost = client.execute(post);
		HttpEntity resEntity = responsePost.getEntity();
		
		if (resEntity != null) {
			Result = EntityUtils.toString(resEntity).trim();
		}		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		
	}
	return Result;
} */
%>
<style>
img{
	width: 40px;
	height: 40px;
}
</style>
</head>
<body>
<h1>날씨</h1>
<%
	String url = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123.jsp";
//파싱을 위한 준비 과정
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	Document doc = docBuilder.parse(url);
	
	// root tag 
	doc.getDocumentElement().normalize();
	
	String seq="";String hour="";String day="";String temp="";String tmx="";
	String tmn="";String sky="";String pty="";String wfKor="";String wfEn="";
	String pop="";String r12="";String s12="";String ws="";String wd="";
	String wdKor="";String wdEn="";String reh="";String r06="";String s06="";

	try{			
		out.println("<table border='1'>");
		out.println("<tr>");
		out.println("<td>seq</td>");
		out.println("<td>시간</td>");
		out.println("<td>temp</td>");
		out.println("<td>tmx</td>");
		out.println("<td>tmn</td>");
		out.println("<td>sky</td>");
		out.println("<td>강수</td>");
		out.println("<td>하늘</td>");
		out.println("<td>wfEn</td>");
		out.println("<td>pop</td>");
		out.println("<td>r12</td>");
		out.println("<td>s12</td>");
		out.println("<td>ws</td>");
		out.println("<td>wd</td>");
		out.println("<td>wdKor</td>");
		out.println("<td>wdEn</td>");
		out.println("<td>reh</td>");
		out.println("<td>r06</td>");
		out.println("<td>s06</td>");
		out.println("</tr>");		
		
		//생성된 document에서 각 요소들을 접근하여 데이터를 저장
		Element root = doc.getDocumentElement();
		NodeList tag_001 = doc.getElementsByTagName("data");
		
		for(int i=0; i<tag_001.getLength(); i++){
			Element elmt=(Element)tag_001.item(i);
			
			seq=tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();
			hour=elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
			day=elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
				if(day.equals("0")){day="오늘 ";}
				else if(day.equals("1")){day="내일 ";} 
				else if(day.equals("2")){day="모레 ";} 
			temp=elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();
			tmx=elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();
			tmn=elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();
			sky=elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue();
			pty=elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
				if(pty.equals("0")){pty="없음";}
				else if(pty.equals("1")){pty="비";} 
				else if(pty.equals("2")){pty="비/눈";} 
				else if(pty.equals("3")){pty="눈/비";} 
				else if(pty.equals("3")){pty="눈";} 
			wfKor=elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue();				
			wfEn=elmt.getElementsByTagName("wfEn").item(0).getFirstChild().getNodeValue();
			pop=elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();
			r12=elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue();
			s12=elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue();
			ws=elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue();
			wd=elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue();
			wdKor=elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue();
			wdEn=elmt.getElementsByTagName("wdEn").item(0).getFirstChild().getNodeValue();
			reh=elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue();
			r06=elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue();
			s06=elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue();
			
			out.println("<tr>");
			out.println("<td width=100>"+seq+"</td>");
			out.println("<td width=100>"+day+hour+"시</td>");
			out.println("<td width=100>"+temp+"</td>");
			out.println("<td width=100>"+tmx+"</td>");
			out.println("<td width=100>"+tmn+"</td>");
			out.println("<td width=100>"+sky+"</td>");
			out.println("<td width=100>"+pty+"</td>");
			
			if(wfKor.equals("맑음")){
				out.println("<td width=100><img src='image/sunny.png'></td>");
			}
			else if(wfKor.equals("구름 조금")){
				out.println("<td width=100><img src='image/partlycloudy.png'></td>");
				} 
			else if(wfKor.equals("구름 많음")){
				out.println("<td width=100><img src='image/mostlycloudy.png'></td>");
				} 
			else if(wfKor.equals("흐림")){
				out.println("<td width=100><img src='image/cloudy.png'></td>");
				}
			else if(wfKor.equals("비")){
				out.println("<td width=100><img src='image/rain.png'></td>");
				}
			
			out.println("<td width=100>"+wfEn+"</td>");
			out.println("<td width=100>"+pop+"</td>");
			out.println("<td width=100>"+r12+"</td>");
			out.println("<td width=100>"+s12+"</td>");
			out.println("<td width=100>"+ws+"</td>");
			out.println("<td width=100>"+wd+"</td>");
			out.println("<td width=100>"+wdKor+"</td>");
			out.println("<td width=100>"+wdEn+"</td>");
			out.println("<td width=100>"+reh+"</td>");
			out.println("<td width=100>"+r06+"</td>");
			out.println("<td width=100>"+s06+"</td>");
			out.println("</tr>");
			
		}		
 			out.println("</table>");
	} catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>