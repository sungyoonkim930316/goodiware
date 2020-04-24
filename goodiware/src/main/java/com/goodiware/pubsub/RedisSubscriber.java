package com.goodiware.pubsub;

import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.goodiware.vo.ChatMessage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class RedisSubscriber {

	private final ObjectMapper objectMapper;
	private final SimpMessageSendingOperations messagingTemplate;
	
	// redis에서 메시지가 발행(publish)되면 대기하고있던 onMessage가 해당 메세지를 받아서 처리
	public void sendMessage(String publishMessage) {
		System.out.println("start function sendMessage");
		try {
			
			// ChatMessage 객체로 맵핑
			ChatMessage chatMessage = objectMapper
					.readValue(publishMessage, ChatMessage.class);
			
			// 채팅방을 구독한 클라이언트에게 메시지 발송
			messagingTemplate.convertAndSend("/sub/chat/room/" + chatMessage.getRoomId(), chatMessage);
			
        } catch (Exception e) {
            log.error("Exception {}", e);
        }
    }
	
}
