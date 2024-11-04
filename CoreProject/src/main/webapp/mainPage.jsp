<%@page import="com.smhrd.model.tb_service_area"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.ServiceAreaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de8ae99dd87927fe3467ec1335a0120d&libraries=services"></script>
	
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 페이지</title>
    <style>
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f5f5f5;
        }
        
        /* 헤더 스타일 */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #cae3f8;
            padding: 10px 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            height: 60px;
        }

        .header .logo {
            font-weight: bold;
            font-size: 20px;
        }

        /* 메뉴 스타일 */
        .menu {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #eaf4f9;
            padding: 10px 20px;
        }
        .menu a {
            margin-right: 20px;
            text-decoration: none;
            color: black;
            font-weight: bold;
            padding: 10px 15px;
            transition: background-color 0.3s;
        }
        .menu a:active,
        .menu a:focus {
            background-color: #ffffff;
            color: black;
        }
        
        /* user-info 스타일 */
        .menu .user-info {
            display: flex;
            align-items: center;
            font-size: 14px;
        }
        .menu .user-info span {
            margin-right: 15px;
        }
        .menu .user-info a {
            margin-left: 10px;
            text-decoration: none;
            color: #333;
            background-color: #d3d3d3;
            padding: 5px 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .menu .user-info a:hover {
            background-color: #b3b3b3;
        }
        
        /* 대시보드 컨테이너 */
        .container {
            display: grid;
            grid-template-columns: 1fr 1fr; /* 좌우 섹션을 동일한 너비로 설정 */
            gap: 20px;
            padding: 20px;
        }

        .left-section, .right-section {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* 스타일 - 큰 카드 */
        #map {
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            height: 400px;
        }

        /* 텍스트 카드 스타일 */
        .text-cards {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
        }
        .text-card {
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
            font-size: 18px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
        }

        /* 표 스타일 */
        .table-card {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
        }
        .table-card table {
            width: 100%;
            border-collapse: collapse;
        }
        .table-card th, .table-card td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        .table-card th {
            background-color: #f9eac3;
            font-weight: bold;
        }
        
        /* 차트 카드 스타일 */
        .chart-card {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            text-align: center;
            font-size: 18px;
            height: 250px; /* 차트 높이 고정 */
        }
    </style>
        <link rel="stylesheet" type="text/css" href="css/map_css.css">

</head>
<body>

     <!-- 헤더 -->
     <div class="header">
        <div class="logo">Comfort Guide</div>
    </div>

    <!-- 메뉴 -->
    <div class="menu">
        <div>
            <a href="mainpage.html" class="active">메인 페이지</a>
            <a href="subpage.html">검색 페이지</a>
            <a href="manager.html">관리자 페이지</a>
            <a href="suggestion.html">고객의 소리</a>
        </div>
        
        <!-- 사용자 정보와 링크 -->
        <div class="user-info">
            <span>정현지 님</span>
            <a href="profile.html">회원정보 수정</a>
            <a href="login.html">로그아웃</a>
        </div>
    </div>

    <!-- 대시보드 컨테이너 -->
    <div class="container">
        <!-- 왼쪽 섹션 -->
        <div class="left-section">
            <div id="map">지도</div>

            
            <div class="table-card">
                <h2>이벤트 중인 휴게소</h2>
                <table>
                    <thead>
                        <tr>
                            <th>휴게소 이름</th>
                            <th>이벤트 기간</th>
                            <th>이벤트 내용</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>용인 휴게소</td><td></td><td></td></tr>
                        <tr><td>이천 휴게소</td><td></td><td></td></tr>
                        <tr><td>기흥 휴게소</td><td></td><td></td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- 오른쪽 섹션 -->
        <div class="right-section">
            <div class="large-card">주유가격</div>
            <div class="text-cards">
                <div class="text-card">텍스트</div>
                <div class="text-card">텍스트</div>
                <div class="text-card">텍스트</div>
                <div class="text-card">텍스트</div>
                <div class="text-card">텍스트</div>
                <div class="text-card">텍스트</div>
            </div>
            <div class="chart-card">국내여행</div>
            <div class="chart-card">그래프</div>
        </div>
    </div>
   <%
    ServiceAreaDAO dao = new ServiceAreaDAO();
    List<tb_service_area> getArea = dao.getServiceArea();
%>
<script>
var positions = [
    <% for (int i = 0; i < getArea.size(); i++) { 
        String name = getArea.get(i).getSa_name().replace("(", " 휴게소(").replace(")", " 방향)");
        double lat = Double.parseDouble(String.format("%.6f", getArea.get(i).getLat()));
        double lon = Double.parseDouble(String.format("%.6f", getArea.get(i).getLon()));
    %>
    {
        title: '<%= name %>',
        latlng: new kakao.maps.LatLng(<%= lat %>, <%= lon %>),
        content: '<div class="wrap"><div class="info"><div class="title"><%= name %><div class="close" onclick="closeOverlay()" title="닫기"></div></div><div class="body"><div>휴게소 종류 : <%= getArea.get(i).getSa_type() %></div><div class="desc"><div class="ellipsis">주소 : <%= getArea.get(i).getSa_addr() %></div></div></div></div></div>'
    }<% if (i < getArea.size() - 1) { %>,<% } %>
    <% } %>
];
</script>


    <script src="js/map_js.js"></script>

</body>
</html>
