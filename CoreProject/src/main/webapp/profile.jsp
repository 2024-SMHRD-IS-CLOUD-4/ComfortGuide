<%@page import="com.smhrd.model.tb_admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    <link rel="stylesheet" type="text/css" href="css/profileCss.css">
</head>
<body>
    <% tb_admin login = (tb_admin)session.getAttribute("login"); %>

    <div class="container">
        <div class="title">회원정보 수정</div>
        <hr>
        <div class="description">입력항목 중 <span class="required">*</span> 표시는 필수 입력사항입니다.</div>
        <form action="profileController" method="post">
            <input type="hidden" name="id" value="<%=login.getAdmin_id()%>">
            <table class="info-table">
                <tr>
                    <th>신규 비밀번호<span class="required">*</span></th>
                    <td>
                        <input type="password" placeholder="신규 비밀번호를 입력하세요." name="pw">
                    </td>
                </tr>
                <tr>
                    <th>비밀번호 확인<span class="required">*</span></th>
                    <td>
                        <input type="password" placeholder="비밀번호 확인을 위해 비밀번호를 한번 더 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <th>주소<span class="required">*</span></th>
                    <td><input type="text" placeholder="주소 입력" value="<%=login.getSa_addr()%>" name="address"></td>
                </tr>
                <tr>
                    <th>전화번호<span class="required">*</span></th>
                    <td><input type="text" value="<%=login.getAdmin_tel()%>" name="tel"></td>
                </tr>
                <tr>
                    <th>직책<span class="required">*</span></th>
                    <td>
                        <select id="position" name="position" required>
                            <option value="">직급 선택</option>
                            <option value="사원">사원</option> 
                            <option value="대리">대리</option>
                            <option value="팀장">팀장</option>
                            <option value="부장">부장</option>
                            <option value="이사">이사</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>휴게소 선택<span class="required">*</span></th>
                    <td>
                        <div class="rest-stop-select-container">
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
                        </div>
                    </td>
                </tr>
            </table>
            <!-- 완료 버튼 -->
            <input class="submit-button" type="submit" value="완료">
        </form>
    </div>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/join_region.js"></script>
</body>
</html>
