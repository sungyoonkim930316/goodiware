package com.goodiware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path= {"/reference"})
public class ReferenceController {

	// 자료실 목록으로 이동
	@GetMapping(path= {"/list"})
	public String toList() {
		return "/reference/list";
	}
	
	// 자료실 글쓰기로 이동
	@GetMapping(path= {"/write"})
	public String toWrite() {
		return "/reference/write";
	}
	
	
	
}
