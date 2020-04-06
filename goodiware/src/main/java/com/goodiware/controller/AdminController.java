package com.goodiware.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.goodiware.service.AdminService;
import com.goodiware.vo.Employee;

@Controller
@RequestMapping(path= {"/admin"})
public class AdminController {
	
	@Autowired
	@Qualifier("adminService")
	AdminService adminService;

	@GetMapping(path= {"/register"})
	public String showRegister() {
		return "/admin/register";
	}
	
	@PostMapping(path= {"/register"})
	public String register(Employee employee) {
		adminService.registerEmployee(employee);
		return "redirect:/";
		
	}
	
}
