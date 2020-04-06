package com.goodiware.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Employee;

@Mapper
public interface AdminMapper {

	void insertEmployee(Employee employee);

}
