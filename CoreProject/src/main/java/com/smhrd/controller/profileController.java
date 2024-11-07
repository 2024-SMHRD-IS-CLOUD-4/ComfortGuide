package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.ServiceAreaDAO;
import com.smhrd.model.tb_admin;

@WebServlet("/profileController")
public class profileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		

		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String tel = request.getParameter("tel");
		String sa_name = request.getParameter("restStop");
		String sa_addr = request.getParameter("address");
		String position = request.getParameter("position");
		
		tb_admin admin = new tb_admin(id,pw, tel, sa_name, sa_addr, position);
		ServiceAreaDAO dao = new ServiceAreaDAO();
		int updateResult = dao.updateProfile(admin);
		
		HttpSession session = request.getSession();
		session.removeAttribute("login");
		
		if (updateResult > 0) { // 업데이트가 성공한 경우
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>");
            response.getWriter().println("alert('회원정보 수정이 완료되었습니다! 다시 로그인 해주세요.');");
            response.getWriter().println("window.location.href = 'login.html';"); // 수정 완료 후 메인 페이지로 리다이렉트
            response.getWriter().println("</script>");
        } else {
            // 업데이트 실패 시 처리 (예: 에러 메시지 표시 및 로그인 페이지로 리다이렉트)
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().println("<script>");
            response.getWriter().println("alert('회원정보 수정에 실패했습니다. 다시 시도해주세요.');");
            response.getWriter().println("window.location.href = 'profile.jsp';"); // 다시 수정 페이지로 이동
            response.getWriter().println("</script>");
        }
    }
	
}
