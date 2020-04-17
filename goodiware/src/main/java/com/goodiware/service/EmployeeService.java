package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import com.goodiware.vo.Employee;

public interface EmployeeService {

	Employee userLogin(Employee employee);

	void editEmployee(Employee employee);

	List<Employee> searchEmp(HashMap<String, Object> params);

	int searchEmpCount(HashMap<String, Object> params);

//	List<Employee> searchNoByName(Employee employee);

}