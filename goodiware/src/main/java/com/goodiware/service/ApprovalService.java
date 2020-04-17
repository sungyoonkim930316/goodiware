package com.goodiware.service;

import java.util.List;

import com.goodiware.vo.ApprDiv;
import com.goodiware.vo.Approval;
import com.goodiware.vo.Employee;

public interface ApprovalService {

	List<ApprDiv> getApprDivs();

	void registApproval(Approval approval);

	List<Employee> showMaccp(Employee employee);

	List<Approval> getApprovalList(int appdivno);

	ApprDiv getAppdivname(int appdivno);


}
