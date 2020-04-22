package com.goodiware.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodiware.service.AdminService;
import com.goodiware.service.EmployeeService;
import com.goodiware.ui.ThePager2;
import com.goodiware.vo.Auth;
import com.goodiware.vo.Department;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Position;

@Controller
@RequestMapping(path = { "/admin" })
public class AdminController {

	@Autowired
	@Qualifier("adminService")
	AdminService adminService;

	// 사원 등록 페이지 이동
	@GetMapping(path = { "/register" })
	public String showRegister(Model model) {

		List<Position> positions = adminService.showPositions();
		model.addAttribute("positions", positions);

		List<Department> departments = adminService.showDepartments();
		model.addAttribute("departments", departments);

		List<Auth> auths = adminService.showAuths();
		model.addAttribute("auths", auths);

		return "/admin/register";
	}

	// 사원 등록 처리
	@PostMapping(path = { "/register" })
	public String register(Employee employee, RedirectAttributes attr) {

		adminService.registerEmployee(employee);
		attr.addFlashAttribute("NewId", employee.getEmpno());

		return "redirect:/";

	}

	// 사원 리스트 조회 페이지 이동
	@GetMapping(path = { "/empList" })
	public String showEmpList(@RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchKey,
			HttpServletRequest req, Model model, Employee employee) {

		int pageSize = 5;
		int pagerSize = 5;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
//			params.put("name", employee.getName());
//			
		List<Employee> employees = adminService.empWithPaging(params);
		int boardCount = adminService.empListCount(params); // 전체 사원수

		ThePager2 pager = new ThePager2(boardCount, pageNo, pageSize, pagerSize, "empList", req.getQueryString());

		model.addAttribute("employees", employees);
		model.addAttribute("pager", pager);

		return "/admin/empList";

	}

	// 정보 수정 처리
	@PostMapping(path = { "/edit" })
	public String editEmployee( Employee employee, RedirectAttributes attr ) {

		adminService.editEmployee(employee);
		attr.addAttribute("editEmp", employee);

		return "/admin/edit";
	}

	@Autowired
	@Qualifier("employeeService")
	EmployeeService employeeService;

	// 사원 정보 수정 페이지 이동
	@GetMapping(path = { "/edit" })
	public String toEdit(int empNo, Model model) {

		List<Position> positions = adminService.showPositions();
		model.addAttribute("positions", positions);

		List<Department> departments = adminService.showDepartments();
		model.addAttribute("departments", departments);

		Employee employee = employeeService.findUserInfoByEmpNo(empNo);

		String posname = employeeService.findPosNameByPosNo(employee.getPosno(), empNo);
		String depname = employeeService.findDepNameByDepNo(employee.getDepno(), empNo);

		employee.setPosname(posname);
		employee.setDepname(depname);

		model.addAttribute("employee", employee);

		return "/admin/edit";
	}
	
	// 사원 검색 결과 페이지 이동
		@GetMapping(path = { "/empSearchResult" })
		public String toSearchEmp(@RequestParam(defaultValue = "1") int pageNo,
				@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchKey,
				HttpServletRequest req, Model model, Employee employee) {

			int pageSize = 5;
			int pagerSize = 5;
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
			
			return "/admin/empSearchResult";

		}

}
