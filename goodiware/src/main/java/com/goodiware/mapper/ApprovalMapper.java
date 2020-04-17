package com.goodiware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.ApprDiv;
import com.goodiware.vo.Approval;
import com.goodiware.vo.Employee;

@Mapper
public interface ApprovalMapper {

	List<ApprDiv> selectApprDivs();

	void insertApproval(Approval approval);

	List<Employee> selectMaccpNoByName(Employee employee);

	List<Approval> selectApprovalList(int divno);

}
