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

    <link rel="stylesheet" type="text/css" href="css/map_css.css">
	<link rel="stylesheet" type="text/css" href="css/mainCss.css">
		
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
