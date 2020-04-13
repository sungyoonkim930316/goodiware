package com.goodiware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.mapper.ApprovalMapper;
import com.goodiware.vo.ApprDiv;



@Service("approvalService")
public class ApprovalServiceImpl implements ApprovalService {

	@Autowired
	ApprovalMapper approvalMapper;
	
	@Override
	public List<ApprDiv> getApprDivs() {

		return approvalMapper.selectApprDivs();
	}

}
