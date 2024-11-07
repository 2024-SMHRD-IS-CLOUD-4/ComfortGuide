<%@page import="com.smhrd.model.tb_admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원정보 수정</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
        }

        /* 전체 컨테이너 */
        .container {
            width: 600px;
            min-height: 800px;
            background-color: #ffffff;
            padding: 40px;
            border: 1px solid #ccc;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        /* 제목 스타일 */
        .title {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 10px;
        }

        /* 설명 텍스트 스타일 */
        .description {
            font-size: 14px;
            color: #666;
            text-align: right;
            margin-bottom: 10px;
        }

        /* 테이블 스타일 */
        .info-table {
            width: 100%;
            border-collapse: collapse;
        }

        .info-table th {
            background-color: #f1f1f1;
            padding: 10px;
            font-weight: bold;
            text-align: left;
            border: 1px solid #ccc;
            width: 25%;
        }

        .info-table td {
            padding: 10px;
            border: 1px solid #ccc;
            width: 75%;
        }

        /* 입력 필드 스타일 */
        .info-table input[type="text"],
        .info-table input[type="password"],
        .info-table select {
            width: calc(100% - 20px);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            height: 36px;
            font-size: 14px;
        }

        /* 휴게소 선택 박스 컨테이너 스타일 */
        .rest-stop-select-container {
            display: flex;
            gap: 10px; /* 두 선택 박스 사이 간격 */
        }

        .rest-stop-select-container select {
            width: 50%; /* 두 선택 박스 너비를 반반씩 */
        }

        /* 필수 항목 표시 스타일 */
        .required {
            color: red;
            margin-left: 5px;
            font-size: 12px;
            vertical-align: middle;
        }

        /* 완료 버튼 스타일 */
        .submit-button {
            display: block;
            width: 70px;
            padding: 12px;
            background-color: #f1f1f1;
            color: #000;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin: 20px auto 0;
            text-align: center;
        }

        .submit-button:hover {
            background-color: #ccc;
        }
    </style>
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
                        <input type="password" placeholder="영문, 숫자 조합 또는 특수기호 조합, 7~12자리" name="pw">
                    </td>
                </tr>
                <tr>
                    <th>비밀번호 확인<span class="required">*</span></th>
                    <td>
                        <input type="password" placeholder="영문, 숫자 조합 또는 특수기호 조합, 7~12자리">
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

</body>
<script type="text/javascript" src="js/join_region.js"></script>
</html>
