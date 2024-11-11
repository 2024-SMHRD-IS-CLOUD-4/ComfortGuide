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
    <link rel="stylesheet" type="text/css" href="css/detailCss.css">
    
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
        <a href="subpage.jsp">휴게소 검색</a>
         <a href="writer.jsp">글 작성</a>
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
