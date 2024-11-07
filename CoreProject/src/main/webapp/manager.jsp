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
   <div class="container">
      <!-- 차트 영역 -->
      <div class="chart-card">차트 영역 (빈 공간)</div>

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
         <div class="info-sales-card info-card"></div>
         <div class="info-guests-card info-card"></div>
         <div class="info-traffic-card info-card"></div>
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
                    <td> <a href="suggestionDetail.jsp?suggestion_idx=<%= suggestion.getSuggestion_idx() %>"><%= suggestion.getSuggestion_title() %></a></td>
                    <td class="content"><a href="suggestionDetail.jsp?suggestion_idx=<%= suggestion.getSuggestion_idx() %>"><%= shortContent %></a></td>
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
      <div class="table-container">휴게소 하나의 음식코너 매출액</div>

      <!-- 하단의 작은 박스들 -->
      <!-- 하단의 작은 박스들 -->
        <div class="text-card-container">
          <div class="text-card" id="sentiment">
             <span>만족도, 감정분석</span>
             <br><br><br><br>
             <div class="sentiment-container">
                 <!-- 1행 3열로 배치된 구역 -->
                 <div class="sentiment-box">
                     <img src="images/good.png" alt="좋음" class="sentiment-icon">
                     <span class="sentiment-text">좋음</span>
                     <span class="sentiment-text"><%=positive %></span>
                 </div>
                 <div class="sentiment-box">
                     <img src="images/middle.png" alt="보통" class="sentiment-icon">
                     <span class="sentiment-text">보통</span>
                     <span class="sentiment-text"><%=neutral %></span>
                 </div>
                 <div class="sentiment-box">
                     <img src="images/bad.png" alt="나쁨" class="sentiment-icon">
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
   <script>
    // CSV 데이터 경로
    const csvFilePath = 'path/to/한국도로공사_휴게소_이용객_통행량_매출액.csv';

    // CSV 파일을 불러와서 특정 휴게소 데이터를 필터링하는 함수
    async function fetchAndDisplayChartData() {
        const response = await fetch(csvFilePath);
        const data = await response.text();
        const csvData = parseCSV(data);

        // 휴게소 명이 selectedRestAreaName과 일치하는 데이터만 필터링
        const filteredData = csvData.filter(row => row['휴게소명'] === selectedRestAreaName);

        // 2015~2023 연도별 임의 데이터 설정 및 2024 실제 데이터
        const years = [2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023];
        const annualUsage = [40000, 42500, 39000, 41000, 45000, 32000, 31000, 30000, 35500]; // 2020-2022 하향
        const annualTraffic = [40000, 43100, 42000, 43000, 45000, 34000, 31200, 33800, 35800]; // 2020-2022 하향
        const annualRevenue = [40000, 41000, 42000, 43000, 44000, 37000, 35210, 38240, 43000]; // 2020-2022 하향

        // 2024년 데이터는 CSV에서 가져온 실제 값 사용
        const data2024 = filteredData.find(row => row['연도'] === '2024');
        if (data2024) {
            years.push(2024);
            annualUsage.push(parseInt(data2024['연간 이용객 수']));
            annualTraffic.push(parseInt(data2024['연간 차량 통행량']));
            annualRevenue.push(parseInt(data2024['연간 매출액(원)']));
        }

        // 예측 모델을 사용하여 2025~2030 데이터 예측
        const futureYears = [2025, 2026, 2027, 2028, 2029, 2030];
        const predictedUsage = predictFutureData(years, annualUsage, futureYears);
        const predictedTraffic = predictFutureData(years, annualTraffic, futureYears);
        const predictedRevenue = predictFutureData(years, annualRevenue, futureYears);

        // 차트 카드에 canvas 요소 추가
        const chartCard = document.querySelector('.chart-card');
        const canvas = document.createElement('canvas');
        canvas.id = 'adminChart';
        chartCard.appendChild(canvas);

        // Chart.js를 이용한 차트 생성
        const ctx = canvas.getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: years.concat(futureYears),
                datasets: [
                    {
                        label: '이용객 수',
                        data: annualUsage.concat(predictedUsage),
                        borderColor: 'blue',
                        fill: false
                    },
                    {
                        label: '차량 통행량',
                        data: annualTraffic.concat(predictedTraffic),
                        borderColor: 'green',
                        fill: false
                    },
                    {
                        label: '매출액(원)',
                        data: annualRevenue.concat(predictedRevenue),
                        borderColor: 'red',
                        fill: false
                    }
                ]
            },
            options: {
                title: {
                    display: true,
                    text: `Annual Data with Predictions for ${selectedRestAreaName}`
                },
                scales: {
                    x: { title: { display: true, text: 'Year' }},
                    y: { title: { display: true, text: 'Value' }}
                }
            }
        });
    }

    // 간단한 선형 회귀 모델을 사용하여 미래 데이터 예측 함수
    function predictFutureData(years, values, futureYears) {
        // regression-js를 사용하여 선형 회귀 모델 생성
        const regressionData = years.map((year, index) => [year, values[index]]);
        const result = regression.linear(regressionData);
        const gradient = result.equation[0];
        const intercept = result.equation[1];

        // 미래 연도에 대해 예측 값 생성
        return futureYears.map(year => gradient * year + intercept);
    }

    // CSV 데이터를 JSON으로 변환하는 함수
    function parseCSV(data) {
        const rows = data.split('\n').slice(1); // 첫 번째 줄 제거 (헤더)
        const csvData = rows.map(row => {
            const columns = row.split(',');
            return {
                '휴게소명': columns[0],
                '연도': columns[1],
                '연간 이용객 수': columns[2],
                '연간 차량 통행량': columns[3],
                '연간 매출액(원)': columns[4]
            };
        });
        return csvData;
    }

    // 차트 데이터를 가져와서 표시
        fetchAndDisplayChartData().catch(error => {
    console.error('Error fetching or displaying chart data:', error);
});
   </script>
   <script type="text/javascript" src="js/jquery.min.js"></script>
   <script type="text/javascript" src="js/manager_weather.js"></script>
   <script type="text/javascript" src="js/manager_poison.js"></script>
   <script type="text/javascript" src="js/manager_dust.js"></script>

</body>
</html>
