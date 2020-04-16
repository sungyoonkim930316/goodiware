package com.goodiware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodiware.service.ScheduleService;
import com.goodiware.vo.Position;
import com.goodiware.vo.Schdiv;
import com.goodiware.vo.Schedule;

@Controller
@RequestMapping(path= {"/schedule"})
public class ScheduleController {
	
	@Autowired
	@Qualifier("scheduleService")
	ScheduleService scheduleService;

	@GetMapping(path= {"/myschedule"})
	public String getSchedule(Model model) {
		
//		List<Schdiv> schdivs = scheduleService.showSchdiv();
//		model.addAttribute("schdivs", schdivs);
		
		return "/schedule/mainschedule";
		
	}
	
	@PostMapping(path= {"/mainschedule"})
	public String addSch(Schedule schedule, BindingResult result, RedirectAttributes attr) {
		
		scheduleService.plusScd(schedule);
		
		return "/schedule/mainschedule";
	}
}
