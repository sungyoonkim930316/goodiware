package com.goodiware.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
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

import com.goodiware.service.ApprovalService;
import com.goodiware.vo.ApprDiv;
import com.goodiware.vo.Approval;
import com.goodiware.vo.Employee;

@Controller
@RequestMapping(path= {"/appr/"})
public class ApprovalController {
	
	@Autowired
	@Qualifier("approvalService")
	ApprovalService approvalService;

	// 등록 페이지로 이동
	@GetMapping(path= {"/regist"})
	public String getApprRegist(Model model) {
		
		List<ApprDiv> apprdivs = approvalService.getApprDivs();
		model.addAttribute("apprdivs", apprdivs);
		
		return "/approval/regist";
	}
	
	// 등록 처리
	@PostMapping(path= {"/registAppr"})
	public String registApproval(Approval approval, RedirectAttributes attr, 
								@RequestParam("filename")MultipartFile AccpFile, HttpServletRequest req, Model model) {
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/approval");
		String fileName = AccpFile.getOriginalFilename();
		
		try {
			File file = new File(path, fileName);
			AccpFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("파일이 없습니다");
		}
		
		System.out.println("파일이름 : " + fileName);
		System.out.println("파일경로: "  + path);
		
		approval.setApprfilename(fileName);
		approval.setFilepath(path);
		
		approvalService.registApproval(approval);
		model.addAttribute("Success", approval.getTitle());
		
		return "redirect:/";
	}
	
	// 중간승인자 찾기
	@GetMapping(path = {"/maccpSearch"})
	public String maccpSearch() {
		
		return "/approval/searchPopup";
	}
	
	// 중간승인자 검색결과
	@PostMapping(path= {"/searchMaccp"})
	public String getMaccp(Employee employee, Model model) {
		
		List<Employee> employee2 = approvalService.showMaccp(employee);
		model.addAttribute("maccps", employee2);
		
		return "/approval/searchPopup";
	}
	
	// 최종승인자 찾기
	@GetMapping(path = {"/faccpSearch"})
	public String faccpSearch() {
		
		return "/approval/searchPopup2";
	}
	
	// 중간승인자 검색결과
	@PostMapping(path= {"/searchFaccp"})
	public String getFaccp(Employee employee, Model model) {
		
		List<Employee> employee2 = approvalService.showMaccp(employee);
		model.addAttribute("faccps", employee2);
		
		return "/approval/searchPopup2";
	}
	
	// 업무 페이지 이동
	@GetMapping(path= {"/task"})
	public String getTask() {
		
//		List<Approval> approvals = approvalService.getApprovalList();
		
		return "/approval/taskList";
		
	}

	// 파견 페이지로 이동
	@GetMapping(path= {"/dispatch"})
	public String getDispatch() {
		return "/approval/dispatchList";
	}
	
	
	// 경비지출 페이지로 이동
	@GetMapping(path= {"/expenditure"})
	public String getExpenditure() {
		return "/approval/expenditureList";
	}
	
	//초과근무 페이지로 이동
	@GetMapping(path= {"/overtime"})
	public String getOvertime() {
		return "/approval/overtimeList";
	}
	
	// 휴가 페이지로 이동
	@GetMapping(path= {"/vacation"})
	public String getVacation() {
		return "/approval/vacationList";
	}
	
}
