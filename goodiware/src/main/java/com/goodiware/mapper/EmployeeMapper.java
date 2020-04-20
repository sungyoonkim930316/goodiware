package com.goodiware.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.goodiware.vo.Employee;


@Mapper
public interface EmployeeMapper {

	Employee selectEmployee(Employee employee);

	void updateEmployee(Employee employee);

//	List<Employee> searchEmp(Employee employee);

	List<Employee> searchNoByName(HashMap<String, Object> params);

	int selectEmpCount(HashMap<String, Object> params);

	Employee selectUserInfoByEmpNo(int empNo);

	String selectPosNameByPosNo(@Param("posno") int posno, @Param("empNo") int empNo);

	String selectDepNameByDepNo(@Param("depno") int depno, @Param("empNo") int empNo);

	Employee selectUserDetailByEmpno(int empno);


}