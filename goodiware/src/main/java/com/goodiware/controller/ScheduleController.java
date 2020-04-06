package com.goodiware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path= {"/schedule"})
public class ScheduleController {

	@GetMapping(path= {"/myschedule"})
	public String getSchedule() {
		
		return "/schedule/mainschedule";
		
	} 
}
