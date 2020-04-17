package com.goodiware.service;

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
	public List<Approval> getApprovalList(int divno) {

		return approvalMapper.selectApprovalList(divno);
	}

}
