package com.smhrd.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
import com.smhrd.model.ServiceAreaDAO;
import com.smhrd.model.tb_service_area;

@WebServlet("/insertContoller")
public class insertContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String filePath1 = "C:\\Users\\smhrd\\Desktop\\Coding\\core_project_test\\csv\\total_service_area_data.csv";
		String filePath2 = "C:\\Users\\smhrd\\Desktop\\Coding\\core_project_test\\csv\\rest_human_total.csv";

		try (CSVReader reader = new CSVReader(new InputStreamReader(new FileInputStream(filePath1), "EUC-KR"))) {
				String[] nextLine2;
				String[] nextLine;
				reader.skip(1); // 헤더를 건너뛰기
				ServiceAreaDAO dao = new ServiceAreaDAO();
				// 데이터 29개
				while ((nextLine = reader.readNext()) != null) {
					try (CSVReader reader2 = new CSVReader(new InputStreamReader(new FileInputStream(filePath2), "EUC-KR"))) {
						reader2.skip(1);
					
					while ((nextLine2 = reader2.readNext()) != null) {

						String sa_name = nextLine[0]; // 휴게소명
						String sa_type = nextLine[7]; // 휴게소종류
						double lat = Double.parseDouble(nextLine[5]); // 위도
						double lon = Double.parseDouble(nextLine[6]); // 경도
						String sa_name2 = nextLine2[1];
						String sa_addr = nextLine2[2];
						String sa_img1 = "";
						String sa_img2 = "";
						String sa_img3 = "";

						Timestamp created_at = Timestamp.valueOf(LocalDateTime.now());
						Timestamp updated_at = Timestamp.valueOf(LocalDateTime.now());
						if (sa_name2.equals(sa_name)) {
							if (dao.existServiceArea(sa_name2).isEmpty()) {
								dao.insertServiceArea(new tb_service_area(sa_name2, sa_type, sa_addr, lat, lon, sa_img1,
										sa_img2, sa_img3, created_at, updated_at));
							}
						}
					}
				}catch (IOException | CsvValidationException e) {
					e.printStackTrace();
				} 
			}
			}catch (IOException | CsvValidationException | NumberFormatException e) {
				e.printStackTrace();}


	}
	
}
