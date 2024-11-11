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
    <link rel="stylesheet" type="text/css" href="css/suggestionCss.css">

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
            <a href="subpage.jsp">휴게소 검색</a>
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
                                <!-- 제목에 링크 추가, 링크의 스타일을 조정 -->
                                <td>
                                    <a href="suggestionDetail.jsp?suggestion_idx=<%= suggestion.getSuggestion_idx() %>" class="title-link">
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
