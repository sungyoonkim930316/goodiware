package com.goodiware.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Reference {

	private int refno;
	private String refname;
	private String refcontent;
	private Date refdate;
	private String reffilename;
	private String refpath;
	private boolean refdel;
	
	private int empno;
	private String name;
	
	private List<Employee> employees;
}
