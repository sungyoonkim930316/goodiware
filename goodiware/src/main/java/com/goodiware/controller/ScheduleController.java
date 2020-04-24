package com.goodiware.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import org.hibernate.validator.internal.util.logging.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	//public List<Schedule> getSchedule(Model model) {
		
//		Map<String, Schedule> javaMap = new HashMap<String, Schedule>();
//		javaMap.put("evt1", new Schedule());
//		javaMap.put("evt2", new Schedule());
		
		List<Schdiv> schdivs = scheduleService.showSchdiv();
		model.addAttribute("schdivs", schdivs);
		
//		List<Employee> empno2 = scheduleService.showEmpno();
//		model.addAttribute("empno2", empno2);
		
		List<Schedule> schedules = scheduleService.showScheduleList(empno);
		model.addAttribute("schedules", schedules);
		
		model.addAttribute("ttitle", "test title");
		model.addAttribute("tstart", "2020-04-28");
		model.addAttribute("tend", "2020-04-30");
		
		return "/schedule/mainschedule";
		//return schedules;
		
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
	
//	@PostMapping(path = { "/mainschedule" })
//	public String updateSch(Schedule schedule, int empno) {
//		
//		scheduleService.updateSch(schedule);
//		
//		return String.format("redirect:/schedule/myschedule?empno=%d", empno);
//	}
	
	@DeleteMapping(path = { "/delete" })
	@ResponseBody
	public String deleteSchedule(int scheno) {
		
		scheduleService.deleteSchedule(scheno);
		
		return "success";
	}
	
	@PutMapping(path = { "/update" }, consumes = "application/json")
	@ResponseBody
	public String update(@RequestBody Schedule schedule) { //@RequestBody : 요청 본문을 직접 읽어서 객체 매핑
		
		scheduleService.updateSchedule(schedule);
		
		return "successs";
	}
	
}
