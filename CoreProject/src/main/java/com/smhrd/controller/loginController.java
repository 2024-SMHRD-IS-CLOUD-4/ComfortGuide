package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.ServiceAreaDAO;
import com.smhrd.model.tb_admin;

@WebServlet("/loginController")
public class loginController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		tb_admin temp = new tb_admin(id, pw);
		ServiceAreaDAO dao = new ServiceAreaDAO();
		tb_admin result = dao.login(temp);
		
		HttpSession session = request.getSession();
		if(result!=null) {
			session.setAttribute("login", result);
			response.sendRedirect("mainPage.jsp");
		}else {
			response.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    out.println("<script>alert('아이디 또는 비밀번호가 틀립니다!'); location.href='login.html';</script>");
		    out.flush();
		}
	}

}
