package com.goodiware.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Reply {

	private int rno;
	private String rcontent;
	private Date rdate;
	private boolean brdel;
	private int empno;
	private int bNo;
	private String name;
	private int gno;
	
	private List<Employee> employees;
	private List<Board> boards;
}
