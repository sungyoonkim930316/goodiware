package com.goodiware.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path= {"/mail"})
public class MailController {

	@GetMapping(path= {"/inbox"})
	public String getMail() {
		
		return "/mail/inbox";
	}
	
	@GetMapping(path = {"compose"})
	public String composeMail() {
		
		return "/mail/compose";
		
	}
	
}
