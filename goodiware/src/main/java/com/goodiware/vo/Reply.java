package com.goodiware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Reply {

	private int Rno;
	private String Rcontent;
	private Date Rdate;
	private boolean brdel;
}
