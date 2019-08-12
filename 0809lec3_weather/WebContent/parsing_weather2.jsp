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
DefaultHttpClient client;

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
public String goLogin(){
	return goXML("http://192.168.23.106:8090/0809lec3_weather/login.jsp", true);
}
public String goXML(String getURL){
	return goXML(getURL,false);
}
public String goXML(String getURL,Boolean loginFlag){
	String Result = null;
	
	//세션유지 체크
	HttpClient client = getThreadSafeClient();
	
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if (loginFlag){ //여기가 post/get 파라미터 전달하는 곳
		nameValuePairs.add(new BasicNameValuePair("username", "kopoctc"));
		nameValuePairs.add(new BasicNameValuePair("userpasswd", "kopoctc"));
	}
	
	try{
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
}
%>
</head>
<body>
<h1>날씨</h1>
<%
//로그인 후 xml을 조회한다. 내부 소스에 이미 세션을 유지하도록 설계되어 있다.
	String ret = goLogin();
	ret = goXML("http://192.168.23.106:8090/0809lec3_weather/loginxml.jsp");
	out.println("ret: "+ret);
	
	try{
		//DocumentBuilderFactory 객체 생성
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		//DocumentBuilder 객체 생성
		DocumentBuilder builder = factory.newDocumentBuilder();
		
		ByteArrayInputStream is = new ByteArrayInputStream(ret.getBytes("utf-8"));
		//builder를 이용하여 XML 파싱하여 Document 객체 생성
		Document doc = builder.parse(is);
		
		String seq=null;String hour=null;String day=null;String temp=null;String tmx=null;
		String tmn=null;String sky=null;String pty=null;String wfKor=null;String wfEn=null;
		String pop=null;String r12=null;String s12=null;String ws=null;String wd=null;
		String wdKor=null;String wdEn=null;String reh=null;String r06=null;String s06=null;
		
		out.println("<table border='1'>");
		out.println("<tr>");
		out.println("<td>seq</td>");
		out.println("<td>hour</td>");
		out.println("<td>day</td>");
		out.println("<td>temp</td>");
		out.println("<td>tmn</td>");
		out.println("<td>sky</td>");
		out.println("<td>pty</td>");
		out.println("<td>wfKor</td>");
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
			temp=elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();
			tmx=elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();
			tmn=elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();
			sky=elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue();
			pty=elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
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
			
			
		}
		out.println("<tr>");
		out.println("<td width=100>"+seq+"</td>");
		out.println("<td width=100>"+hour+"</td>");
		out.println("<td width=100>"+day+"</td>");
		out.println("<td width=100>"+temp+"</td>");
		out.println("<td width=100>"+tmx+"</td>");
		out.println("<td width=100>"+tmn+"</td>");
		out.println("<td width=100>"+sky+"</td>");
		out.println("<td width=100>"+pty+"</td>");
		out.println("<td width=100>"+wfKor+"</td>");
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
 			out.println("</table>");
// 			System.out.println("<td width=100>"+seq+"</td>");
// 			System.out.println("<td width=100>"+hour+"</td>");
// 			System.out.println("<td width=100>"+day+"</td>");
// 			System.out.println("<td width=100>"+temp+"</td>");
// 			System.out.println("<td width=100>"+tmx+"</td>");
// 			System.out.println("<td width=100>"+tmn+"</td>");
// 			System.out.println("<td width=100>"+sky+"</td>");
// 			System.out.println("<td width=100>"+pty+"</td>");
// 			System.out.println("<td width=100>"+wfKor+"</td>");
// 			System.out.println("<td width=100>"+wfEn+"</td>");
// 			System.out.println("<td width=100>"+pop+"</td>");
// 			System.out.println("<td width=100>"+r12+"</td>");
// 			System.out.println("<td width=100>"+s12+"</td>");
// 			System.out.println("<td width=100>"+ws+"</td>");
// 			System.out.println("<td width=100>"+wd+"</td>");
// 			System.out.println("<td width=100>"+wdKor+"</td>");
// 			System.out.println("<td width=100>"+wdEn+"</td>");
// 			System.out.println("<td width=100>"+reh+"</td>");
// 			System.out.println("<td width=100>"+r06+"</td>");
// 			System.out.println("<td width=100>"+s06+"</td>");

	} catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>