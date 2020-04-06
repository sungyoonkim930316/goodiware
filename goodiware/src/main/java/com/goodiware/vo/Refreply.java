package com.goodiware.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Refreply {

	private int refrno;
	private String replycontent;
	private Date replydate;
	private boolean refdel;
	
}
