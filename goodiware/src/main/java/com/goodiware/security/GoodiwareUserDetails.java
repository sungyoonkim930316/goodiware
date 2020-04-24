package com.goodiware.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.goodiware.vo.Employee;

import lombok.Data;

@Data
public class GoodiwareUserDetails implements UserDetails {

	private Employee employee;
	//private MemberVO member;
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		ArrayList<SimpleGrantedAuthority> authorities = new ArrayList<>();
			
		authorities.add(new SimpleGrantedAuthority(employee.getRolename()));
		
		return authorities;
	}

	@Override
	public String getPassword() {		
		return employee.getPw();
	}

	@Override
	public String getUsername() {		
		return employee.getId();
	}

	@Override
	public boolean isAccountNonExpired() {		
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	@Override
	public boolean isEnabled() {
		return !employee.isDeleted();
	}

}
