package com.goodiware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Commute {

	private int comno;
	private Date attendance;	// 출근시간
	private Date quitting; 		// 퇴근시간
	
}
