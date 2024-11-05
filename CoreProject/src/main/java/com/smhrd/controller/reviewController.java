package com.smhrd.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class searchController
 */
@WebServlet("/reviewController")
public class reviewController extends HttpServlet {
       
	private static final long serialVersionUID = 1L;

    // Flask API 주소
    private static final String API_URL = "http://127.0.0.1:5000/searchTitles";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String restStop = request.getParameter("restStop");

        if (restStop == null || restStop.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "restStop parameter is missing or empty");
            return;
        }

        String apiUrl = API_URL + "?title=" + java.net.URLEncoder.encode(restStop, "UTF-8");
        System.out.println("Requesting Flask API at URL: " + apiUrl);

        try {
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("User-Agent", "Mozilla/5.0");

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder content = new StringBuilder();
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    content.append(inputLine);
                }
                in.close();

                // Flask API의 응답 데이터 확인
                System.out.println("Flask API Response: " + content.toString());

                Gson gson = new Gson();
                Map<String, List<Map<String, String>>> reviewData = gson.fromJson(content.toString(),
                        new TypeToken<Map<String, List<Map<String, String>>>>() {}.getType());

                List<Map<String, String>> reviews = reviewData.get(restStop);
                if (reviews == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "No reviews found for the specified restStop");
                    return;
                }

                response.setContentType("application/json; charset=UTF-8");
                response.getWriter().write(gson.toJson(reviews));
            } else {
                System.err.println("Failed to fetch data from Flask API. Response Code: " + responseCode);
                System.err.println("Response Message: " + connection.getResponseMessage());
                response.sendError(responseCode, "Failed to fetch data from Flask API");
            }
            connection.disconnect();
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request");
            e.printStackTrace();
        }
    }

}
