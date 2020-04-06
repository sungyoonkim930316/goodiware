package com.goodiware.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Board {

	private int bno;
	private String title;
	private String content;
	private Date regdate;
	private boolean bdel;
	
	private List<Employee> employees;
	private List<BoardDiv> boardDivs;
}
