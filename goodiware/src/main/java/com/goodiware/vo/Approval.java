package com.goodiware.vo;

import java.util.List;

import lombok.Data;

@Data
public class Approval {

	private int type;
	private String title;
	private String content;
	private String apprfilename;
	private String filepath;
	private String companoin;
	
	private int empno;
	private int appdivno;
	private int maccp;
	private int faccp;
	private int appaccpno;
	
//	private List<ApprDiv> ApprDivs;
//	private List<ApproAccp> ApproAccps;
//	private List<Employee> firstEmps;
//	private List<Employee> secondEmps;
//	private List<Employee> thirdEmps;
	
}
