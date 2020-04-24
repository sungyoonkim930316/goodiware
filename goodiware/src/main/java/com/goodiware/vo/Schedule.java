package com.goodiware.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonFormatTypes;

import lombok.Data;

@Data
public class Schedule {

	private int scheno;
	private String title;
	private String content;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy/MM/dd hh:mm")
	private Date startdate;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy/MM/dd hh:mm")
	private Date enddate;
	
	private int schedivno;
	private int empno;
	private String sctitle;
	
	private List<Schdiv> schdivs;
	private List<Employee> employees;
	
}
