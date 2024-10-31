package com.smhrd.model;

import java.sql.Timestamp;

import lombok.Getter;

@Getter
public class tb_service_area {
	String sa_name;
	String sa_type;
	String sa_addr;
	double lat;
	double lon;
	String sa_img1;
	String sa_img2;
	String sa_img3;
	Timestamp created_at;
	Timestamp updated_at;
	
	public tb_service_area(String sa_name, String sa_type, String sa_addr, double lat, double lon, String sa_img1,
			String sa_img2, String sa_img3, Timestamp created_at, Timestamp updated_at) {
		this.sa_name = sa_name;
		this.sa_type = sa_type;
		this.sa_addr = sa_addr;
		this.lat = lat;
		this.lon = lon;
		this.sa_img1 = sa_img1;
		this.sa_img2 = sa_img2;
		this.sa_img3 = sa_img3;
		this.created_at = created_at;
		this.updated_at = updated_at;
	}
	public tb_service_area(String sa_name, String sa_type, String sa_addr, double lat, double lon) {
		super();
		this.sa_name = sa_name;
		this.sa_type = sa_type;
		this.sa_addr = sa_addr;
		this.lat = lat;
		this.lon = lon;
	}
	
	public Timestamp getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Timestamp updated_at) {
		this.updated_at = updated_at;
	}
}
