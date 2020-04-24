package com.goodiware.config;

import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.data.redis.repository.configuration.EnableRedisRepositories;

import redis.embedded.RedisServer;

@Profile("local")
@Configuration("embeddedRedisConfig")
@EnableRedisRepositories
public class EmbeddedRedisConfig {

	@Value("${spring.redis.port}")
	private int redisPort;

	private RedisServer redisServer;

	@PostConstruct
	public void redisServer() throws IOException {

		System.out.println("start function redisServer");
		
		redisServer = new RedisServer(redisPort);
		redisServer.start();

	}

	@PreDestroy
	public void stopRedis() {

		System.out.println("start function stopRedis");
		
		if (redisServer != null) {
			redisServer.stop();
		}

	}

}
