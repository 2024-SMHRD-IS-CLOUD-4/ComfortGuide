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
	<link rel="stylesheet" type="text/css" href="css/writerCss.css">
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
   <script src="https://cdn.jsdelivr.net/npm/tesseract.js@2.1.4/dist/tesseract.min.js"></script>
   <script type="text/javascript" src="js/writer_result.js"></script>
   <script type="text/javascript" src="js/join_region.js"></script>
   <script type="text/javascript" src="js/writer_true.js"></script>
</body>
</html>
