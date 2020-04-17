package com.goodiware.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.mapper.ApprovalMapper;
import com.goodiware.vo.ApprDiv;
import com.goodiware.vo.Approval;
import com.goodiware.vo.Employee;



@Service("approvalService")
public class ApprovalServiceImpl implements ApprovalService {

	@Autowired
	ApprovalMapper approvalMapper;
	
	@Override
	public List<ApprDiv> getApprDivs() {

		return approvalMapper.selectApprDivs();
	}

	@Override
	public void registApproval(Approval approval) {

		approvalMapper.insertApproval(approval);
	}

	@Override
	public List<Employee> showMaccp(Employee employee) {

		return approvalMapper.selectMaccpNoByName(employee);
	}

	@Override
	public ApprDiv getAppdivname(int appdivno) {

		return approvalMapper.selectAppDivName(appdivno);
	}

	@Override
	public int findApprCount(HashMap<String, Object> params) {
		
		return approvalMapper.selectApprCount(params);
		
	}

	@Override
	public List<Approval> getApprovalListWithPaging(HashMap<String, Object> params) {
		
		return approvalMapper.selectApprovalList(params); 
	}

	@Override
	public Approval findApprBytypeNo(int typeNo, int appdivno) {
		
		return approvalMapper.selectApprByTypeNo(typeNo, appdivno);
		
	}

	@Override
	public String findMaccpNameByMaccpNo(int typeNo) {
		
		return approvalMapper.selectMaccpNameByMaccpNo(typeNo);
		
	}

	@Override
	public String findFaccpNameByFaccpNo(int typeNo) {
		
		return approvalMapper.selectFaccpNameByFaccpNo(typeNo);
		
	}

	@Override
	public Approval findUploadFileByTypeNo(int typeNo) {
		
		return approvalMapper.selectUploadApprByTypeNo(typeNo);
	}

}
