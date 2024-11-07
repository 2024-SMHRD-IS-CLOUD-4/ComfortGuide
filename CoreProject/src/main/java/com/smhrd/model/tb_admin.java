package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class tb_admin {

	String admin_id;
    String admin_pw;
    String admin_tel;
    String sa_name;
    String sa_addr;
    String admin_position;
    
    public tb_admin(String admin_id, String admin_pw) {
    	this.admin_id = admin_id;
    	this.admin_pw = admin_pw;
    }

	public tb_admin(String admin_pw, String admin_tel, String sa_name, String sa_addr, String admin_position) {

		this.admin_pw = admin_pw;
		this.admin_tel = admin_tel;
		this.sa_name = sa_name;
		this.sa_addr = sa_addr;
		this.admin_position = admin_position;
	}
    
    
}
	