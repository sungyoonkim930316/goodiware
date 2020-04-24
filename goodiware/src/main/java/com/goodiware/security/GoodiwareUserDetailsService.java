package com.goodiware.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.goodiware.mapper.EmployeeMapper;
import com.goodiware.vo.Employee;

import lombok.Data;

@Data
public class GoodiwareUserDetailsService implements UserDetailsService {
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		
		Employee employee = employeeMapper.selectEmployeeById(id);
		
		GoodiwareUserDetails details = null;
		
		if (employee != null) {
		
			details = new GoodiwareUserDetails();
			details.setEmployee(employee);
			
		}
						
		return details;
	}

}
