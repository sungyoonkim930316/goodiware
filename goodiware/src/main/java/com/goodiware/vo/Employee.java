package com.goodiware.vo;

import java.awt.List;

import lombok.Data;

@Data
public class Employee {

	private int empno;
	private String id;
	private String pw;
	private String name;
	private String birth;
	private String phone;
	private String add1;
	private String add2;
	private String add3;
	private String joinday;
	private String leaveday;
	private String picture;
	private String intro;
	private boolean deleted;
	
	private int posno;
	private int depno;
	private int authno;
	
}
