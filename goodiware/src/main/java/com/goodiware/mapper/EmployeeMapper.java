package com.goodiware.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Employee;


@Mapper
public interface EmployeeMapper {

	Employee selectEmployee(Employee employee);

	void updateEmployee(Employee employee);

//	List<Employee> searchEmp(Employee employee);

	List<Employee> searchNoByName(HashMap<String, Object> params);

	int selectEmpCount(HashMap<String, Object> params);


}