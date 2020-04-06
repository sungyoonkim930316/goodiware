package com.goodiware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Schedule {

	private int scheno;
	private String title;
	private String content;
	private Date startdate;
	private Date enddate;
	
}
