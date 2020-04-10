package com.goodiware.controller;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.goodiware.service.ReferenceService;
import com.goodiware.vo.Reference;

@Controller
@RequestMapping(path = { "/reference" })
public class ReferenceController {

	@Autowired
	@Qualifier("referenceService")
	private ReferenceService referenceService;
	
	// 자료실 목록으로 이동
	@GetMapping(path = { "/list" })
	public String toList() {
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
