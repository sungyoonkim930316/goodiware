package com.goodiware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Employee;


@Mapper
public interface EmployeeMapper {

	Employee selectEmployee(Employee employee);

	void updateEmployee(Employee employee);

	List<Employee> searchEmp(Employee employee);


}