package com.goodiware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.mapper.ScheduleMapper;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Schdiv;
import com.goodiware.vo.Schedule;

@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {
	
	@Autowired
	ScheduleMapper scheduleMapper;

	@Override
	public void plusScd(Schedule schedule) {
		
		scheduleMapper.plusScd(schedule);
		
	}

	@Override
	public List<Schdiv> showSchdiv() {
		return scheduleMapper.selectSchdiv();
	}

	@Override
	public List<Schedule> showScheduleList(int empno) {
		return scheduleMapper.showPlans(empno);
	}

	@Override
	public void deleteSchedule(int scheno) {
		
		scheduleMapper.deleteSchedule(scheno);
		
	}

	@Override
	public Schedule findScheduleDetailByScheNo(int scheno) {
		return scheduleMapper.selectScheduleDetailByScheNo(scheno);
	}

	@Override
	public void deleteScheduleByNo(int scheno) {
		scheduleMapper.deleteScheduleByNo(scheno);
		
	}

	@Override
	public void updateSchedule(Schedule schedule) {
		scheduleMapper.updateSchedule(schedule);
		
	}

	@Override
	public void updateSch(Schedule schedule) {
		scheduleMapper.updateSch(schedule);
	}

	@Override
	public List<Schedule> findAllScheduleByEmpno(int empno) {
		
		return scheduleMapper.selectAllSchedulesByEmpno(empno);
	}

}
