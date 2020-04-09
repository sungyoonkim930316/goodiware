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
	
	private int sender;
	private int receiver;
	
	private String sendid;		// DB조회 시, employee테이블의 id를 조회하여 저장하는 필드
	private String receiveid;	// 메일 전송 시, jsp에서 receiver를 저장하여 receiver의 empno를 조회하는 역할
	private String sendName;
	
	private String name;
	private String id;
	
}
