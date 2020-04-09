package com.goodiware.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.goodiware.service.MessageService;
import com.goodiware.vo.Message;


@Controller
@RequestMapping(path= {"/message"})
public class MessageController {
	
	@Autowired
	@Qualifier("messageService")
	MessageService messageService;

	@GetMapping(path= {"/inbox"})
	public String getMail() {
		
		return "/message/inbox";
	}
	
	@GetMapping(path = {"compose"})
	public String composeMail() {
		
		return "/message/compose";
		
	}
	
	@PostMapping(path= {"sendMessage"})
	public String sendMessage(Message message) {
		
		messageService.sendMessage(message);
		
		return "";
		
	}
	
}
