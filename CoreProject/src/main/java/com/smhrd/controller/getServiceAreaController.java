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


@WebServlet("/getServiceArea")
public class getServiceAreaController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String restStopName = request.getParameter("restStop");

        ServiceAreaDAO dao = new ServiceAreaDAO();
        tb_service_area serviceArea = dao.getServiceAreaBySaName(restStopName); // lat, lon을 포함하는 객체 반환

        if (serviceArea != null) {
            response.setContentType("application/json; charset=UTF-8");
            String json = new Gson().toJson(serviceArea);
            response.getWriter().write(json);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Service Area not found");
        }

	}

}
