package com.goodiware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path= {"/board"})
public class BoardController {

	// 게시판 목록으로 이동
	@GetMapping(path= {"/list"})
	public String toList() {
		return "/board/boardList";
	}
	
	// 게시판 글쓰기로 이동
	@GetMapping(path= {"/write"})
	public String toWrite() {
		return "/board/write";
	}
	
	
	
}
