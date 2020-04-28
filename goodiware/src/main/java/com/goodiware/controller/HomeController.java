package com.goodiware.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.goodiware.mapper.EmployeeMapper;
import com.goodiware.service.ApprovalService;
import com.goodiware.service.MarketService;
import com.goodiware.service.MessageService;
import com.goodiware.service.ScheduleService;
import com.goodiware.vo.Approval;
import com.goodiware.vo.Board;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Message;
import com.goodiware.vo.Schedule;

@Controller
public class HomeController {
	
	@Autowired
	@Qualifier("messageService")
	MessageService messageService;
	
	@Autowired
	@Qualifier("approvalService")
	ApprovalService approvalService;
	
	@Autowired
	@Qualifier("scheduleService")
	ScheduleService scheduleService;
	
	@Autowired
	@Qualifier("marketService")
	MarketService marketService;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@GetMapping(path= {"/", "/home"})
	public String home(Model model, HttpSession session, Authentication auth) {
		
		String name = auth.getName();
				
		Employee employee = employeeMapper.selectEmployeeById(name); 
		
		int empno = employee.getEmpno();
		
		List<Message> messages = messageService.findRecentMessagesByEmpno(empno);
		List<Approval> approvals = approvalService.findRecentApprovalsByEmpno(empno);
		List<Schedule> schedules = scheduleService.findAllScheduleByEmpno(empno);
		List<Board> boards = marketService.findAllNotice();		
		
		model.addAttribute("messages", messages);
		model.addAttribute("approvals", approvals);
		model.addAttribute("schedules", schedules);
		model.addAttribute("boards", boards);
		
		return "home";
	}
	
}

