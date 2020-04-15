package com.goodiware.service;

import java.util.List;

import com.goodiware.vo.ApprDiv;
import com.goodiware.vo.Approval;

public interface ApprovalService {

	List<ApprDiv> getApprDivs();

	void registApproval(Approval approval);

}
