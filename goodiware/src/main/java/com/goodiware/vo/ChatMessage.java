package com.goodiware.vo;

import lombok.Builder;
import lombok.Data;

@Data
public class ChatMessage {

	public ChatMessage() {
		
	}
	
	@Builder
	public ChatMessage(MessageType type, String roomId, String sender, String message, long userCount) {
		
		this.type = type;
		this.roomId = roomId;
		this.sender = sender;
		this.message = message;
		this.userCount = userCount;
		
	}
	
	
	public enum MessageType {
		ENTER, QUIT, TALK
	}
	
	private MessageType type; // 메세지 타입
	private String roomId; // 방번호
	private String sender; // 메세지 보낸사람
	private String message; // 메세지
	private long userCount; // 채팅방 인원 수, 채팅방 내에서 메세지가 전달될때 인원 수 갱신
}
