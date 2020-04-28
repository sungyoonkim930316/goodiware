package com.goodiware.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodiware.service.ScheduleService;
import com.goodiware.vo.Schdiv;
import com.goodiware.vo.Schedule;

@Controller
@RequestMapping(path= {"/schedule"})
public class ScheduleController {
	
	@Autowired
	@Qualifier("scheduleService")
	ScheduleService scheduleService;

	@InitBinder
	public void allowEmptyDateBinding(WebDataBinder binder)
	{
		binder.registerCustomEditor( String.class, new StringTrimmerEditor( true ));
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm");
		simpleDateFormat.setLenient(false);
		binder.registerCustomEditor( Date.class, new CustomDateEditor( simpleDateFormat,false));	   
	}
	
	
	@GetMapping(path= {"/myschedule"})
	public String getSchedule(Model model, int empno) {
		
		List<Schdiv> schdivs = scheduleService.showSchdiv();
		model.addAttribute("schdivs", schdivs);
		
		List<Schedule> schedules = scheduleService.showScheduleList(empno);
		model.addAttribute("schedules", schedules);
		
		return "/schedule/mainschedule";
	}
	
	@GetMapping(path= {"/schedule/detail"})
	public String showSchedule(Model model, int scheno) {
		
		Schedule scheduleDetail = scheduleService.findScheduleDetailByScheNo(scheno);
		if (scheduleDetail == null) {
			return String.format("redirect:/schedule/myschedule");
		}
		model.addAttribute("scheduleDetail", scheduleDetail);
		
		return "success";
		
	}
	
	@PostMapping(path= {"/mainschedule"})
	public String addSch(Schedule schedule, int empno) {
		
		scheduleService.plusScd(schedule);
		
		return String.format("redirect:/schedule/myschedule?empno=%d", empno);
	}
	
	@DeleteMapping(path = { "/delete" })
	@ResponseBody
	public String deleteSchedule(int scheno) {
		
		scheduleService.deleteSchedule(scheno);
		
		return "success";
	}
	
	@PutMapping(path = { "/update" }, consumes = "application/json")
	@ResponseBody
	public String update(@RequestBody Schedule schedule) {
		
		scheduleService.updateSchedule(schedule);
		
		return "successs";
	}
	
}
