package com.goodiware.controller;

import java.io.File;
import java.util.HashMap;
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

import com.goodiware.service.ReferenceService;
import com.goodiware.vo.Reference;
import com.goodiware.ui.ThePager2;

@Controller
@RequestMapping(path = { "/reference" })
public class ReferenceController {

	@Autowired
	@Qualifier("referenceService")
	private ReferenceService referenceService;
	
	// 자료실 목록으로 이동
	@GetMapping(path = { "/list" })
	public String toList(@RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchKey,
			HttpServletRequest req, Model model) {
		
		int pageSize = 5;
		int pagerSize = 10;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("searchType", searchType);
		params.put("searchKey", searchKey);

		// 
		List<Reference> references = referenceService.findRefWithPaging(params);
		int boardCount = referenceService.findRefCount(params); // 전체 글 개수

		ThePager2 pager = new ThePager2(boardCount, pageNo, pageSize, pagerSize, "list", req.getQueryString());

		model.addAttribute("references", references);
		model.addAttribute("pager", pager);
		
		return "/reference/list";
	}
	
	// 자료실 글쓰기로 이동
	@GetMapping(path = { "/upload" })
	public String toWrite() {
		return "/reference/upload";
	}
	
	// 자료실 업로드 요청 처리
	@PostMapping(path = { "/upload" })
	public String uploadRef(@RequestParam("filename") MultipartFile ref, HttpServletRequest req,
			String smarteditor, Reference reference) {
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/reference");
		String fileName = ref.getOriginalFilename();
		try {
			File file = new File(path, fileName);
			ref.transferTo(file);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		System.out.println("스마트 에디터 본문 : " + smarteditor);
		System.out.println("파일 경로 : " + path);
		System.out.println("업로드 파일 : " + fileName);
		reference.setRefcontent(smarteditor);
		reference.setReffilename(fileName);
		reference.setRefpath(path);
		
		referenceService.insertRef(reference);
		
		return "redirect:/reference/list";
	}
	
	
	
}
