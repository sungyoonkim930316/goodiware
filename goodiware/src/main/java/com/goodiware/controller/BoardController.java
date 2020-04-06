package com.goodiware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path= {"/board"})
public class BoardController {

	@GetMapping(path= {"/list"})
	public String toList() {
		return "/board/boardList";
	}
	
}
