package com.goodiware.vo;

import java.io.Serializable;
import java.util.UUID;

import lombok.Data;

@Data
public class ChatRoom implements Serializable {
		
	private static final long serialVersionUID = 3804627931209171476L;
	private String roomId;
	private String name;
	private long userCount;
		
	public static ChatRoom create(String name) {
		
		ChatRoom chatRoom = new ChatRoom();
		
		chatRoom.roomId = UUID.randomUUID().toString();
		chatRoom.name = name;
		
		return chatRoom;
		
	}
	
}
