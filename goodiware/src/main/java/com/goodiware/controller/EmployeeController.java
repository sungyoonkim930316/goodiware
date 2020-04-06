package com.goodiware.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodiware.service.EmployeeService;
import com.goodiware.vo.Employee;

@Controller
@RequestMapping(path= {"/employee"})
public class EmployeeController {
	
	@Autowired
	@Qualifier("employeeService")
	EmployeeService employeeService;

	// 로그인 페이지 이동
	@GetMapping(path= {"/login"})
	public String toLogin() {
		return "/employee/login";
	}
	
	// 로그인 처리
	@PostMapping(path= {"/login"})
	public String userLogin(Employee employee, HttpSession session, RedirectAttributes attr, Model model) {
		
		Employee employee2 = employeeService.userLogin(employee);
		if(employee2 == null) {
			attr.addFlashAttribute("loginFalse", employee);
			return "redirect:/employee/login";
		} else {
			session.setAttribute("loginuser", employee2);
			model.addAttribute("employee", employee2);
			return "redirect:/";
		}
	}
	
	// 로그아웃 처리
	@GetMapping(path= {"/logout"})
	public String userLogout(HttpSession session) {
		session.removeAttribute("loginuser");
		return "redirect:/";
	}
	
	// 정보 수정 페이지 이동
	@GetMapping(path= {"/edit"})
	public String toEdit() {
		return "/employee/edit";
	}
	
	// 정보 수정 처리
	@PostMapping(path= {"/edit"})
	public String editEmployee(Employee employee, RedirectAttributes attr) {
		
		employeeService.editEmployee(employee);
		attr.addFlashAttribute("editEmployee", employee);
		
		return "redirect:/";
	}
	
	// 패스워드 확인 페이지 이동
	@GetMapping(path= {"/confirmPw"})
	public String toConfirm() {
		
		return "/employee/confirmPw";
		
	}
	
	
	
}
