package com.goodiware.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Refreply {

	private int refrno;
	private String replycontent;
	private Date replydate;
	private boolean refrdel;
	private int refno;
	private int empno;
	private String name;
	private int gno;
	private int sno;
	private int depth;
	
	private List<Employee> employees;
	private List<Reference> references;
	
}
