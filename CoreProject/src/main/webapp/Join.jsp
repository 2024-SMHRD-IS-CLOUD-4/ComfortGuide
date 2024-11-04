<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="css/joinCss.css">
    <script>
        function updateRestStops() {
            var regionSelect = document.getElementById("region");
            var restStopSelect = document.getElementById("restStop");
            var selectedRegion = regionSelect.value;

            // 휴게소 목록 데이터 (예시)
            var restStops = {
                "전남": ["곡성(순천)","곡성(천안)","백양사(순천)","백양사(천안)","섬진강(순천)","섬진강(부산)","함평나비(광주)","함평나비(무안)",
                	"함평천지(목포)","함평천지(서울)","황전(순천)","황전(완주)","보성녹차(순천)","보성녹차(영암)"],
                "전북": ["춘향(순천)", "부산 휴게소 2"]
            };

            // 이전 선택지 제거
            restStopSelect.innerHTML = "";

            // 선택된 지역에 따라 휴게소 추가
            if (selectedRegion in restStops) {
                restStops[selectedRegion].forEach(function(restStop) {
                    var option = document.createElement("option");
                    option.value = restStop; // 휴게소 이름을 value로 설정
                    option.textContent = restStop;
                    restStopSelect.appendChild(option);
                });
            }
        }
    </script>
</head>
<body>

    <div class="container">
        <div class="title">Comfort Guide</div>
        <div class="tabs">
            <a href="login.html" class="tab">로그인</a>
            <div class="tab active">회원가입</div>
        </div>
        <form action="joinController" method="post">
            <div class="input-group">
                <input type="text" placeholder="아이디" name="id" id="id" required>
                <input type="password" placeholder="비밀번호" name="pw" id="pw" required>
                <input type="password" placeholder="비밀번호 확인" id="pw_true" required>
                <input type="text" placeholder="전화번호" name="tel" id="tel" required>
                
                <!-- 지역 선택 -->
                <select id="region" onchange="updateRestStops()" required>
                    <option value="">지역 선택</option>
                    <option value="전남">전남</option>
                    <option value="전북">전북</option>
                </select>
                
                <!-- 휴게소 선택 -->
                <select id="restStop" name="restStop" required>
                    <option value="">휴게소 선택</option>
                </select>

                <!-- 직급 선택 -->
                <select id="position" name="position" required>
                    <option value="">직급 선택</option>
                    <option value="사원">사원</option>
                    <option value="대리">대리</option>
                    <option value="팀장">팀장</option>
                    <option value="부장">부장</option>
                    <option value="이사">이사</option>
                </select>

                <input type="text" placeholder="주소" name="address" id="address" required>
            </div>
            <input type="submit" class="submit-button" value="완료">
        </form>
    </div>

</body>
</html>
