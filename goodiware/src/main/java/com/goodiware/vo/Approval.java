package com.goodiware.vo;

import java.util.List;

import lombok.Data;

@Data
public class Approval {

	private int type;
	private String title;
	private String filename;
	private String filepath;
	private String companoin;
	
	private List<ApprDiv> ApprDivs;
	private List<ApproAccp> ApproAccps;
	private List<Employee> firstEmps;
	private List<Employee> secondEmps;
	private List<Employee> thirdEmps;
	
}
