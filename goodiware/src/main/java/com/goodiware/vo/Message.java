package com.goodiware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Message {

	private int mno;
	private String title;
	private String content;
	private Date opendate;
	private Date senddate;
	private boolean deleted;
	
	private Employee sender;
	private Employee receiver;
}
