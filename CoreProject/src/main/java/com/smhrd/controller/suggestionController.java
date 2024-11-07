package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smhrd.model.ServiceAreaDAO;
import com.smhrd.model.tb_suggestion;

/**
 * Servlet implementation class suggestionController
 */
@WebServlet("/suggestionController")
public class suggestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String suggestion_title = request.getParameter("title");
		String suggestion_content = request.getParameter("content");
		String sa_name = request.getParameter("restStop");
		String suggestion_publisher = request.getParameter("author");
		
		tb_suggestion suggestion = new tb_suggestion(suggestion_title, suggestion_content, sa_name, suggestion_publisher);
		
		ServiceAreaDAO dao = new ServiceAreaDAO();
		dao.insertSuggestion(suggestion);
		
		response.sendRedirect("mainPage.jsp");
	}

}
