package com.goodiware.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.goodiware.vo.ApprDiv;
import com.goodiware.vo.Approval;
import com.goodiware.vo.Employee;

@Mapper
public interface ApprovalMapper {

	List<ApprDiv> selectApprDivs();

	void insertApproval(Approval approval);

	List<Employee> selectMaccpNoByName(Employee employee);

	List<Approval> selectApprovalList(int divno);

	ApprDiv selectAppDivName(int appdivno);

	List<Approval> selectApprovalList(HashMap<String, Object> params);

	int selectApprCount(HashMap<String, Object> params);
	
	Approval selectApprByTypeNo(@Param("typeNo") int typeNo, @Param("appdivno")int appdivno);

	String selectMaccpNameByMaccpNo(int typeNo);

	String selectFaccpNameByFaccpNo(int typeNo);

	Approval selectUploadApprByTypeNo(int typeNo);

	void updateAppaccpno(@Param("typeNo") int typeNo, @Param("appaccpno") int appaccpno);

	void updateCompaion(@Param("typeNo")int typeNo, @Param("appaccpno") int appaccpno, @Param("companion") String companion);

}
