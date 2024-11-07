<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.smhrd.model.ServiceAreaDAO"%>
<%@page import="com.smhrd.model.tb_admin"%>
<%@page import="com.smhrd.model.tb_suggestion"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 상세보기</title>
    <style>
        /* CSS 스타일 */
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
            width: 900px;
            min-height: 500px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ddd;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .section-title {
            background-color: #d3d3d3;
            padding: 10px;
            font-weight: bold;
            text-align: center;
            border-radius: 5px;
            margin-bottom: 20px;
        }
       .detail-field {
		    margin-bottom: 25px;
		    font-size: 16px;   
		    display: flex; /* 내용과 상자를 수평 정렬하기 위해 플렉스 속성 추가 */
		    align-items: center;
		}
		
		.detail-field span {
		    font-weight: bold;
		    display: inline-block;
		    width: 100px;
		    text-align: center;
		    margin-right: 15px; /* 박스와 제목 사이 간격 추가 */
		}
        .detail-box {
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 8px;
            background-color: #fafafa;
            display: inline-block;
            width: 100%; 
            height: 50px; 
            overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
            white-space: nowrap; /* 한 줄로 표시 */
            text-overflow: ellipsis; /* 넘칠 경우 말줄임 표시 */
        }
        .buttons {
            text-align: center;
        }
        .buttons a {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            background-color: #d3d3d3;
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .buttons a:hover {
            background-color: #b3b3b3;
        }
    </style>
</head>
<body>

<% 
    tb_admin login = (tb_admin) session.getAttribute("login");
%>

<div class="header">
    <div class="logo">Comfort Guide</div>
</div>

<div class="menu">
    <div>
        <a href="mainPage.jsp" class="active">메인 페이지</a>
        <a href="subpage.jsp">검색 페이지</a>
        <a href="javascript:void(0);" onclick="confirmLogin('manager.jsp')">관리자 페이지</a>
        <a href="javascript:void(0);" onclick="confirmLogin('suggestion.jsp')">고객의 소리</a>
    </div>
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
    <div class="section-title">글 상세보기</div>

    <%
        int suggestion_idx = Integer.parseInt(request.getParameter("suggestion_idx"));
        ServiceAreaDAO dao = new ServiceAreaDAO();
        tb_suggestion suggestion = dao.getSuggestionByIdx(suggestion_idx);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    %>

    <div class="detail-field">
        <span>제목</span><br> <div class="detail-box"><%= suggestion.getSuggestion_title() %></div>
    </div>
    <div class="detail-field">
        <span>작성자</span> <div class="detail-box"><%= suggestion.getSuggestion_publisher() %></div>
    </div>
    <div class="detail-field">
        <span>작성일</span> <div class="detail-box"><%= sdf.format(suggestion.getCreate_at()) %></div>
    </div>
    <div class="detail-field">
        <span>내용</span> 
        <div class="detail-box" style="height: 100px; overflow: auto; white-space: normal;">
            <p><%= suggestion.getSuggestion_content().replaceAll("\n", "<br>") %></p>
        </div>
    </div>

    <div class="buttons">
        <% if (login != null) { %>
            <a href="suggestion.jsp">목록으로 돌아가기</a>
        <% } else { %>
            <a href="mainPage.jsp">메인으로 돌아가기</a>
        <% } %>
    </div>
</div>

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

</body>
</html>
