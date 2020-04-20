package com.goodiware.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class Schedule {

	@JsonInclude(JsonInclude.Include.NON_DEFAULT)
	private int scheno;
	@JsonInclude(JsonInclude.Include.NON_DEFAULT)
	private String title;
	@JsonInclude(JsonInclude.Include.NON_DEFAULT)
	private String content;
	@JsonInclude(JsonInclude.Include.NON_DEFAULT)
	private Date startdate;
	@JsonInclude(JsonInclude.Include.NON_DEFAULT)
	private Date enddate;
	
	@JsonInclude(JsonInclude.Include.NON_DEFAULT)
	private int schedivno;
	@JsonInclude(JsonInclude.Include.NON_DEFAULT)
	private int empno;
	@JsonInclude(JsonInclude.Include.NON_DEFAULT)
	private String sctitle;
	
	private List<Schdiv> schdivs;
	private List<Employee> employees;
	
}
