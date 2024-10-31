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
import com.smhrd.model.tb_details;
import com.smhrd.model.tb_service_area;

@WebServlet("/insertContoller")
public class insertContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		setIsFacility();
		setServiceArea();
	}

	public void setIsFacility() {
		String filePath1 = "C:\\Users\\smhrd\\Desktop\\Coding\\core_project_test\\csv\\total_service_area_data.csv";
		String filePath2 = "C:\\Users\\smhrd\\Desktop\\Coding\\core_project_test\\csv\\hydrogen_car.csv";

		ServiceAreaDAO dao = new ServiceAreaDAO();
		try (CSVReader reader = new CSVReader(new InputStreamReader(new FileInputStream(filePath1), "EUC-KR"))) {
			String[] nextLine;
			String[] nextLine2;

			reader.skip(1);
			while ((nextLine = reader.readNext()) != null) {
				String sa_name = nextLine[0];
				int parking_space = Integer.parseInt(nextLine[11]);
				String is_car_maintenance = nextLine[12];
				String is_gas_station = nextLine[13];
				String is_lpg_station = nextLine[14];
				String is_ev_charge = nextLine[15];
				String is_break_room = nextLine[17];
				String is_rest_room = nextLine[18];
				String is_drug_store = nextLine[19];
				String is_nursinng_room = nextLine[20];
				String is_snack_bar = nextLine[21];
				String is_restaurant = nextLine[22];
				String is_hydrogen_charge = "N"; // 기본값은 "N"
				Timestamp created_at = Timestamp.valueOf(LocalDateTime.now());

				// 두 번째 CSV 파일을 먼저 열기
				try (CSVReader reader2 = new CSVReader(
						new InputStreamReader(new FileInputStream(filePath2), "EUC-KR"))) {
					reader2.skip(1);
					boolean hasHydrogenCharge = false; // 하이드로겐 충전소 여부 확인용 플래그

					while ((nextLine2 = reader2.readNext()) != null) {
						// 하이드로겐 충전소가 발견되면 플래그를 true로 설정
						if (nextLine2[4].equals("O") && nextLine2[0].equals(sa_name)) {
							hasHydrogenCharge = true; // 해당 휴게소에 하이드로겐 충전소 있음
							break; // 하이드로겐 충전소가 발견되면 루프 종료
						}
					}

					// 하이드로겐 충전소 여부에 따라 is_hydrogen_charge 설정
					if (hasHydrogenCharge) {
						is_hydrogen_charge = "Y";
					}

					// 디버깅: is_hydrogen_charge의 값을 출력
					System.out.println("Service Area: " + sa_name + ", Hydrogen Charge: " + is_hydrogen_charge);

					// 중복 데이터 존재 여부 체크 후 데이터 삽입
					if (dao.existDetails(sa_name).isEmpty()) {
						dao.insertDetails(new tb_details(sa_name, parking_space, is_car_maintenance, is_gas_station,
								is_lpg_station, is_ev_charge, is_break_room, is_rest_room, is_drug_store,
								is_nursinng_room, is_snack_bar, is_restaurant, is_hydrogen_charge, created_at));
					}
				} catch (Exception e) {
					e.printStackTrace(); // 예외 처리
				}
			}
		} catch (IOException | CsvValidationException e) {
			e.printStackTrace(); // 예외 처리
		}
	}

	public void setServiceArea() {

		String filePath1 = "C:\\Users\\smhrd\\Desktop\\Coding\\core_project_test\\csv\\total_service_area_data.csv";
		String filePath2 = "C:\\Users\\smhrd\\Desktop\\Coding\\core_project_test\\csv\\rest_human_total.csv";

		try (CSVReader reader = new CSVReader(new InputStreamReader(new FileInputStream(filePath1), "EUC-KR"))) {
			String[] nextLine2;
			String[] nextLine;
			reader.skip(1); // 헤더를 건너뛰기
			ServiceAreaDAO dao = new ServiceAreaDAO();
			// 데이터 29개
			while ((nextLine = reader.readNext()) != null) {
				try (CSVReader reader2 = new CSVReader(
						new InputStreamReader(new FileInputStream(filePath2), "EUC-KR"))) {
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
						if (dao.existServiceArea(sa_name).isEmpty()) {
							dao.insertServiceArea(new tb_service_area(sa_name, sa_type, sa_addr, lat, lon, sa_img1,
									sa_img2, sa_img3, created_at, updated_at));
						}

					}
				} catch (IOException | CsvValidationException e) {
					e.printStackTrace();
				}
			}
		} catch (IOException | CsvValidationException | NumberFormatException e) {
			e.printStackTrace();
		}

	}

}
