package com.goodiware.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import com.goodiware.service.ApprovalService;
import com.goodiware.service.MessageService;
import com.goodiware.vo.Approval;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Message;

@Controller
public class HomeController {
	
	@Autowired
	@Qualifier("messageService")
	MessageService messageService;
	
	@Autowired
	@Qualifier("approvalService")
	ApprovalService approvalService;
	
	@GetMapping(path= {"/", "/home"})
	public String home(Model model, HttpSession session) {
		
		Employee employee2 = (Employee)session.getAttribute("loginuser");
		
		int empno = employee2.getEmpno();
		
		List<Message> messages = messageService.findRecentMessagesByEmpno(empno);
		List<Approval> approvals = approvalService.findRecentApprovalsByEmpno(empno);
	
		model.addAttribute("messages", messages);
		model.addAttribute("approvals", approvals);
		
		return "home";
	}
	
}
