package com.goodiware.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.goodiware.ui.ThePager2;
import com.goodiware.vo.ApprDiv;
import com.goodiware.vo.Approval;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Reference;

@Controller
@RequestMapping(path= {"/appr/"})
public class ApprovalController {
	
	@Autowired
	@Qualifier("approvalService")
	ApprovalService approvalService;

	// 등록 페이지로 이동
	@GetMapping(path= {"/regist"})
	public String getApprRegist(Model model, int appdivno) {
		
		ApprDiv apprdiv2 = approvalService.getAppdivname(appdivno);
		model.addAttribute("appdivname", apprdiv2);
		
		return "/approval/regist";
	}
	
	// 등록 처리
	@PostMapping(path= {"/registAppr"})
	public String registApproval(String smarteditor, Approval approval, RedirectAttributes attr, 
								@RequestParam("filename")MultipartFile AccpFile, HttpServletRequest req, Model model, int appdivno) {
		
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
		
		approval.setContent(smarteditor);
		approval.setApprfilename(fileName);
		approval.setFilepath(path);
		
		approvalService.registApproval(approval);
		model.addAttribute("Success", approval.getTitle());
		
		return String.format("redirect:/appr/apprlist?appdivno=%d", appdivno);
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
	@GetMapping(path= {"/apprlist"})
	public String getApprList(@RequestParam(defaultValue = "1") int pageNo, HttpServletRequest req, Model model, int appdivno) {
		
		int pageSize = 10;
		int pagerSize = 10;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("appdivno", appdivno);
				
		List<Approval> approvals = approvalService.getApprovalListWithPaging(params);
		int boardCount = approvalService.findApprCount(params); // 전체 글 개수
		
		ThePager2 pager = new ThePager2(boardCount, pageNo, pageSize, pagerSize, "apprlist", req.getQueryString());
		
		model.addAttribute("approvals", approvals);
		model.addAttribute("pager", pager);
		
		return "/approval/apprlist";
		
	}
	
	// 홈 Dashboard에서 클릭한 결재 디테일로 이동
	@GetMapping(path = {"/apprdetail"})
	public String showApprDetail(int typeNo, int appdivno) {
		
		Approval approval = approvalService.findApprPageByTypeNo(typeNo, appdivno);
		
		int pageSize = 10;
				
		int pageNo = ((approval.getRownum() - 1) / pageSize) + 1;
		
		return String.format("redirect:/appr/detail?appdivno=%d&typeNo=%d&pageNo=%d", appdivno, typeNo, pageNo);
	}
	
	// 결재 상세 디테일로이동
	@GetMapping(path = { "/detail" })
	public String showDetail(int typeNo, int appdivno, @RequestParam(defaultValue = "1") int pageNo, Model model,
			HttpServletRequest req, HttpServletResponse resp) {
 						
		Approval approval = approvalService.findApprBytypeNo(typeNo, appdivno);
		
		if (approval == null) {
			return "redirect:apprlist";
		}
		
		String maccpName = approvalService.findMaccpNameByMaccpNo(typeNo);
		String faccpName = approvalService.findFaccpNameByFaccpNo(typeNo);
						
		approval.setMaccpname(maccpName);
		approval.setFaccpname(faccpName);
		
		
			
		// 2. 조회된 데이터를 View에서 사용할 수 있도록 저장
		model.addAttribute("approval", approval);

		// 3. View로 이동
		return "approval/detail";
	}
	
	@GetMapping(path = { "/download" })
	public void downloadResume(int typeNo, HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		Approval approval = approvalService.findUploadFileByTypeNo(typeNo);

		// 다운로드 처리
		// ServletContext : JSP의 application객체와 동일한 객체
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/approval/" + approval.getApprfilename());

		// System.out.println(fileName);

		// 브라우저가 응답 컨텐츠를 다운로드로 처리하도록 정보 설정 / 브라우저 속이기
		resp.setContentType("application/octet-stream;charset=utf-8");

		// 브라우저에게 다운로드하는 파일의 이름을 알려주는 코드
		resp.addHeader("Content-Disposition",
				// "Attachment;filename=\"" + fileName + "\"");
				"Attachment;filename=\"" + new String(approval.getApprfilename().getBytes("utf-8"), "ISO-8859-1") + "\"");

		FileInputStream fis = new FileInputStream(path); // 파일을 읽는 도구
		OutputStream fos = resp.getOutputStream(); // 브라우저에게 전송하는 도구

		while (true) {
			int data = fis.read(); // 파일에서 1byte 읽기
			if (data == -1) { // 더 이상 읽을 데이터가 없다면 (EOF)
				break;
			}
			fos.write(data); // 응답 스트림에 1byte 쓰기
		}

		fis.close();
		fos.close();
	}
	
	// 중간/최종승인자 승인처리
	@GetMapping(path= {"approvalAccp"})
	public String approvalMaccp(int appdivno, int typeNo, int pageNo, int appaccpno, Model model) {
		
		approvalService.updateAppaccpno(typeNo, appaccpno);
		
		return String.format("redirect:/appr/detail?appdivno=%d&typeNo=%d&pageNo=%d", appdivno, typeNo, pageNo);
	}
	
	// 반려 처리
	@GetMapping(path= {"companion"})
	public String companion(int appdivno, int typeNo, int pageNo, int appaccpno, String companion, Model model) {
		
		approvalService.updateCompanion(typeNo, appaccpno, companion);
		
		return String.format("redirect:/appr/detail?appdivno=%d&typeNo=%d&pageNo=%d", appdivno, typeNo, pageNo);
		
	}
	
	
}
