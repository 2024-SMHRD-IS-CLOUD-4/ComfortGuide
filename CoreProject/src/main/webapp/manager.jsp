<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.smhrd.model.tb_suggestion"%>
<%@page import="java.util.List"%>
<%@page import="java.net.URL"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.smhrd.model.tb_service_area"%>
<%@page import="com.smhrd.model.ServiceAreaDAO"%>
<%@page import="com.smhrd.model.tb_admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Comfort Guide</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/regression"></script>
<link rel="stylesheet" type="text/css" href="css/manager.css">
</head>
<body>

   <%
   tb_admin login = (tb_admin) session.getAttribute("login");
   String saName = "";
   if (login != null) {
      saName = login.getSa_name(); // 예: "강원(춘천)"
   }
   ServiceAreaDAO dao = new ServiceAreaDAO();
   tb_service_area area = dao.getServiceAreaBySaName(login.getSa_name());
   int tempLat = (int) area.getLat();
   int tempLon = (int) area.getLon();
   %>

   <script type="text/javascript">
        // JSP에서 saName 값을 JavaScript 변수로 전달
        const tempData = "<%=saName.split("\\(")[0]%>"; // "강원(춘천)"에서 "강원"만 사용
        const tempData2 = "<%=saName.split("\\(")[1]%>".replace(")","");
        const tempData3 = "<%=saName.split("\\(")[1]%>";
        console.log(tempData3.replace(")",""));
        console.log(tempData2);
        const saName = "<%=saName%>"; // 전체 이름 사용
        const lat2 = <%=tempLat%>;
        const lon2 = <%=tempLon%>;
    </script>

   <script type="text/javascript">
       function confirmLogin(page) {
           <%if (login == null) {%>
               alert("로그인이 필요한 서비스입니다!");
               window.location.href = "login.html";
           <%} else {%>
               window.location.href = page;
           <%}%>
       }
   </script>
   <!-- 헤더 -->
   <script type="text/javascript">
       function confirmLogin(page) {
           <%if (login == null) {%>
               alert("로그인이 필요한 서비스입니다!");
               window.location.href = "login.html";
           <%} else {%>
               window.location.href = page;
           <%}%>
       }
   </script>

   <div class="header">
      <div class="logo">Comfort Guide</div>
   </div>

   <!-- 메뉴 -->
   <div class="menu">
      <div>
         <a href="mainPage.jsp" class="active">메인 페이지</a> 
         <a href="subpage.jsp">검색 페이지</a>
          <a href="writer.jsp">글 작성</a>
         <!-- 로그인 체크가 필요한 링크 -->
         <a href="javascript:void(0);" onclick="confirmLogin('suggestion.jsp')">고객의 소리</a>
         <a href="javascript:void(0);" onclick="confirmLogin('manager.jsp')">관리자 페이지</a>
      </div>

      <!-- 사용자 정보와 링크 -->
      <div class="user-info">
         <%
         if (login != null) {
         %>
         <span><%=login.getAdmin_id()%> 님</span> <a href="profile.jsp">회원정보
            수정</a> <a href="logout">로그아웃</a>
         <%
         } else {
         %>
         <a href="login.html">로그인</a> <a href="Join.html">회원가입</a>
         <%
         }
         %>
      </div>
   </div>

   <!-- 컨테이너 -->
 <script type="text/javascript">
    const saName = "<%= saName %>";
</script>

<div class="container">
    <!-- 차트가 표시될 영역 -->
    <div class="chart-card" id="chartContainer">
    <canvas id="manager-chart"></canvas>
    </div>
      <%
      //String encodedService = URLEncoder.encode(login.getSa_name() + "휴게소", "UTF-8");
      //String url = "http://localhost:5000/searchService?name=" + encodedService;
      //System.out.println("Request URL: " + url);

      //URL obj = new URL(url);
      //HttpURLConnection con = (HttpURLConnection) obj.openConnection();
      //con.setRequestMethod("GET");

      //BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
      //String inputLine;
      //StringBuffer responseData = new StringBuffer();

      //while ((inputLine = in.readLine()) != null) {
         //responseData.append(inputLine);
      //}
      //in.close();

      // JSON 파싱
      //JSONObject jsonResponse = new JSONObject(responseData.toString());
      double positive = 0.0; 
	  //positive = jsonResponse.getDouble("positive");
      double negative = 0.0;
      //negative = jsonResponse.getDouble("negative");
      double neutral = 0.0;
      //neutral = jsonResponse.getDouble("neutral");
      //System.out.println(positive);
      //System.out.println(negative);
      //System.out.println(neutral);
      %>

      <!-- 오른쪽 상단 3개의 정보 박스 그룹 -->
      <div class="info-container">
    <div class="info-guests-card info-card">
    <canvas id="guests-chart"></canvas>
    </div>
    <div class="info-traffic-card info-card">
    <canvas id="traffic-chart"></canvas>
    </div>
    <div class="info-sales-card info-card">
        <canvas id="sales-chart"></canvas>
    </div>
 </div>
	<%
	%>
      <!-- 고객의 소리 박스 -->
      <div class="large-info-card">
    고객의 소리
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>제목</th>
                    <th>내용</th>
                </tr>
            </thead>
            <tbody>
                <% 
                List<tb_suggestion> slist = dao.getSuggestion(login.getSa_name());
                for (int i = 0; i < 20; i++) {
                    if (i < slist.size()) {
                        tb_suggestion suggestion = slist.get(i);
                        String content = suggestion.getSuggestion_content();
                        String shortContent = content.length() > 20 ? content.substring(0, 20) + "..." : content;
                %>
                <tr>
                    <!-- 제목 링크 -->
<td>
    <a href="suggestionDetail.jsp?suggestion_idx=<%= suggestion.getSuggestion_idx() %>" class="suggestion-link">
        <%= suggestion.getSuggestion_title() %>
    </a>
</td>
<!-- 내용 링크 -->
<td class="content">
    <a href="suggestionDetail.jsp?suggestion_idx=<%= suggestion.getSuggestion_idx() %>" class="suggestion-link">
        <%= shortContent %>
    </a>
</td>

                </tr>
                <% 
                    } else {
                %>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <% 
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</div>


      <!-- 하단의 넓은 박스 -->
      <div class="table-container">
      휴게소 하나의 음식코너 매출액
      <canvas id="foodcorner-chart" style="width: 100%; height: 50%;"></canvas>
      </div>

      <!-- 하단의 작은 박스들 -->
      <!-- 하단의 작은 박스들 -->
        <div class="text-card-container">
          <div class="text-card" id="sentiment">
             <span>만족도, 감정분석</span>
             <br><br><br><br>
             <div class="sentiment-container">
                 <!-- 1행 3열로 배치된 구역 -->
                 <div class="sentiment-box">
                     <img src="https://drive.google.com/thumbnail?id=1ZBmHr_wDIQgvoaaVU81exfdNec8Lirb0" alt="좋음" class="sentiment-icon">
                     <span class="sentiment-text">좋음</span>
                     <span class="sentiment-text"><%=positive %></span>
                 </div>
                 <div class="sentiment-box">
                     <img src="https://drive.google.com/thumbnail?id=1YDllWL8CIlk4Yq75sz7vODvLK6n9nbOW" alt="보통" class="sentiment-icon">
                     <span class="sentiment-text">보통</span>
                     <span class="sentiment-text"><%=neutral %></span>
                 </div>
                 <div class="sentiment-box">
                     <img src="https://drive.google.com/thumbnail?id=1cHzvZasD_eBy0SqddlphJHvnclIyyWqe" alt="나쁨" class="sentiment-icon">
                     <span class="sentiment-text">나쁨</span>
                     <span class="sentiment-text"><%=negative %></span>
                 </div>
             </div>
         </div>
          <div class="text-card" id="foodPoisonIndex" style="display: block;">
              <div>식중독 지수</div>
              <br>
              <div id="foodPoisonValue">-</div>
          </div>
          
          <div class="text-card" id="ColdPossibility" style="display: block;">
              <div >감기 가능 지수</div>
             <br>
             <div id="ColdData">-</div>
         </div>

          <div class="text-card" id="corruption" style="display: block;">
              <div>부패 가능 지수</div>
              <br>
              <div id="corruptionValue">-</div>
          </div>
          <div class="text-card" id="dustIndex" style="display: block;">
              <div style="width: 100%">미세먼지 지수</div>
              <br>
              <div id="dustValue">-</div>
          </div>
      </div>
   </div>

   <!-- JavaScript 파일 연결 -->
   
   <script type="text/javascript" src="js/jquery.min.js"></script>
   <script type="text/javascript" src="js/manager_weather.js"></script>
   <script type="text/javascript" src="js/manager_poison.js"></script>
   <script type="text/javascript" src="js/manager_dust.js"></script>
   <script type="text/javascript" src="js/manager_prediction_chart.js"></script>
    <script type="text/javascript" src="js/sa_foodcorner.js"></script>

</body>
</html>
