package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.smhrd.model.sa_ranking;
import com.smhrd.model.sa_top_rankingDAO;


@WebServlet("/SaRanking")
public class SaRankingController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		sa_top_rankingDAO dao = new sa_top_rankingDAO(); 

		String saName = request.getParameter("restStop");

		// DB에서 시설 정보 조회
		List<sa_ranking> rank = dao.get_sa_top_ranking(saName);
		
		
		System.out.println("Retrieved data: " + rank);

		
		// JSON 형식으로 응답
		response.setContentType("application/json; charset=UTF-8");
        Gson gson = new Gson();
        String jsonResult = gson.toJson(rank);
        
        PrintWriter out = response.getWriter();
        out.print(jsonResult);
        out.flush();
	}

}
