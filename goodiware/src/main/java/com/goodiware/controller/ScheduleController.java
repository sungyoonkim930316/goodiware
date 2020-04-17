package com.goodiware.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodiware.service.ScheduleService;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Position;
import com.goodiware.vo.Schdiv;
import com.goodiware.vo.Schedule;
import com.mysql.cj.xdevapi.JsonArray;

@Controller
@RequestMapping(path= {"/schedule"})
public class ScheduleController {
	
	@Autowired
	@Qualifier("scheduleService")
	ScheduleService scheduleService;

	@GetMapping(path= {"/myschedule"})
	public String getSchedule(Model model) {
		
		List<Schdiv> schdivs = scheduleService.showSchdiv();
		model.addAttribute("schdivs", schdivs);
		
		List<Employee> empno = scheduleService.showEmpno();
		model.addAttribute("empno", empno);
		
		return "/schedule/mainschedule";
		
	}
	
	@PostMapping(path= {"/mainschedule"})
	public String addSch(Schedule schedule) {
		
		scheduleService.plusScd(schedule);
		
		return "/schedule/mainschedule";
	}
	
	@InitBinder
	public void allowEmptyDateBinding(WebDataBinder binder)
	{
		binder.registerCustomEditor( String.class, new StringTrimmerEditor( true ));
		SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
		simpleDateFormat.setLenient(false);
		binder.registerCustomEditor( Date.class, new CustomDateEditor( simpleDateFormat,false));	   
	}
	
	
//	HashMap<String, Object> myPlan(HttpSession session) {
//		HashMap<String, Object> map = new HashMap<String, Object>();
//		
//		String id = (String)session.getAttribute("empno");
//		
//		List<Schedule> schedules = scheduleService.plans(id);
//		map.put("schedules", schedules);
//		return map;
//	}
	
//	Map<String, Schedule> javaMap = new HashMap<String, Schedule>();
//	
//	javaMap.put("evt1", new Schedule("db이벤트1", "2020-04-16", "2020-04-18", "false"));
	
//	@PostMapping(path= {"/mainschedule"})
//	public String addSch(Schedule schedule, BindingResult result, RedirectAttributes attr) {
//		
//		scheduleService.plusScd(schedule);
//		
//		return "/schedule/mainschedule";
//	}
	
	
}
