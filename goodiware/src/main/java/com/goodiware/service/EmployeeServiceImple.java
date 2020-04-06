package com.goodiware.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.common.Util;
import com.goodiware.mapper.EmployeeMapper;
import com.goodiware.vo.Employee;

@Service("employeeService")
public class EmployeeServiceImple implements EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;

	@Override
	public Employee userLogin(Employee employee) {
		
		employee.setPw(Util.getHashedString(employee.getPw(), "SHA-256"));
		
		return employeeMapper.selectEmployee(employee);
	}

	@Override
	public void editEmployee(Employee employee) {
		
		employeeMapper.updateEmployee(employee);
	}


}
