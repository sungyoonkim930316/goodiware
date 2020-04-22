package com.goodiware.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Auth;
import com.goodiware.vo.Department;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Position;

@Mapper
public interface AdminMapper {

	void insertEmployee(Employee employee);

	List<Position> selectPostions();

	List<Department> selectDepartments();

	List<Auth> selectAuths();

	List<Employee> empWithPaging(HashMap<String, Object> params);

	int empListCount(HashMap<String, Object> params);

	void editEmp(Employee employee);
}
