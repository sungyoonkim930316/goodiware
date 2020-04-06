package com.goodiware.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Employee;


@Mapper
public interface EmployeeMapper {

	Employee selectEmployee(Employee employee);

	void updateEmployee(Employee employee);


}
