package com.goodiware.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

import com.goodiware.handler.StompHandler;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration
@EnableWebSocketMessageBroker
public class WebSockConfig implements WebSocketMessageBrokerConfigurer {

	private final StompHandler stompHandler;
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		
		System.out.println("start function configureMessageBroker");
		
		config.enableSimpleBroker("/sub");
		config.setApplicationDestinationPrefixes("/pub");
		
	}
	
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		
		System.out.println("start function registerStompEndpoints");
		
		registry.addEndpoint("/ws-stomp").setAllowedOrigins("*").withSockJS();
		
	}

	@Override
	public void configureClientInboundChannel(ChannelRegistration registration) {
		
		System.out.println("start function configureClientInboundChannel");
		
		registration.interceptors(stompHandler);
		
	}
	
}
