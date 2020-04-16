package com.goodiware.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.goodiware.mapper.ScheduleMapper;
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
//
//	@Override
//	public List<Schdiv> showSchdiv() {
//		return scheduleMapper.selectSchdiv();
//	}

}
