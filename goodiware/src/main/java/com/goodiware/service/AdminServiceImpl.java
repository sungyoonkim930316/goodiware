package com.goodiware.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.common.Util;
import com.goodiware.mapper.AdminMapper;
import com.goodiware.vo.Employee;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminMapper adminMapper;

	@Override
	public void registerEmployee(Employee employee) {
		
		String plainPasswd = employee.getPw();
		String hashedPasswd = Util.getHashedString(plainPasswd, "SHA-256");
		employee.setPw(hashedPasswd);
		
		adminMapper.insertEmployee(employee);
		
	}
	
}
