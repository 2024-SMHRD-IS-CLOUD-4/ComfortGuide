package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.smhrd.model.ServiceAreaDAO;
import com.smhrd.model.tb_service_area;
import com.smhrd.model.tb_service_video;

@WebServlet("/LinkController")
public class LinkController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String restStopName = request.getParameter("restStop");
	    System.out.println("Requested restStop: " + restStopName); // 요청된 restStopName 확인

	    ServiceAreaDAO dao = new ServiceAreaDAO();
	    tb_service_video video = dao.getLink(restStopName);
	    
	    if (video != null) {
	        response.setContentType("application/json; charset=UTF-8");
	        String json = new Gson().toJson(video);
	        System.out.println("Response JSON: " + json); // JSON 응답 확인
	        response.getWriter().write(json);
	    } else {
	        System.out.println("Video not found for restStop: " + restStopName); // 비디오가 없을 경우 메시지 확인
	        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Service Area not found");
	    }
	}

}
