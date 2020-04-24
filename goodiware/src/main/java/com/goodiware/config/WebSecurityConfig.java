package com.goodiware.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.goodiware.security.GoodiwareMemberSuccessHandler;
import com.goodiware.security.GoodiwarePasswordEncoder;
import com.goodiware.security.GoodiwareUserDetailsService;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	@Override
	public void configure(WebSecurity web) throws Exception {
		super.configure(web);
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		
		return new GoodiwarePasswordEncoder();
		
	}

	@Bean
	public GoodiwareUserDetailsService goodiwareDetailService() {
		
		return new GoodiwareUserDetailsService();
		
	}
	
	@Bean
	public GoodiwareMemberSuccessHandler goodiwareMemberSuccessHandler() {
		
		return new GoodiwareMemberSuccessHandler();
		
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.csrf().disable() // 기본값이 on인 csrf 취약점 보안을 해제한다. on으로 설정해도 되나 설정할경우 웹페이지에서 추가처리가 필요함.
				.headers()
				.frameOptions().sameOrigin() // SockJS는 기본적으로 HTML iframe 요소를 통한 전송을 허용하지 않도록 설정되는데 해당 내용을	해제한다.
				.and()					
					.formLogin().loginPage("/employee/login").loginProcessingUrl("/employee/login").usernameParameter("id").passwordParameter("pw").successHandler(goodiwareMemberSuccessHandler()) // 권한없이 페이지 접근하면 로그인 페이지로 이동한다.
				.and()
					.logout().logoutUrl("/employee/logout").logoutSuccessUrl("/").invalidateHttpSession(true).deleteCookies("JSESSIONID")
				.and()					
					.authorizeRequests()
					.antMatchers("/employee/login").permitAll()
					.antMatchers("/resources/**").permitAll()
					.antMatchers("/**").hasRole("USER").anyRequest().permitAll(); //리소스에 대한 접근 권한 설정
					//.anyRequest().permitAll(); // 나머지 리소스에 대한 접근 설정
		
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		
		System.out.println("-----------------------");
		auth.userDetailsService(goodiwareDetailService()).passwordEncoder(passwordEncoder());
		
	}
	
}
