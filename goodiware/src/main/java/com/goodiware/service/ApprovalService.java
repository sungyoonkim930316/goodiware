package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import com.goodiware.vo.ApprDiv;
import com.goodiware.vo.Approval;
import com.goodiware.vo.Employee;

public interface ApprovalService {

	List<ApprDiv> getApprDivs();

	void registApproval(Approval approval);

	List<Employee> showMaccp(Employee employee);
	
	ApprDiv getAppdivname(int appdivno);
	
	int findApprCount(HashMap<String, Object> params);

	List<Approval> getApprovalListWithPaging(HashMap<String, Object> params);

	Approval findApprBytypeNo(int typeNo, int appdivno);

	String findMaccpNameByMaccpNo(int typeNo);

	String findFaccpNameByFaccpNo(int typeNo);

	Approval findUploadFileByTypeNo(int typeNo);

	void updateAppaccpno(int typeNo, int appaccpno);

	void updateCompanion(int typeNo, int appaccpno, String companion);

	List<Approval> findRecentApprovalsByEmpno(int empno);


}
