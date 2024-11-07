<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.smhrd.model.tb_suggestion"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.ServiceAreaDAO"%>
<%@page import="com.smhrd.model.tb_admin"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>검색페이지</title>
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
        }

        /* Centering container wrapper */
        .center-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 80vh;
            padding-top: 20px;
        }

        .container {
            width: 900px;
            min-height: 600px;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        .section-title {
            background-color: #d3d3d3;
            padding: 10px;
            font-weight: bold;
            text-align: left;
            margin-bottom: 15px;
        }

        .table-container {
            border: 1px solid #ddd;
            padding: 15px;
            background-color: #f9f9f9;
            overflow-y: auto;
            max-height: 600px; /* 스크롤을 위한 최대 높이 설정 */
            position: relative;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 15px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            min-width: 50px;
            white-space: nowrap;
        }

        th {
            background-color: #f0f0f0;
            font-weight: bold;
        }

        /* 제목 열 너비 100% 설정 */
        td:nth-child(2) {
            text-align: left;
            width: 80%;
        }

        /* 버튼 스타일을 테이블 안쪽 오른쪽 하단에 위치 */
        .button-container {
            bottom: 15px;
            right: 15px;
         text-align: right;
            
        }

        .button-container button {
            background-color: #d3d3d3; /* 회색 버튼 색상 */
            color: white;
            padding: 10px 15px;
            font-size: 14px;
            border: none;
            margin-top: 30px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .button-container button:hover {
            background-color: #b3b3b3;
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
               <a href="profile.html">회원정보 수정</a> 
               <a href="logout">로그아웃</a>
           <% } else { %>
               <a href="login.html">로그인</a>
               <a href="Join.html">회원가입</a>
           <% } %>
       </div>
   </div>

   
   <%
      ServiceAreaDAO dao = new ServiceAreaDAO();
      List<tb_suggestion> slist = dao.getSuggestion(login.getSa_name());
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      int rowsToDisplay = 8; // 디폴트로 8줄을 표시
   %>
   

    <!-- Center Wrapper for "고객의 소리" container -->
    <div class="center-wrapper">
        <div class="container">
            <div class="section-title">고객의 소리</div>
            
            <div class="table-container">
               <table>
                   <thead>
                       <tr>
                           <th>번호</th>
                           <th>제목</th>
                           <th>작성자</th>
                           <th>작성일</th>
                       </tr>
                   </thead>
                   <tbody>
                   <% 
                       for (int i = 0; i < rowsToDisplay; i++) {
                           if (i < slist.size()) {
                               tb_suggestion suggestion = slist.get(i);
                   %>
                       <tr>
                           <td><%= suggestion.getSuggestion_idx() %></td>
                           <!-- 제목에 링크 추가 -->
                           <td>
                               <a href="suggestionDetail.jsp?suggestion_idx=<%= suggestion.getSuggestion_idx() %>">
                                   <%= suggestion.getSuggestion_title() %>
                               </a>
                           </td>
                           <td><%= suggestion.getSuggestion_publisher() %></td>
                           <td><%= sdf.format(suggestion.getCreate_at()) %></td>
                       </tr>
                   <% 
                           } else {
                   %>
                       <tr>
                           <td colspan="4">&nbsp;</td>
                       </tr>
                   <% 
                           }
                       }
                   %>
               </tbody>

               </table>
           </div>
           <div class="button-container" style="display: block;">
                   <button onclick="location.href='writer.jsp'">글 작성</button>
               </div>    
           
        </div>
    </div>

</body>
</html>
