package com.goodiware.service;

import java.util.List;

import com.goodiware.vo.Schdiv;
import com.goodiware.vo.Schedule;

public interface ScheduleService {

	void plusScd(Schedule schedule);
	
	List<Schdiv> showSchdiv();

	List<Schedule> showScheduleList(int empno);

	void deleteSchedule(int scheno);

	Schedule findScheduleDetailByScheNo(int scheno);

	void deleteScheduleByNo(int scheno);

	void updateSchedule(Schedule schedule);

	void updateSch(Schedule schedule);

	List<Schedule> findAllScheduleByEmpno(int empno);

}
