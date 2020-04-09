package com.goodiware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodiware.service.MessageService;
import com.goodiware.vo.Message;


@Controller
@RequestMapping(path= {"/message"})
public class MessageController {
	
	@Autowired
	@Qualifier("messageService")
	MessageService messageService;

	// 받은메일함 페이지로 이동
	@GetMapping(path= {"/inbox"})
	public String getMail(int empno, Model model) {
		
		List<Message> messages = messageService.showMessages(empno);
		model.addAttribute("messages", messages);
		
		return "message/inbox";
	}
	
	// 메일 전송 페이지로 이동
	@GetMapping(path = {"/compose"})
	public String composeMail() {
		
		return "message/compose";
		
	}
	
	// 메세지 전송 처리
	@PostMapping(path= {"sendMessage"})
	public String sendMessage(Message message, RedirectAttributes attr) {
		
		messageService.sendMessage(message);
		attr.addAttribute("success", message.getMno());
		
		return "redirect:/message/inbox";
		
	}
	
}
