package com.goodiware.service;

import com.goodiware.vo.Employee;

public interface EmployeeService {

	Employee userLogin(Employee employee);

	void editEmployee(Employee employee);


}
