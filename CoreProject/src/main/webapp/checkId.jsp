<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.smhrd.model.ServiceAreaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.smhrd.model.tb_service_area" %>

<%
    // 클라이언트로부터 전송된 아이디를 가져옵니다.
    String id = request.getParameter("id");
    ServiceAreaDAO dao = new ServiceAreaDAO();
    
    // existAdminId 메서드를 호출하여 해당 아이디가 존재하는지 확인합니다.
    boolean exists = dao.existAdminId(id);
    
    // 결과를 클라이언트에 반환합니다.
    out.print(exists); // true or false
%>
