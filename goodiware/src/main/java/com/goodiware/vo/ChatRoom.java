package com.goodiware.vo;

import java.io.Serializable;
import java.util.UUID;

import lombok.Data;

@Data
public class ChatRoom implements Serializable {
	
	public static final long serialVersionUID = 6494678977089006639L;
	
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
