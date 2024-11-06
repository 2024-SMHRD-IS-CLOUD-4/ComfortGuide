package com.smhrd.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.smhrd.model.ServiceAreaDAO;
import com.smhrd.model.tb_admin;
import com.smhrd.model.tb_service_area;

@WebServlet("/getWeather")
public class getWeatherController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션에서 로그인된 사용자 정보 가져오기
        HttpSession session = request.getSession();
        tb_admin loginUser = (tb_admin) session.getAttribute("login");

        // 로그인된 사용자 정보가 있는지 확인
        if (loginUser == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요합니다.");
            return;
        }

        // 로그인한 사용자의 서비스 구역 이름 가져오기
        String saName = loginUser.getSa_name();

        // DAO 객체 생성 및 서비스 구역 정보 조회
        ServiceAreaDAO dao = new ServiceAreaDAO();
        tb_service_area serviceArea = dao.getServiceAreaBySaName(saName);

        // JSON 응답 준비
        response.setContentType("application/json; charset=UTF-8");

        if (serviceArea != null) {
            // 서비스 구역 정보가 있을 경우 JSON으로 변환하여 응답
            String json = new Gson().toJson(serviceArea);
            response.getWriter().write(json);
        } else {
            // 서비스 구역 정보를 찾지 못한 경우 404 에러 전송
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Service Area not found");
        }
    }
}
