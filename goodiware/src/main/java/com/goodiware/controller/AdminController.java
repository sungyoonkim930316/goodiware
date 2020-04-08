package com.goodiware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodiware.service.AdminService;
import com.goodiware.vo.Department;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Position;

@Controller
@RequestMapping(path= {"/admin"})
public class AdminController {
	
	@Autowired
	@Qualifier("adminService")
	AdminService adminService;

	// 사원 등록 페이지 이동
	@GetMapping(path= {"/register"})
	public String showRegister(Model model) {
		
		List<Position> positions = adminService.showPositions();
		model.addAttribute("positions", positions);

		List<Department> departments = adminService.showDepartments();
		model.addAttribute("departments", departments);
		
		return "/admin/register";
	}
	
	// 사원 등록 처리
	@PostMapping(path= {"/register"})
	public String register(Employee employee, RedirectAttributes attr) {
		
		adminService.registerEmployee(employee);
		attr.addFlashAttribute("NewId", employee.getEmpno());
		
		return "redirect:/";
		
	}
	
	
}
