package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class tb_service_video {

	String sa_name;
    String video_link;
    
    public String getVideoLink() { 
        return video_link;
    }
}
