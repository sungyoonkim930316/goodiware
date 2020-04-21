package com.goodiware.config;

import java.nio.charset.Charset;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.goodiware.interceptor.AuthInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	@Autowired
	private AuthInterceptor authInterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {

		registry.addInterceptor(authInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/resources/**");
		
	}
	
//	@Bean
//	public HttpMessageConverter<String> responseBodyconConverter() {
//		// @ResponseBody 응답에 대한 encoding 설정
//		return new StringHttpMessageConverter(Charset.forName("UTF-8"));
//	}
//	
//	@Bean
//	public HiddenHttpMethodFilter methodFilter() {
//		HiddenHttpMethodFilter filter = new HiddenHttpMethodFilter();
//		return filter;
//	}
	
	
}
