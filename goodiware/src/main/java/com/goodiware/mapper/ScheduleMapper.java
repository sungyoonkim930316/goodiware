package com.goodiware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Employee;
import com.goodiware.vo.Schdiv;
import com.goodiware.vo.Schedule;

@Mapper
public interface ScheduleMapper {

	void plusScd(Schedule schedule);

	List<Schdiv> selectSchdiv();

//	List<Employee> selectEmpno();

	List<Schedule> showPlans(int empno);

	Object deleteSchedule(int scheno);

	Schedule selectScheduleDetailByScheNo(int scheno);
}
