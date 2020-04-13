package com.goodiware.service;

import java.util.List;

import com.goodiware.vo.Employee;

public interface EmployeeService {

	Employee userLogin(Employee employee);

	void editEmployee(Employee employee);

	List<Employee> searchEmp(Employee employee);

}