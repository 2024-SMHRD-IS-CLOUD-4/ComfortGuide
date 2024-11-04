<%@page import="com.smhrd.model.ServiceAreaDAO"%>
<%@page import="com.smhrd.model.tb_service_area"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        #weatherInfo {
            width: 500px;
            margin: 0 auto;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
            text-align: center;
        }

        .forecast {
            margin-bottom: 15px;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
    </style>
    <script src="assets/jquery.min.js"></script>
</head>
<body>
    <div id="weatherInfo">
        <h2>오늘 날씨</h2>
    </div>

	<%
	ServiceAreaDAO dao = new ServiceAreaDAO(); 
			List<tb_service_area> result = dao.existServiceArea("금강(부산)");	
			
			System.out.println(result.get(0).getLat());
			System.out.println(result.get(0).getLon());
	%>
	
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <script>
        const nx = <%= Math.floor(result.get(0).getLat())%>;
    	const ny = <%= Math.floor(result.get(0).getLon())%>;
        </script>
        <script src="js/weather.js">
            
        </script>
</body>
</html>
