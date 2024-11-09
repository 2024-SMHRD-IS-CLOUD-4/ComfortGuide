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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Malgun Gothic', sans-serif; /* 맑은 고딕 폰트 적용 */
            margin: 0;
            background-color: #f5f5f5;
            overflow-x: hidden; 

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
            gap: 10px; /* 전체 요소 사이의 간격을 줄임 */
            padding: 10px;
            max-width: 100vw;
        }

        /* 카드 스타일 */
        .card {
            background-color: #ffffff;
            padding: 10px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }

        /* 개별 섹션 스타일 */
        .video-card { 
            grid-column: 1 / 2; 
            grid-row: 1 / 2; 
            height: 500px; /* 높이 확대 */
        }

        .weather-card {
            grid-column: 1 / 2; 
            grid-row: 2 / 3; 
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 5px; /* 각 항목 사이의 간격 줄이기 */
            background-color: #f9f9f9;
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
            height: 168px;
        }

        .weather-item {
        
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 5px;
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 16px;
            font-weight: bold;
        }

        .weather-item .value {
            font-size: 24px; /* 가운데의 글자 크기를 키움 */
            font-weight: bold;
            margin-top: 10px; /* 상단에 약간의 여백 추가 */
        }

        .facilities-card { 
            grid-column: 2 / 3; 
            grid-row: 1; 
            display: grid; 
            grid-template-columns: repeat(4, 1fr); 
            gap: 5px; /* 요소들 사이의 간격 줄이기 */
            font-size: 14px; 
            height: 350px; /* 기존 크기 유지 */
        }

        .facilities-card .facility {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #ffffff;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            font-size: 14px;
        }

        /* 인기 판매 품목 차트 내부 박스 스타일 */
        .popular-items-chart {
            grid-column: 2 / 3;
            grid-row: 2 / 3; /* 시설물 박스 바로 아래 배치 */
            display: grid;
            grid-template-columns: 1fr 1fr; /* 가로 두 개의 칸으로 나누기 */
            gap: 5px; /* 차트 내부 요소 간격 줄이기 */
            height: 320px; /* 시설물 박스와 동일한 높이로 설정 */
            margin-top: -150px; /* 시설물 박스와의 간격 줄이기 */
        }

        .popular-item-box {
            background-color: #f8f8f8;
            padding: 15px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-size: 15px;
            font-weight: bold;
            height: 280px;
            margin : 5px;
        }
        
		    .popular-item-box-1 {
		    background-color: #f8f8f8;
		    padding: 15px;
		    border: 1px solid #ddd;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		    text-align: center;
		    font-size: 15px;
		    font-weight: bold;
		    height: 280px;
		    margin: 5px;
		    display: flex;
		    flex-direction: column;
		    justify-content: center; /* 세로 가운데 정렬 */
		    align-items: center; /* 가로 가운데 정렬 */
		}
		.popular-item-box-2 {
		    background-color: #f8f8f8;
		    padding: 15px;
		    border: 1px solid #ddd;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		    text-align: center;
		    font-size: 14px; /* 글자 크기 조정 */
		    font-weight: bold; /* 글자 굵기 조정 */
		    font-family: 'Arial', sans-serif; /* 원하는 글꼴로 변경 */
		    color: #333; /* 글자 색상 변경 */
		    height: 280px;
		    margin: 5px;
		    line-height: 1.6; /* 줄 간격 설정, 필요에 따라 조정 가능 */
		}
		.ranking-table {
		    width: 100%; /* 테이블이 부모 요소 너비에 맞게 확장되도록 */
		}
		.ranking-table td {
		    text-align: center; /* 셀 내부 텍스트 중앙 정렬 */
		    padding: 0px; /* 셀 여백 추가 */
		}

        /* 방문후기 박스 스타일 */
        .reviews-card {
            grid-column: 3 / 4;
            grid-row: 1 / 2;
            text-align: center;
            padding: 10px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom : -180px;
        }

        .review-item {
            border: 1px solid #5c7adb;
            padding: 10px;
            margin: 12px 0;
            border-radius: 4px;
            background-color: #f9f9f9;
        }
        .review-item p {
            margin: 4px;
            font-size: 14px;
            font-weight: bold;
        }
        .review-item a {
            font-size: 15px;
            color: #5c7adb;
        }
        #reviews-container {
            flex: 1;
            overflow-y: auto;
            padding-right: 10px;
            max-height: 550px; /* 방문후기 박스 높이에 맞춤 */
        }
        .facility {
            background-color: gray; /* 기본 배경색을 회색으로 지정 */
        }

        /* 비디오 컨테이너 스타일 조정 */
        #videoContainer {
            width: 100%;
            height: calc(100% - 50px); /* 카드 내부에서 제목을 제외한 나머지 영역 차지 */
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden; /* 내용이 카드 안에 완전히 들어가도록 처리 */
        }

        #videoContainer iframe {
            width: 100%;
            height: 100%;
            border: none; /* 프레임의 외곽선 제거 */
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
        <div class="card video-card">
            유튜브 소개 영상
            <div class="video" id="videoContainer"><br>
                <iframe width="560" height="315" src="https://www.youtube.com/embed/<YOUR_VIDEO_ID>" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
        </div>
        
        <!-- 날씨 정보 -->
        <div class="card weather-card" id="weatherInfo">
            <div class="weather-item" id="temperature">
                <span>현재 온도</span><br>
                <span class="value">0°C</span>
            </div>
            <div class="weather-item" id="humidity">
                <span>습도</span><br>
                <span class="value">0%</span>
            </div>
            <div class="weather-item" id="weather_conditions">
                <span>날씨 상태</span><br>
                <span class="value">맑음</span>
            </div>
            <div class="weather-item" id="Precipitation_probability">
                <span>강수 확률</span><br>
                <span class="value">0%</span>
            </div>
        </div>

        <!-- 시설 현황 -->
        <div class="card facilities-card">
            <div id="drugStore" class="facility"><img src="https://drive.google.com/thumbnail?id=1zUvhdqJ3mgITB2tUDFqunzJD4IXNH63q" alt="약국" width="40" height="40"><p>약국</p></div>
            <div id="nursingRoom" class="facility"><img src="https://drive.google.com/thumbnail?id=1YCgZ4I6h9sYdnuhgxrgnKT-D5l0xCSrW" alt="수유실" width="40" height="40"><p>수유실</p></div>
            <div id="evCharge" class="facility"><img src="https://drive.google.com/thumbnail?id=14lyOQD92h0mO3L82dXzkTMNPMmWH3vLK" alt="전기차 충전소" width="40" height="40"><p>전기차 충전소</p></div>
            <div id="restaurant" class="facility"><img src="https://drive.google.com/thumbnail?id=1sKbl8Ra3Lcb5k9HlD01a86oWDUkMyB7_" alt="식당" width="40" height="40"><p>식당</p></div>
            <div id="lpgStation" class="facility"><img src="https://drive.google.com/thumbnail?id=1THlLHjtlqpjR3GS54Mp24Rdf9ayYSfqY" alt="LPG 충전소" width="40" height="40"><p>LPG 충전소</p></div>
            <div id="gasStation" class="facility"><img src="https://drive.google.com/thumbnail?id=1C57wXa6y8RvReK1PFgS45Mkg5YP2WcTP" alt="주유소" width="40" height="40"><p>주유소</p></div>
            <div id="snackBar" class="facility"><img src="https://drive.google.com/thumbnail?id=1t01ExJzTTnEY41Op9QQfMZhVUqySQIOX" alt="편의점" width="40" height="40"><p>편의점</p></div>
            <div id="breakRoom" class="facility"><img src="https://drive.google.com/thumbnail?id=1ySqKu1xZfxaouuJJtJVYtcR7-aYsZVRz" alt="쉼터" width="40" height="40"><p>쉼터</p></div>
            <div id="carMaintenance" class="facility"><img src="https://drive.google.com/thumbnail?id=199hJQ2t9ZPj8iRsUC09g78H9rqy5N8i-" alt="정비소" width="40" height="40"><p>정비소</p></div>
            <div id="hydrogenCharge" class="facility"><img src="https://drive.google.com/thumbnail?id=1WicRWM1wbnCt4-0or43sGE-clYLn4jGg" alt="수소차 충전소" width="40" height="40"><p>수소차 충전소</p></div>
            <div id="restRoom" class="facility"><img src="https://drive.google.com/thumbnail?id=1ZBKdH5fa53a_scX7hxjpiUkER8mi9IFl" alt="화장실" width="40" height="40"><p>화장실</p></div>
            <div class="facility" style="background-color: gray;"><img  width="40" height="40"><p></p></div> <!-- 해당 시설이 없을 시 표시-->
        </div>

        <!-- 인기 판매 품목 차트 나눔 -->
        <div class="card popular-items-chart" id="chartContainer">
        <div class="popular-item-box popular-item-box-1">
            인기 품목 차트 
            <canvas id="donutChart" style="width: 80%; height: 80%;"></canvas>
        </div>
        <div class="popular-item-box popular-item-box-2" id="rankingContainer"></div>
    </div>
        
        <!-- 방문 후기 -->
        <div class="card reviews-card">
            <div>방문후기</div>
            <div id="reviews-container">
                <!-- 방문후기 내용이 표시됩니다. -->
                <p>휴게소 방문 후기 내용이 표시됩니다.</p>
            </div>
        </div>    
    </div>
       
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/sub_review.js"></script>
    <script type="text/javascript" src="js/join_region.js"></script>
    <script type="text/javascript" src="js/sub_weather.js"></script>
    <script type="text/javascript" src="js/sub_facility.js"></script>
    <script type="text/javascript" src="js/sub_video.js"></script>
     <script type="text/javascript" src="js/sub_rank.js"></script>
    
</body>
</html>