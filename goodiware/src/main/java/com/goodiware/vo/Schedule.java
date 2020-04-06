package com.goodiware.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Schedule {

	private int scheno;
	private String title;
	private String content;
	private Date startdate;
	private Date enddate;
	
	private List<Schdiv> schdivs;
	private List<Employee> employees;
	
}
