<!DOCTYPE html>
<%@page import="com.smhrd.model.tb_admin"%>
<%@page import="com.smhrd.model.tb_service_area"%>
<%@page import="com.smhrd.model.ServiceAreaDAO"%>
<%@page import="com.smhrd.model.RegionalTourismGrowth"%>
<%@page import="com.smhrd.model.TourismStats"%>
<%@page import="com.smhrd.model.domestic_trips"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.TripDAO"%>
<%@page import="java.io.IOException"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URI"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="ko">
<head>
<script
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=de8ae99dd87927fe3467ec1335a0120d&libraries=services"></script>
   <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>mainpage</title>
    <link rel="stylesheet" type="text/css" href="css/mainCss.css">
    
</head>
<body>
    <%
      String url2 = "http://localhost:5000/searchOil".trim();
      HttpURLConnection con = null;
      BufferedReader in = null;
      StringBuffer responseData = new StringBuffer();
      double one = 0.0;
      double two = 0.0;
      double three = 0.0;
      double four = 1103.6;
      double five = 1307.99;
      double six = 1016.68;
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
            //four = jsonResponse.getDouble("등유");
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


    


	<% tb_admin login = (tb_admin)session.getAttribute("login"); %>

	<script type="text/javascript">
	    function confirmLogin(page) {
	        <% if (login == null) { %>
	            alert("로그인이 필요한 서비스입니다!");
	            window.location.href = "login.html";
	        <% } else { %>
	            window.location.href = page;
	        <% } %>
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
	        <% if (login != null) { %>
	            <span><%= login.getAdmin_id() %> 님</span> 
	            <a href="profile.jsp">회원정보 수정</a> 
	            <a href="logout">로그아웃</a>
	        <% } else { %>
	            <a href="login.html">로그인</a>
	            <a href="Join.html">회원가입</a>
	        <% } %>
	    </div>
	</div>

    <!-- 대시보드 컨테이너 -->
    <div class="container">
        <!-- 왼쪽 섹션 -->
        <div class="left-section">
        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="검색어를 입력하세요">
            <button onclick="searchMarker()">검색</button>
        </div>
        <div class="content">
            <div class="map-container" id="map">지도</div>
            <div id="map-side">
            <select id="region" name="region" required>
                <option value="">지역 선택</option>
                <option value="강원">강원</option>
                <option value="경기">경기</option>
                <option value="전남">전남</option>
                <option value="전북">전북</option>
                <option value="충남">충남</option>
                <option value="충북">충북</option>
                <option value="경남">경남</option>
                <option value="경북">경북</option>
                <option value="제주">제주</option>
            </select>

            <div class="marker-list-container" id="markerList"></div>
            </div>
        </div>
    </div>

        <!-- 오른쪽 섹션 -->
        <div class="right-section">
            <div class="large-card" id="gas">
                <h2 class="title-with-line">주유 가격</h2>
                <br>
                <div class="fuel-price-card">
                    <div class="price-item">
                        <div class="label">고급 휘발유</div>
                        <div class="price"><%=one %>원</div>
                    </div>
                    <div class="price-item">
                        <div class="label">휘발유</div>
                        <div class="price"><%=two %>원</div>
                    </div>
                    <div class="price-item">
                        <div class="label">경유</div>
                        <div class="price"><%=three %>원</div>
                    </div>
                    <div class="price-item">
                        <div class="label">LPG</div>
                        <div class="price"><%=four %>원</div>
                    </div>
                    <div class="price-item">
                        <div class="label">등유</div>
                        <div class="price"><%=five %>원</div>
                    </div>
                    <div class="price-item">
                        <div class="label">전기충전소</div>
                        <div class="price"><%=six %>원</div>
                    </div>
                </div>
            </div>
            <div class="chart-text-wrapper">
                <div class="chart-text">
                <strong>관광 지출액 수 증감률</strong>
                <br>
                <br><h2><%=rateByTour %>%<span class="b_triangle-up"></span></h2>
                </div>
                <div class="chart-text">
                <strong>방문자 증가율 Top 3</strong><br>

                <br>1위 <%= growth.get(0).getRegion() %> <span class="triangle-up"></span> <%= String.format("%.1f", growth.get(0).getTourismGrowthRate()) %>%
           		<br>2위 <%= growth.get(1).getRegion() %> <span class="triangle-up"></span> <%= String.format("%.1f", growth.get(1).getTourismGrowthRate()) %>%
            	<br>3위 <%= growth.get(2).getRegion() %> <span class="triangle-up"></span> <%= String.format("%.1f", growth.get(2).getTourismGrowthRate()) %>%
                
                </div>
            </div>
            
            
        </div>
        <div style="display: flex;">
        <div class="table-card" id="table-card">
                <h2>이벤트 중인 휴게소</h2>
                <br>
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
        <div>
        <div class="chart-card">
       <h2 class="title-with-line">이용자별 국내여행 횟수</h2>
        		<br><br><br>
                <canvas id="myChart"></canvas>
            </div>
           </div>
    </div>
    <%
      ServiceAreaDAO dao = new ServiceAreaDAO();
      List<tb_service_area> getArea = dao.getServiceArea();
   %>
   <script type="text/javascript">
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
    ];     </script>

   <script>
	   var positions = [
	       <%for (int i = 0; i < getArea.size(); i++) {
	      String name = getArea.get(i).getSa_name().replace("(", " 휴게소(").replace(")", " 방향)");
	      double lat = Double.parseDouble(String.format("%.6f", getArea.get(i).getLat()));
	      double lon = Double.parseDouble(String.format("%.6f", getArea.get(i).getLon()));%>
	       {
	           title: '<%=name%>',
	           latlng: new kakao.maps.LatLng(<%=lat%>, <%=lon%>),
	           region: '<%= getArea.get(i).getSa_addr().split(" ")[0] %>', // 지역을 주소의 첫 번째 단어로 추출
	           content: '<div class="wrap"><div class="info"><div class="title"><%=name%><div class="close" onclick="closeOverlay()" title="닫기"></div></div><div class="body"><div>휴게소 종류 : <%=getArea.get(i).getSa_type()%></div><div class="desc"><div class="ellipsis">주소 : <%=getArea.get(i).getSa_addr()%></div></div></div></div></div>'
	       }<%if (i < getArea.size() - 1) {%>,<%}%>
	       <%}%>
	   ];
	</script>
   <script type="text/javascript" src="js/main_bar.js"></script>
   <script type="text/javascript" src="js/map_js.js"></script>
   <script type="text/javascript" src="js/main_event.js"></script>
   
</body>
</html>
