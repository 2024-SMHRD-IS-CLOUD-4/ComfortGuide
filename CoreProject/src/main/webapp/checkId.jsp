<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.smhrd.model.ServiceAreaDAO" %>

<%
    // 클라이언트로부터 전송된 아이디를 가져옴
    String id = request.getParameter("id");

    ServiceAreaDAO dao = new ServiceAreaDAO();
    boolean exists = dao.existAdminId(id);

    System.out.println("중복 확인 결과 (true: 존재, false: 없음): " + exists); // 콘솔 로그로 확인
    out.print(exists ? "true" : "false");
%>
