package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import com.goodiware.vo.Employee;

public interface EmployeeService {

	Employee userLogin(Employee employee);

	void editEmployee(Employee employee);

	List<Employee> searchEmp(HashMap<String, Object> params);

	int searchEmpCount(HashMap<String, Object> params);

	Employee findUserInfoByEmpNo(int empNo);

	String findPosNameByPosNo(int posno, int empNo);

	String findDepNameByDepNo(int depno, int empNo);

	Employee findUserDetailByEmpno(int empno);

//	List<Employee> searchNoByName(Employee employee);

}