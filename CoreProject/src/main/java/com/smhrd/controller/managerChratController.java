package com.smhrd.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.smhrd.model.tb_admin;


@WebServlet("/managerChratController")
public class managerChratController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	 @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        HttpSession session = request.getSession();
	        tb_admin loginUser = (tb_admin) session.getAttribute("login");

	        if (loginUser == null) {
	            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");
	            return;
	        }

	        String saName = loginUser.getSa_name();

	        response.setContentType("application/json; charset=UTF-8");
	        response.getWriter().write(new Gson().toJson(saName));
	    }
	

}
