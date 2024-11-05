package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.ServiceAreaDAO;
import com.smhrd.model.tb_admin;


@WebServlet("/joinController")
public class joinController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String tel = request.getParameter("tel");
		String sa_name = request.getParameter("restStop");
		String sa_addr = request.getParameter("address");
		String position = request.getParameter("position");
		
		tb_admin admin = new tb_admin(id, pw, tel, sa_name, sa_addr, position);
		ServiceAreaDAO dao = new ServiceAreaDAO();
		dao.insertAdmin(admin);
		
		response.sendRedirect("login.html");
	}

}
