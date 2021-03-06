package com.goodiware.service;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.stereotype.Service;

import com.goodiware.repository.ChatRoomRepository;
import com.goodiware.vo.ChatMessage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service("chatService")
public class ChatService {

	private final ChannelTopic channelTopic;
	private final RedisTemplate<String, Object> redisTemplate;
	private final ChatRoomRepository chatRoomRepository;
	
	// destination 정보에서 roomId 추출
	public String getRoomId(String destination) {
		System.out.println("start function getRoomId destination is : " + destination);
		int lastIndex = destination.lastIndexOf("/");
		if(lastIndex != -1) 
			return destination.substring(lastIndex + 1);
		else 
			return "";
		
		
	}
	
	// 채팅방에 메세지 발송
	public void sendChatMessage(ChatMessage chatMessage) {
		System.out.println("start function sendChatMessage ChatMessage is : " + chatMessage);
		
        chatMessage.setUserCount(chatRoomRepository.getUserCount(chatMessage.getRoomId()));
        if (ChatMessage.MessageType.ENTER.equals(chatMessage.getType())) {
        	
        	System.out.println("들어온 놈 : " + chatMessage.getSender());
        	
            chatMessage.setMessage(chatMessage.getSender() + "님이 방에 입장했습니다.");
            chatMessage.setSender("[알림]");
            
        } else if (ChatMessage.MessageType.QUIT.equals(chatMessage.getType())) {
        	
        	System.out.println("나간 놈 : " + chatMessage.getSender());
        	
        	chatMessage.setMessage(chatMessage.getSender() + "님이 방에서 나갔습니다.");
            chatMessage.setSender("[알림]");
            
        }
        
        redisTemplate.convertAndSend(channelTopic.getTopic(), chatMessage);
        
    }
	
	
	
}
