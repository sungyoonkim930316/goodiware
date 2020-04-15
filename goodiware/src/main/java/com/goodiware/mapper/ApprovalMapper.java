package com.goodiware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.ApprDiv;
import com.goodiware.vo.Approval;

@Mapper
public interface ApprovalMapper {

	List<ApprDiv> selectApprDivs();

	void insertApproval(Approval approval);

}
