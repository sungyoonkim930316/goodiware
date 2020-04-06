package com.goodiware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Board {

	private int bno;
	private String title;
	private String content;
	private Date regdate;
	private boolean bdel;
}
