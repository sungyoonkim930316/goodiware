package com.goodiware;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.web.servlet.HttpEncodingAutoConfiguration;

@SpringBootApplication(
		exclude = {
				HttpEncodingAutoConfiguration.class
		}
)
public class GoodiwareApplication {

	public static void main(String[] args) {
		SpringApplication.run(GoodiwareApplication.class, args);
	}

}
