package com.smhrd.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class tb_suggestion {
	
	Integer  suggestion_idx;
    String suggestion_title;
	String suggestion_content;
    String sa_name;
    String suggestion_publisher;
    Timestamp create_at;
    
    
    public tb_suggestion(String suggestion_title, String suggestion_content, String sa_name,
    		String suggestion_publisher) {
    	this.suggestion_idx = null;
    	this.suggestion_title = suggestion_title;
    	this.suggestion_content = suggestion_content;
    	this.sa_name = sa_name;
    	this.suggestion_publisher = suggestion_publisher;
    	this.create_at = Timestamp.valueOf(LocalDateTime.now());
    }
    public Integer getSuggestion_idx() {
        return suggestion_idx;
    }
    
    
}
