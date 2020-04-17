package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

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

	@Override
	public List<Employee> searchEmp(HashMap<String, Object> params) {
		
		return employeeMapper.searchNoByName(params);
	}

	@Override
	public int searchEmpCount(HashMap<String, Object> params) {
		
		return employeeMapper.selectEmpCount(params);
	}

	@Override
	public Employee findUserInfoByEmpNo(int empNo) {
		
		return employeeMapper.selectUserInfoByEmpNo(empNo);
		
	}

	@Override
	public String findPosNameByPosNo(int posno, int empNo) {
		
		return employeeMapper.selectPosNameByPosNo(posno, empNo);
		
	}

	@Override
	public String findDepNameByDepNo(int depno, int empNo) {
		
		return employeeMapper.selectDepNameByDepNo(depno, empNo);
		
	}
	
//	@Override
//	public List<Employee> searchNoByName(Employee employee) {
//
//		return employeeMapper.searchNoByName(employee);
//	}

}