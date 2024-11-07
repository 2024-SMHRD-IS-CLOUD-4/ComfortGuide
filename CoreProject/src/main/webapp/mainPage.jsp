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
    
    <style>
        /* 기본 스타일 */
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            font-family: 'Malgun Gothic', sans-serif; /* 맑은 고딕 폰트 적용 */
            font-style: normal;
		
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
        /* 빨간색 삼각형 추가 스타일 */
   
   		.b_triangle-up {
		    display: inline-block;
		    width: 0;
		    height: 0;
		    margin-left: 5px; /* 텍스트와 삼각형 사이의 여백 */
		    border-left: 8px solid transparent;
		    border-right: 8px solid transparent;
		    border-bottom: 13px solid red; /* 빨간색 삼각형 */
		    vertical-align: middle; /* 텍스트 가운데 정렬 */
		    position: relative; /* 위치를 조정하기 위해 relative 사용 */
		    top: -2px; /* 위로 2px 이동 */
		}
		.triangle-up {
		    display: inline-block;
		    width: 0;
		    height: 0;
		    border-left: 6px solid transparent;
		    border-right: 6px solid transparent;
		    border-bottom: 10px solid red; /* 빨간색 삼각형 */
		    vertical-align: middle; /* 텍스트 가운데 정렬 */
		    position: relative; /* 위치를 조정하기 위해 relative 사용 */
		    top: -2px; /* 위로 2px 이동 */
		}
		.triangle-down {
		    display: inline-block;
		    width: 0;
		    height: 0;
		    margin-left: 5px; /* 텍스트와 삼각형 사이의 여백 */
		    border-left: 6px solid transparent;
		    border-right: 6px solid transparent;
		    border-top: 10px solid blue; /* 빨간색 삼각형 */
		    vertical-align: middle; /* 텍스트 가운데 정렬 */
		    position: relative; /* 위치를 조정하기 위해 relative 사용 */
		    top: -2px; /* 위로 2px 이동 */
		}


        /* 대시보드 컨테이너 */
        .container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            padding: 20px;
        }

        .left-section, .right-section {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .search-bar {
		    width: 100%;
		    display: flex;
		    gap: 10px;
		    margin-bottom: 10px;
		}
		
		.search-bar input {
		    flex: 1;
		    padding: 8px;
		    font-size: 16px;
		}
		
		.search-bar button {
		    padding: 8px 16px;
		    font-size: 16px;
		}
		
		.content {
		    display: flex;
		    height: 570px; /* 전체 높이 설정 */
		}
		
		.map-container {
		    width: 70%; /* 지도 70% */
		    height: 100%;
		    background-color: #f9f9f9;
		    border: 1px solid #ddd;
		}
		
		.marker-list-container {
		    width: 30%; /* 리스트 30% */
		    height: 100%;
		    overflow-y: auto;
		    background-color: #ffffff;
		    border: 1px solid #ddd;
		    padding: 10px;
		}
		
		.marker-list-container ul {
		    list-style-type: none;
		    padding: 0;
		    margin: 0;
		}
		
		.marker-list-container ul li {
		    padding: 10px;
		    border-bottom: 1px solid #ddd;
		    cursor: pointer;
		}
		
		.marker-list-container ul li:hover {
		    background-color: #efefef;
		}
       #gas{
       		height: 480px;
       }

        /* 큰 카드 스타일 */
        .large-card {
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            height: 400px;
            display: flex;
            flex-direction: column;
            justify-content: start; /* 변경 */
        }
        #map{
        	height:570px;
        }

        /* 주유 가격 제목 간격 조절 */
        .large-card h2 {
            margin: 0; /* 제목과 박스 사이 간격 제거 */
            font-size: 24px;
            font-weight: bold;
            color: #333;
            padding-bottom: 10px; /* 약간의 간격 추가 */
        }

        /* 주유 가격 카드 스타일 */
        .fuel-price-card {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 10px; /* 간격을 줄임 */
            margin-top: 0; /* 주유 가격 카드의 상단 여백 제거 */
        }

        /* price-item을 두 개의 네모로 나눔 */
        .price-item {
            height: 40%;
            display: flex;
            width: 48%;
            background-color:#faf67f;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            font-size: 18px;
            margin-top: 22px;
        }

        .price-item .label, .price-item .price {
            width: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px;
        }

        .price-item .label {
            background-color: #fffb90;
            
        }

        .price-item .price {
            background-color: #ffffff;
            color: #333;
        }

        /* 텍스트 카드 스타일 */
        .text-cards {
            display: flex;
            justify-content: space-between;
            gap: 10px;
        }
        .text-card {
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
            font-size: 17px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            flex: 1;
            ;
        }

        /* 표 스타일 */
        .table-card {
            background-color: #ffffff;
            padding: 20px;
            height: 600px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            text-align: center
            
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
        .chart-text {
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
            font-size: 16px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            width: 50%; /* 1행 2열을 위해 */
            height: 150px;
        }

        /* 차트 카드 스타일 */
        .chart-card {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd;
            text-align: center;
            font-size: 18px;
            height: 600px;
        }

        /* 설명 카드 래퍼 */
        .chart-text-wrapper {
            display: flex;
            gap: 10px;
        }
		.wrap * {
		    padding: 0;
		    margin: 0;
		}
		
		.wrap .info {
		    width: 350px;
		    height: 120px;
		    border-radius: 5px;
		    border-bottom: 2px solid #ccc;
		    border-right: 1px solid #ccc;
		    overflow: hidden;
		    background: #fff;
		    font-size: 15px;
		    text-align: left;
		}
		
		.wrap .info:nth-child(1) {
		    border: 0;
		    box-shadow: 0px 1px 2px #888;
		}
		
		.info .title {
		    padding: 5px 0 0 10px;
		    height: 30px;
		    background: #eee;
		    border-bottom: 1px solid #ddd;
		    font-size: 18px;
		    font-weight: bold;
		}
			/* 주유 가격 제목 스타일 */
			.title-with-line {
			    margin: 0;
			    font-size: 24px;
			    font-weight: bold;
			    color: #333;
			    padding-bottom: 10px; /* 텍스트와 선 사이 간격 */
			    border-bottom: 2px solid #ccc; /* 밑줄 추가 */
			    display: inline-block;
			    width: calc(100% - 20px); /* 왼쪽과 오른쪽 padding에 맞춘 너비 */
			}
		
		.info .close {
		    position: absolute;
		    top: 10px;
		    right: 10px;
		    color: #888;
		    width: 17px;
		    height: 17px;
		    background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
		}
		
		.info .close:hover {
		    cursor: pointer;
		}
		
		.info .body {
		    position: relative;
		    margin: 13px 0 0 0; /* 왼쪽 여백 제거 */
		    overflow: hidden;
		    padding: 0 10px; /* padding 추가 */
		}
		
		.info .desc {
		    position: relative;
		    height: auto; /* 높이를 자동으로 조정 */
		}
		
		.desc .ellipsis {
		    overflow: hidden;
		    text-overflow: ellipsis;
		    white-space: normal; /* 줄바꿈 허용 */
		}
		
		.desc .jibun {
		    font-size: 11px;
		    color: #888;
		    margin-top: -2px;
		}
		
		.info .img {
		    position: absolute;
		    top: 6px;
		    left: 5px;
		    width: 73px;
		    height: 71px;
		    border: 1px solid #ddd;
		    color: #888;
		    overflow: hidden;
		}
		
		.info:after {
		    content: '';
		    position: absolute;
		    margin-left: -12px;
		    left: 50%;
		    bottom: 0;
		    width: 22px;
		    height: 12px;
		    background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
		}
		
		.info .link {
		    color: #5085BB;
		}
		th:nth-child(1) {
            width: 130px;
        }

        th:nth-child(3) {
            width: 110px;
        }
   
    </style>
    
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
	        <!-- 로그인 체크가 필요한 링크 -->
	        <a href="javascript:void(0);" onclick="confirmLogin('manager.jsp')">관리자 페이지</a>
	        <a href="javascript:void(0);" onclick="confirmLogin('suggestion.jsp')">고객의 소리</a>
	    </div>
	    
	    <!-- 사용자 정보와 링크 -->
	    <div class="user-info">
	        <% if (login != null) { %>
	            <span><%= login.getAdmin_id() %> 님</span> 
	            <a href="profile.html">회원정보 수정</a> 
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
            <div class="marker-list-container" id="markerList"></div>
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
