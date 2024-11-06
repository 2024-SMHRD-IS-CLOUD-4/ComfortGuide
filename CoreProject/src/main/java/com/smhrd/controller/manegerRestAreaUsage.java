package com.smhrd.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smhrd.model.tb_admin;

/**
 * Servlet implementation class manegerRestAreaUsage
 */
@WebServlet("/manegerRestAreaUsage")
public class manegerRestAreaUsage extends HttpServlet {
	private static final long serialVersionUID = 1L;


	   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Retrieve sa_name directly from the tb_admin instance (no DAO required)
	        HttpSession session = request.getSession();
	        tb_admin admin = (tb_admin) session.getAttribute("admin");  // Assume admin is set in session
	        String saName = admin.getSa_name();  // Get sa_name from tb_admin

	        // Generate graph using the sa_name and obtain the path to the graph image
	        String imagePath = generateGraphForSA(saName);

	        // Store the image path in session and redirect to JSP
	        session.setAttribute("imagePath", imagePath);
	        response.sendRedirect("manager.jsp");
	    }

	    // Method to call Python script with sa_name and retrieve generated graph path
	    private String generateGraphForSA(String saName) {
	        String imagePath = null;
	        try {
	            // Call Python script with sa_name as argument
	            ProcessBuilder processBuilder = new ProcessBuilder("python", "path/to/Administrator_Page_Predicted_data.py", saName);
	            Process process = processBuilder.start();

	            // Read output from Python script (image path)
	            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
	            imagePath = reader.readLine();  // Read the graph image path from script output

	            process.waitFor();  // Wait for the script to finish
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return imagePath;
	    }


}
