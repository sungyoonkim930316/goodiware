package com.goodiware.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.goodiware.vo.Schdiv;
import com.goodiware.vo.Schedule;

@Mapper
public interface ScheduleMapper {

	void plusScd(Schedule schedule);

	List<Schdiv> selectSchdiv();

	List<Schedule> showPlans(int empno);

	void deleteSchedule(int scheno);

	Schedule selectScheduleDetailByScheNo(int scheno);

	void deleteScheduleByNo(int scheno);

	void updateSchedule(Schedule schedule);

	void updateSch(Schedule schedule);
}
