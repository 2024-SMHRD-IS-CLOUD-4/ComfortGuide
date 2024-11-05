<!DOCTYPE html>
<%@page import="com.smhrd.model.ServiceAreaDAO"%>
<%@page import="com.smhrd.model.tb_admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>subpage</title>
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
            overflow-x: hidden; /* Prevents horizontal scrolling */
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

        /* 검색 필터 스타일 */
        .search-bar-container {
            display: flex;
            justify-content: flex-end;
            padding: 10px 20px;
            background-color: #f1f1f1;
        }
        .search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .search-bar select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
            font-size: 14px;
            min-width: 120px;
            font-weight: bold;
            text-align: center;
        }
        .search-bar .search-icon {
            width: 30px;
            height: 30px;
            cursor: pointer;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* 대시보드 컨테이너 */
        .dashboard {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr; /* 3등분 */
            gap: 20px;
            padding: 20px;
            max-width: 100vw;
        }

        /* 카드 스타일 */
        .card {
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            
        }

        /* 개별 섹션 스타일 */
        .video-card { 
            grid-column: 1 / 2; 
            grid-row: 1 / 3; /* 높이를 늘려 방문 후기와 유사한 높이로 변경 */
            height: 500px; 
            
        }

        .weather-card {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 1행 4열로 구성 */
            gap: 5px; /* 각 항목 사이의 간격 줄이기 */
            background-color: #f9f9f9;
            padding: 5px; /* 내부 패딩 줄이기 */
            border: 1px solid #ddd;
            text-align: center;
        }

        .weather-item {
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 5px; /* 내부 패딩 줄이기 */
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 14px;
            font-weight: bold;
        }

        .facilities-card { 
            grid-column: 2 / 3; 
            grid-row: 1; 
            display: grid; 
            grid-template-columns: repeat(4, 1fr); 
            gap: 10px; 
            font-size: 14px; 
            height: auto; 
        }

        .facilities-card .facility {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #ffffff; /* 카드 배경색 */
            border: 1px solid #ddd; /* 카드 테두리 */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 카드 그림자 */
            padding: 10px; /* 카드 내부 여백 */
            border-radius: 8px; /* 모서리 둥글게 */
            text-align: center;
            font-size: 14px;
        }

        /* 추가 정보 박스 */
        .additional-info-card {
            grid-column: 2 / 3;
            grid-row: 2;
            background-color: #f0f0f0;
            padding: 10px;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
        }

        /* 인기 판매 품목 차트 내부 박스 스타일 */
        .popular-items-chart {
            grid-column: 2 / 3;
            grid-row: 3;
            display: grid;
            grid-template-columns: 1fr 1fr; /* 가로 두 개의 칸으로 나누기 */
            gap: 10px;
        }

        .popular-item-box {
            background-color: #f8f8f8;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-size: 16px;
            font-weight: normal;
            height: 200px; /* 높이 설정 */
        }

        /* 방문후기 박스 스타일 */
        .reviews-card {
            grid-column: 3 / 4;
            grid-row: 1 / 3;
            text-align: left;
            padding: 10px;
            height: 520px; /* 높이를 줄여 고객의 소리와 일치하도록 조정 */
        }

        /* 고객의 소리 버튼 스타일 */
        .feedback-card {
            grid-column: 3 / 4;
            grid-row: 3;
            height: 100px; /* 고객의 소리 카드 높이를 인기 품목 차트 높이와 일치하도록 설정 */
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #c4d8f7;
            cursor: pointer;
            text-decoration: none; 
            color: inherit; 
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .feedback-card:hover {
            background-color: #c4d8f7; 
        }
        .review-item {
		    border: 1px solid #ddd;
		    padding: 10px;
		    margin: 5px 0;
		    border-radius: 4px;
		    background-color: #f9f9f9;
		}
		.review-item p {
		    margin: 0;
		    font-size: 14px;
		    font-weight: bold;
		}
		.review-item a {
		    font-size: 12px;
		    color: #0073e6;
		}#reviews-container {
		    flex: 1; /* 남은 공간을 채우도록 설정 */
		    overflow-y: auto; /* 수직 스크롤 활성화 */
		    padding-right: 10px; /* 스크롤 바와 내용이 겹치지 않도록 여백 추가 */
		    max-height: 450px; /* 최대 높이 설정 (높이 초과 시 스크롤) */
		}
    </style>
</head>
<body>

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
            <a href="javascript:void(0);" onclick="confirmLogin('adminpage.html')">관리자 페이지</a>
            <a href="javascript:void(0);" onclick="confirmLogin('suggestion.html')">고객의 소리</a>
        </div>
        
        <!-- 사용자 정보와 링크 -->
        <div class="user-info">
            <% if (login != null) { %>
                <span><%= login.getAdmin_id() %> 님</span> 
                <a href="profile.html">회원정보 수정</a> 
                <a href="logout.jsp">로그아웃</a>
            <% } else { %>
                <a href="login.html">로그인</a>
                <a href="Join.html">회원가입</a>
            <% } %>
        </div>
    </div>

    <!-- 검색 필터와 아이콘 -->
    <div class="search-bar-container">
        <div class="search-bar">
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
            <select id="restStop" name="restStop" required>
                <option value="">휴게소 선택</option>
            </select>
            <div class="search-icon">🔍</div>
        </div>
    </div>
    
    <!-- 대시보드 -->
    <div class="dashboard">
        <!-- 유튜브 소개 영상 -->
        <div class="card video-card">유튜브 소개 영상<div class="video">▶</div></div>
        <!-- 날씨 정보 -->
        <div class="card weather-card" id="weatherInfo">
            <div class="weather-item" id="temperature">
                <span>현재 온도:</span>
                <span>0°C</span>
            </div>
            <div class="weather-item" id="humidity">
                <span>습도:</span>
                <span>0%</span>
            </div>
            <div class="weather-item" id="weather_conditions">
                <span>날씨 상태:</span>
                <span>맑음</span>
            </div>
            <div class="weather-item" id="Precipitation_probability">
                <span>강수 확률:</span>
                <span>0%</span>
            </div>
        </div>
        <!-- 시설 현황 -->
        <div class="card facilities-card">
            <div class="facility"><img src="images/drug.png" alt="약국" width="40" height="40"><p>약국</p></div>
            <div class="facility"><img src="images/nursing.png" alt="수유실" width="40" height="40"><p>수유실</p></div>
            <div class="facility"><img src="images/ev.png" alt="전기차 충전소" width="40" height="40"><p>전기차 충전소</p></div>
            <div class="facility"><img src="images/restaurant.png" alt="식당" width="40" height="40"><p>식당</p></div>
            <div class="facility"><img src="images/lpg.png" alt="LPG 충전소" width="40" height="40"><p>LPG 충전소</p></div>
            <div class="facility"><img src="images/gas_station.png" alt="주유소" width="40" height="40"><p>주유소</p></div>
            <div class="facility"><img src="images/snack.png" alt="편의점" width="40" height="40"><p>편의점</p></div>
            <div class="facility"><img src="images/break.png" alt="쉼터" width="40" height="40"><p>쉼터</p></div>
            <div class="facility"><img src="images/car_maintenace.png" alt="정비소" width="40" height="40"><p>정비소</p></div>
            <div class="facility"><img src="images/hydrogen.png" alt="수소차 충전소" width="40" height="40"><p>수소차 충전소</p></div>
            <div class="facility"><img src="images/rest_room.png" alt="화장실" width="40" height="40"><p>화장실</p></div>
        </div>

        <!-- 새로운 추가 상자 -->
        <div class="card additional-info-card">
            추가 정보 박스
        </div>
        
        <!-- 인기 판매 품목 차트 나눔 -->
        <div class="card popular-items-chart">
            <div class="popular-item-box popular-item-box-1">
                인기 품목 차트 1
                <img src="#" alt="chart" style="width: 100%; height: auto;">
            </div>
            <div class="popular-item-box popular-item-box-2">
               text
            </div>
        </div>
        
        <!-- 방문 후기 -->
        <div class="card reviews-card">
            <div>방문후기</div>
            <div id="reviews-container">
                <!-- 방문후기 내용이 여기에 표시됩니다. -->
                <p>여기에 방문후기 내용이 표시됩니다.</p>
            </div>
        </div>
    
        <!-- 고객의 소리 버튼 (링크) -->
        <a href="suggestion.html" class="card feedback-card">고객의 소리</a>
    </div>

    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/sub_review.js"></script>
    <script type="text/javascript" src="js/join_region.js"></script>
    <script type="text/javascript" src="js/sub_weather.js"></script>
</body>
</html>
