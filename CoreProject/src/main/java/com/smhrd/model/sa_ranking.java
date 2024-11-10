package com.smhrd.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class sa_ranking {
	
	String base_ym;
	int os_ranking;
	int sa_sr;
	String sa_code;
	String sa_name;
	int store_code;
	String store_name;
	int monthly_sales;
	

	public sa_ranking(String sa_name) {
		super();
		this.sa_name = sa_name;
	}
	
	public sa_ranking(int monthly_sales, int sa_sr, String store_name) {
        this.monthly_sales = monthly_sales;
        this.sa_sr = sa_sr;
        this.store_name = store_name;
    }
	
	
}
