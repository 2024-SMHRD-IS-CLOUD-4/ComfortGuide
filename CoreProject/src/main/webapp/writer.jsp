<%@page import="com.smhrd.model.tb_admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객의 소리 작성</title>
   
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <style>
        /* 기존 CSS 그대로 유지 */
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f5f5f5;
        }
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
        
        .container {
            display: flex;
            justify-content: left;
            flex-direction: column;
            margin: 50px auto;
            width: 1000px;
            min-height: 600px;
            height:autopx;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .section-title {
            background-color: #d3d3d3;
            padding: 10px;
            border-radius : 5px;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            width: 100%;
            text-align: center;
        }
        .form-group label {
            width: 100px;
            font-weight: bold;
        }
        .form-group input[type="text"],
        .form-group textarea,
        .form-group select {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-group textarea {
            height: 300px;
            resize: vertical;
        }
        .file-input-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .file-input-container label {
            font-weight: normal;
            border: 1px solid #ddd;
            padding: 8px 10px;
            border-radius: 4px;
            background-color: #f0f0f0;
            cursor: pointer;
        }
        .buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }
        .buttons button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background-color: #d3d3d3;
        }
        .buttons button:hover {
            background-color: #b3b3b3;
        }

        .select-group {
            display: flex;
            align-items: center;
            gap: 3px;
            margin-bottom: 15px;
            width: 100%;
        }
    </style>
</head>
<body>
	<!-- 헤더와 메뉴 -->
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

	<div class="container">
		<div class="section-title">고객의 소리</div>
		<form action="suggestionController" method="post">
			<div class="form-group">
				<label for="title">제목</label> <input type="text" id="title"
					name="title" placeholder="Enter title">
			</div>

			<!-- 지역 선택과 휴게소 선택을 같은 줄에 배치 -->
			<div class="form-group select-group">
				<label for="position">휴게소</label>


				<div class="select-group">
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
					</select> <select id="restStop" name="restStop" required>
						<option value="">휴게소 선택</option>
					</select>
				</div>

			</div>


			<div class="form-group">
				<label for="content">내용</label>
				<textarea id="content" name="content" placeholder="내용을 입력하세요"></textarea>
			</div>
			<div class="form-group">
				<label for="image">이미지</label>
				<div class="file-input-container">
					<input type="text" placeholder="선택된 파일 없음" readonly id="file-name">
					<label for="file-upload">파일선택</label> <input type="file"
						id="file-upload" name="image" style="display: none;">
				</div>
			</div>
			<div class="form-group">
				<label for="author">작성자</label> <input type="text" id="author"
					name="author" placeholder="작성자 이름 입력">
			</div>
			<div class="buttons">
				<button type="submit">작성</button>
				<button type="reset">리셋</button>
			</div>
		</form>
	</div>

	<!-- Tesseract.js 라이브러리 추가 -->
	<script
		src="https://cdn.jsdelivr.net/npm/tesseract.js@2.1.4/dist/tesseract.min.js"></script>





	<script>
        document.getElementById('file-upload').addEventListener('change', function() {
            const file = this.files[0];
            const fileNameDisplay = document.getElementById('file-name');
            const contentTextarea = document.getElementById('content');
            
            // 파일명 표시
            fileNameDisplay.value = file ? file.name : "선택된 파일 없음";

            if (file) {
                // Tesseract.js를 사용하여 이미지에서 텍스트 추출
                Tesseract.recognize(file, 'kor', { logger: m => console.log(m) })
                    .then(({ data: { text } }) => {
                        contentTextarea.value = text; // 추출된 텍스트를 컨텐츠 영역에 채움
                    })
                    .catch(error => {
                        console.error("OCR 오류:", error);
                        contentTextarea.value = "텍스트를 추출할 수 없습니다.";
                    });
            }
        });
        
        
    </script>
	<script type="text/javascript" src="js/join_region.js"></script>
</body>
</html>
