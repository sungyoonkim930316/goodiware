package com.goodiware.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodiware.service.EmployeeService;
import com.goodiware.ui.ThePager2;
import com.goodiware.vo.Employee;

@Controller
@RequestMapping(path = { "/employee" })
public class EmployeeController {

	@Autowired
	@Qualifier("employeeService")
	EmployeeService employeeService;

	// 로그인 페이지 이동
	@GetMapping(path = { "/login" })
	public String toLogin() {
		return "/employee/login";
	}

//	// 로그인 처리 시큐리티 사용 안함
//	@PostMapping(path = { "/login" })
//	public String userLogin(Employee employee, HttpSession session, RedirectAttributes attr, Model model) {
//			
//		Employee employee2 = employeeService.userLogin(employee);
//						
//		if (employee2 == null) {
//			attr.addFlashAttribute("loginFalse", employee2);
//			return "redirect:/employee/login";
//		} else {
//			
//			session.setAttribute("logsinuser", employee2);
//			model.addAttribute("employee", employee2);
//			return "redirect:/";
//		}
//	}

	// 로그아웃 처리
	@GetMapping(path = { "/logout" })
	public String userLogout(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		if(auth != null) {
			new SecurityContextLogoutHandler().logout(req, resp, auth);
		}
		
		return "redirect:/";
	}

	// 정보 수정 페이지 이동
	@GetMapping(path = { "/edit" })
	public String toEdit(int empNo, Model model) {
		
		Employee employee = employeeService.findUserInfoByEmpNo(empNo);
		
		String posname = employeeService.findPosNameByPosNo(employee.getPosno(), empNo);
		String depname = employeeService.findDepNameByDepNo(employee.getDepno(), empNo);
		
		employee.setPosname(posname);
		employee.setDepname(depname);
						
		model.addAttribute("employee", employee);
		
		return "/employee/edit";
	}

	// 정보 수정 처리
	@PostMapping(path = { "/edit" })
	public String editEmployee(@RequestParam("profile") MultipartFile profile,
			String profilePicture, Employee employee, RedirectAttributes attr,
			HttpServletRequest req) {

		ServletContext application = req.getServletContext();
		String pic_path = application.getRealPath("resources/file/employee/photo/" + profilePicture);
		
		String pic_newPath = application.getRealPath("resources/file/employee/photo");
		String pic_newFilename = profile.getOriginalFilename();
		
		System.out.println("**********************************");
		System.out.println("기존 프사 : " + pic_path);
		System.out.println("프사경로 : " + pic_newPath);
		System.out.println("새 프사 : " + pic_newFilename);
		System.out.println("**********************************");
		
		
		if(profile.getOriginalFilename() != null && !profile.getOriginalFilename().equals("")) {
			
			new File(pic_path).delete();
						
			
			try {
				File f = new File(pic_newPath, pic_newFilename);
				profile.transferTo(f);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			System.out.println("새 프사 : " + pic_newFilename);
			employee.setPicture(pic_newFilename);
			
		} else { 
			
			employee.setPicture(req.getParameter("profilePicture")); 
		}
		
		employeeService.editEmployee(employee);
		attr.addFlashAttribute("editEmployee", employee);

		return "redirect:/";
	}

	// 패스워드 확인 페이지 이동
	@GetMapping(path = { "/confirmPw" })
	public String toConfirm() {

		return "/employee/confirmPw";

	}

	// 사원 리스트 조회 페이지 이동
	@GetMapping(path = { "/searchEmp" })
	public String toSearchEmp(@RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchKey,
			HttpServletRequest req, Model model, Employee employee) {

		int pageSize = 10;
		int pagerSize = 3;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("name", employee.getName());
		
		List<Employee> employees = employeeService.searchEmp(params);
		int boardCount = employeeService.searchEmpCount(params); // 전체 글 개수

		ThePager2 pager = new ThePager2(boardCount, pageNo, pageSize, pagerSize, "searchEmp", req.getQueryString());
		
		model.addAttribute("employees", employees);
		model.addAttribute("pager", pager);
		
		return "/employee/searchEmp";

	}

	// 회원 네임카드 보기
	@GetMapping(path = { "/searchDetail" })
	@ResponseBody
	public Employee showUserDetail(HttpSession session, int empno, Model model) {
		
		Employee employee = employeeService.findUserDetailByEmpno(empno);
				
		return employee;
	}

	
}
