package com.smhrd.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.smhrd.model.ServiceAreaDAO;
import com.smhrd.model.tb_details;

/**
 * Servlet implementation class FacilityServlet
 */
@WebServlet("/getFacility")
public class FacilityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ServiceAreaDAO dao = new ServiceAreaDAO();

		String saName = request.getParameter("restStop");

		// DB에서 시설 정보 조회
		tb_details facilityDetails = dao.getFacility(saName);

		// JSON 형식으로 응답
		response.setContentType("application/json; charset=UTF-8");
        Gson gson = new Gson();
        String jsonResult = gson.toJson(facilityDetails);
        
        PrintWriter out = response.getWriter();
        out.print(jsonResult);
        out.flush();

	}

}
