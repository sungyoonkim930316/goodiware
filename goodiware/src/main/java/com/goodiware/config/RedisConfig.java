package com.goodiware.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.listener.ChannelTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;
import org.springframework.data.redis.listener.adapter.MessageListenerAdapter;
import org.springframework.data.redis.repository.configuration.EnableRedisRepositories;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import com.goodiware.pubsub.RedisSubscriber;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Configuration
//new
@EnableRedisRepositories

public class RedisConfig {

	//new
	@Value("${spring.redis.host}")
    private String redisHost;
	//new
    @Value("${spring.redis.port}")
    private int redisPort;
	
	// 단일 topic 사용을 위한 Bean설정
	@Bean
	public ChannelTopic channelTopic() {
		return new ChannelTopic("chatroom");
	}
	
	// redis에 발행(publish)된 메세지 처리를 위한 리스너 설정
	@Bean
	public RedisMessageListenerContainer redisMessageListener(RedisConnectionFactory connectionFactory,
			MessageListenerAdapter listenerAdapter, ChannelTopic channelTopic) {
		
		RedisMessageListenerContainer container = new RedisMessageListenerContainer();
				
		container.setConnectionFactory(connectionFactory);
		container.addMessageListener(listenerAdapter, channelTopic);
		
		return container;
		
	}
	
	// 실제 메세지를 처리하는 subscriber 설정 추가
	@Bean
	public MessageListenerAdapter listenerAdapter(RedisSubscriber subscriber) {
		
		return new MessageListenerAdapter(subscriber, "sendMessage");
		
	}
	
	//new
	@Bean
    public RedisConnectionFactory redisConnectionFactory() {
        return new LettuceConnectionFactory(redisHost, redisPort);
	}
	
	// 앱에서 사용할 레디스템플릿 set
	@Bean
	public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory connectionFactory) {
		
		RedisTemplate<String, Object> redisTemplate = new RedisTemplate<>();
		
		// 기존 커넥션 팩토리
		//redisTemplate.setConnectionFactory(connectionFactory);
		
		// new
		redisTemplate.setConnectionFactory(redisConnectionFactory());
		
		redisTemplate.setKeySerializer(new StringRedisSerializer());
		redisTemplate.setValueSerializer(new Jackson2JsonRedisSerializer<>(String.class));
		
		return redisTemplate;
		
	}
}
