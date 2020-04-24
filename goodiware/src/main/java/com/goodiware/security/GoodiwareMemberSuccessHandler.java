 package com.goodiware.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class GoodiwareMemberSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth) throws IOException, ServletException {

		System.out.println("login success");
		
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		System.out.println("ROLE NAME : "+ roleNames);
		
		if(roleNames.contains("ROLE_USER")) {
			response.sendRedirect("/");
			return;
		} /*
			 * else if(roleNames.contains("ROLE_MEMBER")) { response.sendRedirect("/");
			 * return; }
			 */
		
		/* response.sendRedirect("/"); */
		
	}

}
