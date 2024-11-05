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
import com.smhrd.model.ServiceAreaDAO;
import com.smhrd.model.tb_service_area;


@WebServlet("/getRestStops")
public class GetRestStopsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String region = request.getParameter("region");

        // DAO를 사용하여 지역에 해당하는 휴게소 이름 리스트 가져오기
        ServiceAreaDAO dao = new ServiceAreaDAO();
        List<String> restStops = dao.getAddrByRegion(region);

        // JSON 형식으로 응답
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Gson을 사용하여 List<String>을 JSON으로 변환
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(restStops);
        out.print(jsonResponse);
        out.flush();
    }
}
