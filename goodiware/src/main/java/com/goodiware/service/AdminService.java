package com.goodiware.service;

import java.util.List;

import com.goodiware.vo.Auth;
import com.goodiware.vo.Department;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Position;

public interface AdminService {

	void registerEmployee(Employee employee);

	List<Position> showPositions();

	List<Department> showDepartments();

	List<Auth> showAuths();

}
