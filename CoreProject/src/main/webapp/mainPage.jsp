<%@page import="com.smhrd.model.tb_admin"%>
<%@page import="com.smhrd.model.RegionalTourismGrowth"%>
<%@page import="com.smhrd.model.TourismStats"%>
<%@page import="java.net.URI"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.IOException"%>
<%@page import="com.smhrd.model.domestic_trips"%>
<%@page import="com.smhrd.model.TripDAO"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="com.smhrd.model.tb_service_area"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.ServiceAreaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de8ae99dd87927fe3467ec1335a0120d&libraries=services"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
         <a href="mainPage.jsp" class="active">메인 페이지</a> <a
            href="subpage.html">검색 페이지</a> <a href="manager.html">관리자 페이지</a> <a
            href="suggestion.html">고객의 소리</a>
      </div>
      

        <!-- 사용자 정보와 링크 -->
      <div class="user-info">
      <%tb_admin login = (tb_admin)session.getAttribute("login"); 
      if(login!=null){
      %>
      
         <span><%=login.getAdmin_id() %> 님</span> 
         <a href="profile.html">회원정보 수정</a> 
         <a href="login.html">로그아웃</a>
      <%}else{ %>
         <a href="login.html">로그인</a>
         <a href="Join.html">회원가입</a>
      <%} %>
      </div>
      
   </div>

   <!-- 대시보드 컨테이너 -->
   <div class="container">
      <!-- 왼쪽 섹션 -->
      <div class="left-section">
         <div id="map">지도</div>


         <div class="table-card" id="table-card">
            <h3>이벤트 중인 휴게소</h3>
            <table>
               <thead>
                  <tr>
                     <th>휴게소 이름</th>
                     <th>이벤트 기간</th>
                     <th>이벤트 내용</th>
                  </tr>
               </thead>
               <tbody>
                  <tr>
                     <td>용인 휴게소</td>
                     <td></td>
                     <td></td>
                  </tr>
                  <tr>
                     <td>이천 휴게소</td>
                     <td></td>
                     <td></td>
                  </tr>
                  <tr>
                     <td>기흥 휴게소</td>
                     <td></td>
                     <td></td>
                  </tr>
               </tbody>
            </table>
         </div>
      </div>
      <%
      String url2 = "http://localhost:5000/searchOil".trim();
      HttpURLConnection con = null;
      BufferedReader in = null;
      StringBuffer responseData = new StringBuffer();
      double one = 0.0;
      double two = 0.0;
      double three = 0.0;
      double four = 1103.6;
      double five = 0.0;
      double six = 0.0;
      try {
         URI uri = new URI(url2); // URI 객체를 먼저 생성
         URL obj = uri.toURL();
         con = (HttpURLConnection) obj.openConnection();
         con.setRequestMethod("GET");

         // HTTP 응답 코드 확인
         int responseCode = con.getResponseCode();
         if (responseCode == HttpURLConnection.HTTP_OK) { // 200 OK
            in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;

            while ((inputLine = in.readLine()) != null) {
         responseData.append(inputLine);
            }

            // JSON 파싱
            JSONObject jsonResponse = new JSONObject(responseData.toString());
            one = jsonResponse.getDouble("고급휘발유");
            two = jsonResponse.getDouble("휘발유");
            three = jsonResponse.getDouble("경유");
            four = jsonResponse.getDouble("등유");
            five = jsonResponse.getDouble("LPG");
            six = jsonResponse.getDouble("전기충전소");

         } else {
            System.out.println("HTTP 요청 실패, 응답 코드: " + responseCode);
         }
      } catch (Exception e) {
         System.out.println("HTTP 요청 중 예외 발생: " + e.getMessage());
         e.printStackTrace(); // 오류 로그 출력
      } finally {
         try {
            if (in != null)
         in.close();
            if (con != null)
         con.disconnect();
         } catch (IOException ex) {
            System.out.println("스트림 또는 연결 닫기 중 오류 발생: " + ex.getMessage());
            ex.printStackTrace();
         }
      }
      %>

      <%
      TripDAO dao2 = new TripDAO();
      List<domestic_trips> result = dao2.getTrips();
      int result2 = 0;
      for (int i = 0; i < result.size(); i++) {
         result2 += result.get(i).getCount();
      }
      %>


      <!-- 오른쪽 섹션 -->
      <div class="right-section">
         <div class="title-box">주유가격</div>
         <div class="price-container">
            <div class="box high-quality">
               고급 휘발유 <br><%=one%></div>
            <div class="box regular">
               휘발유<br>
               <%=two%></div>
            <div class="box diesel">
               경유<br>
               <%=three%></div>
            <div class="box kerosene">
               등유<br>
               <%=four%></div>
            <div class="box lpg">
               LPG<br>
               <%=five%></div>
            <div class="box electric">
               전기충전소<br>
               <%=six%></div>
      <%
         List<TourismStats> tourRate = dao2.getAllTourism();
      
         int year = 0;
         int last = 0;
         for (int i = 0; i < tourRate.size(); i++) {
             year += tourRate.get(i).getVisitorCount();
             last += tourRate.get(i).getVisitorCountLastYear();
         }
   
         // year와 last 출력 (확인용)
         System.out.println("Total Visitor Count (year): " + year);
         System.out.println("Total Last Year Visitor Count (last): " + last);
   
         double rateByTour = 0.0;
         if (last != 0) {
             rateByTour = ((double)(year - last) / last) * 100;
             System.out.printf("토탈 증감률: %.2f%%\n", rateByTour);
         }
          rateByTour = Math.round(((double)(year - last) / last) * 100 * 100) / 100.0;
          
          List<RegionalTourismGrowth> growth = dao2.getAllTourismGrowth();
          
      %>


            <div class="title-box">임시</div>
            <div class="stats-container">
            <div class="box total-travelers">
               국내 총 여행객 수<br><%=result2%></div>
            
            <div class=box top-locations">
                방문자 증가율 Top 3 
                <br>1. <%= growth.get(0).getRegion() + " " %> <%= String.format("%.1f", growth.get(0).getTourismGrowthRate()) %>% 
                <br>2. <%= growth.get(1).getRegion() + " " %> <%= String.format("%.1f", growth.get(1).getTourismGrowthRate()) %>% 
                <br>3. <%= growth.get(2).getRegion() + " " %> <%= String.format("%.1f", growth.get(2).getTourismGrowthRate()) %>% 
            </div>



         </div>

         <div class="chart-card">
            그래프
            <canvas id="myChart"></canvas>
         </div>
      </div>
   </div>



   <script>
        // 데이터 추출
        const labels = [
          <%for (int i = 0; i < result.size(); i++) {
            String tripName = result.get(i).getRegion();
            out.print("'" + tripName + "'");
            if (i < result.size() - 1)
               out.print(","); // 콤마 추가
         }%>
         ];

      const data = [
          <%for (int i = 0; i < result.size(); i++) {
            domestic_trips trip = result.get(i);
            int count = trip.getCount();
            out.print(count);
            if (i < result.size() - 1)
               out.print(","); // 콤마 추가
         }%>
      ];        
    </script>
   <script type="text/javascript" src="js/main_bar.js"></script>
   <%
      ServiceAreaDAO dao = new ServiceAreaDAO();
      List<tb_service_area> getArea = dao.getServiceArea();
   %>


   <script>
      var positions = [
          <%for (int i = 0; i < getArea.size(); i++) {
         String name = getArea.get(i).getSa_name().replace("(", " 휴게소(").replace(")", " 방향)");
         double lat = Double.parseDouble(String.format("%.6f", getArea.get(i).getLat()));
         double lon = Double.parseDouble(String.format("%.6f", getArea.get(i).getLon()));%>
          {
              title: '<%=name%>',
              latlng: new kakao.maps.LatLng(<%=lat%>, <%=lon%>),
              content: '<div class="wrap"><div class="info"><div class="title"><%=name%><div class="close" onclick="closeOverlay()" title="닫기"></div></div><div class="body"><div>휴게소 종류 : <%=getArea.get(i).getSa_type()%></div><div class="desc"><div class="ellipsis">주소 : <%=getArea.get(i).getSa_addr()%></div></div></div></div></div>'
          }<%if (i < getArea.size() - 1) {%>,<%}%>
          <%}%>
      ];
</script>

   <script src="js/main_event.js"></script>
   <script src="js/map_js.js"></script>

</body>
</html>