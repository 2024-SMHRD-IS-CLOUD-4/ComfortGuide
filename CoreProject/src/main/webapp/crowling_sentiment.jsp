<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>

<%@ page isErrorPage="true" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sentiment Analysis</title>
</head>
<body>
    <div id="sentiment" style="width: 500px; height: 500px"></div>

<% 
	String service = "천안호두휴게소";
	String encodedService = URLEncoder.encode(service, "UTF-8");
	String url = "http://localhost:5000/searchService?name=" + encodedService; 
	System.out.println("Request URL: " + url);

    URL obj = new URL(url);
    HttpURLConnection con = (HttpURLConnection) obj.openConnection();
    con.setRequestMethod("GET");
    
    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
    String inputLine;
    StringBuffer responseData = new StringBuffer();
    
    while ((inputLine = in.readLine()) != null) {
        responseData.append(inputLine);
    }
    in.close();
    
    // JSON 파싱
    JSONObject jsonResponse = new JSONObject(responseData.toString());
    double positive = jsonResponse.getDouble("positive");
    double negative = jsonResponse.getDouble("negative");
    double neutral = jsonResponse.getDouble("neutral");
    System.out.println(positive);
    System.out.println(negative);
    System.out.println(neutral);
%>

<script>
    var positive = <%= positive %>;
    var negative = <%= negative %>;
    var neutral = <%= neutral %>;
</script>
<script src="js/sentiment1.js"></script>

</body>
</html>
