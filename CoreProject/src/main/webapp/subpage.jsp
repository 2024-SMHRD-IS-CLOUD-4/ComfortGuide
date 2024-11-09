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
    <link rel="stylesheet" type="text/css" href="css/subpageCss.css">
    
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