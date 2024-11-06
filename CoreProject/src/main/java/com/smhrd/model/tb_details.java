package com.smhrd.model;


import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;


@Getter
public class tb_details {

	public tb_details(String sa_name, int parking_space, String is_car_maintenance, String is_gas_station,
			String is_lpg_station, String is_ev_charge, String is_break_room, String is_rest_room, String is_drug_store,
			String is_nursinng_room, String is_snack_bar, String is_restaurant, String is_hydrogen_charge,
			Timestamp created_at) {
		super();
		this.sa_name = sa_name;
		this.parking_space = parking_space;
		this.is_car_maintenance = is_car_maintenance;
		this.is_gas_station = is_gas_station;
		this.is_lpg_station = is_lpg_station;
		this.is_ev_charge = is_ev_charge;
		this.is_break_room = is_break_room;
		this.is_rest_room = is_rest_room;
		this.is_drug_store = is_drug_store;
		this.is_nursing_room = is_nursing_room;
		this.is_snack_bar = is_snack_bar;
		this.is_restaurant = is_restaurant;
		this.is_hydrogen_charge = is_hydrogen_charge;
		this.created_at = created_at;
	}
	String sa_name;
	int parking_space;	
	String is_car_maintenance;
	String is_gas_station;
	String is_lpg_station;
	String is_ev_charge;
	String is_break_room;
	String is_rest_room;
	String is_drug_store;
	String is_nursing_room;
	String is_snack_bar;
	String is_restaurant;
	String is_hydrogen_charge;
	Timestamp created_at;
	
}
