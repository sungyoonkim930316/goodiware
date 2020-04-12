package com.goodiware.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodiware.service.MessageService;
import com.goodiware.ui.ThePager2;
import com.goodiware.vo.Message;


@Controller
@RequestMapping(path= {"/message"})
public class MessageController {
	
	@Autowired
	@Qualifier("messageService")
	MessageService messageService;

	// 받은메일함 페이지로 이동
//	public String showMail(int empno, Model model ) {
//		
//		List<Message> messages = messageService.showMessages(empno);
//		model.addAttribute("messages", messages);
//		
//		// 안읽은메일 카운트
//		int unreadCount = messageService.lookupOpendate(empno);
//		model.addAttribute("unreadCount", unreadCount);
//		
//		// 휴지통 메일 카운트
//		int trashMessage = messageService.trashCount(empno);
//		model.addAttribute("trashMessage", trashMessage);
//		
//		return "/message/inbox";
//	}
	
	// 페이징받은메일함 페이지로 이동
	@GetMapping(path= {"/inbox"})
	public String getMail(int empno, Model model, @RequestParam(defaultValue="1")int pageNo, 
					@RequestParam(required = false) String searchType, @RequestParam(required=false)String searchKey, HttpServletRequest req) {
		
		int pageSize = 10;
		int pagerSize = 3;
		int beginning = (pageNo -1)* pageSize;
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("searchType", searchType);
		params.put("searchkey", searchKey);
		params.put("empno", empno);
		
		List<Message> messages = messageService.findMessageWithPaging(params);
		int messageCount = messageService.findMessageCount(params);
		
		ThePager2 pager = new ThePager2(messageCount, pageNo, pageSize, pagerSize, "inbox", req.getQueryString());
		
		model.addAttribute("messages", messages);
		model.addAttribute("pager", pager);
		
		// 안읽은메일 카운트
		int unreadCount = messageService.lookupOpendate(empno);
		model.addAttribute("unreadCount", unreadCount);
		
		// 휴지통 메일 카운트
		int trashMessage = messageService.trashCount(empno);
		model.addAttribute("trashMessage", trashMessage);
		
		return "message/inbox";
	}
	
	// 메일 전송 페이지로 이동
	@GetMapping(path = {"/compose"})
	public String composeMail(int empno, Model model) {
		
		// 안읽은메일 카운트
		int unreadCount = messageService.lookupOpendate(empno);
		model.addAttribute("unreadCount", unreadCount);
		
		// 휴지통 메일 카운트
		int trashMessage = messageService.trashCount(empno);
		model.addAttribute("trashMessage", trashMessage);
		
		return "message/compose";
		
	}
	
	// 메세지 전송 처리
	@PostMapping(path= {"/sendMessage"})
	public String sendMessage(Message message, RedirectAttributes attr) {
		
		messageService.sendMessage(message);
		attr.addAttribute("success", message.getMno());
		
//		return "redirect:/message/inbox";
		return String.format("redirect:/message/inbox?empno=%d", message.getSender());
		
	}
	
	// 메세지 상세 보기
	@GetMapping(path= {"/messageContent" })
	public String showMessageContent(int empno, int mno, Model model, Message message) {
		
		Message message2 = messageService.showContent(mno);
		model.addAttribute("message", message2);
		
		// 읽은 메일의 읽은 시간 업데이트
		messageService.updateReadDate(mno);
		
		// 안읽은메일 카운트
		int unreadCount = messageService.lookupOpendate(empno);
		model.addAttribute("unreadCount", unreadCount);
		
		// 휴지통 메일 카운트
		int trashMessage = messageService.trashCount(empno);
		model.addAttribute("trashMessage", trashMessage);
		
		return "/message/content";
	}
	
	// 메세지 휴지통으로 이동
	@GetMapping(path = {"/trash"})
	public String trashMessage(int empno, int mno) {
		
		messageService.trashMessage(mno);
		
		return String.format("redirect:/message/trash?empno=%d", empno);
	}
	
//	// 휴지통으로 이동
//	@GetMapping(path= {"/trashcan"})
//	public String trashCan(int empno, Model model) {
//		
//		List<Message> messages = messageService.showTrashMessage(empno);
//		model.addAttribute("messages", messages);
//		
//		// 안읽은메일 카운트
//		int unreadCount = messageService.lookupOpendate(empno);
//		model.addAttribute("unreadCount", unreadCount);
//		
//		// 휴지통 메일 카운트
//		int trashMessage = messageService.trashCount(empno);
//		model.addAttribute("trashMessage", trashMessage);
//		
//		return "/message/trashCan";
//	}
	
	// 휴지통 메세지 상세보기
	@GetMapping(path= {"/trashContent"})
	public String trashContent(int empno, int mno, Model model, Message message) {
		
		Message message2 = messageService.showContent(mno);
		model.addAttribute("message", message2);
		
		// 안읽은메일 카운트
		int unreadCount = messageService.lookupOpendate(empno);
		model.addAttribute("unreadCount", unreadCount);
		
		// 휴지통 메일 카운트
		int trashMessage = messageService.trashCount(empno);
		model.addAttribute("trashMessage", trashMessage);
		
		return "/message/trashContent";
	}
	
	// 메세지 삭제하기
	@GetMapping(path = {"/deleteMessage"})
	public String deleteMessage(int empno, int mno) {
		
		messageService.deleteMessage(mno);
		
		return String.format("redirect:/message/trashcan?empno=%d", empno);
	}
	
	// 휴지통의 메세지 복구하기
	@GetMapping(path= {"/restoreMessage"})
	public String restoreMessage(int empno, int mno) {
		
		messageService.resotreMessage(mno);
		
		return String.format("redirect:/message/trashcan?empno=%d", empno);
	} 
	
	// 답장 페이지로 이동
	@GetMapping(path= {"/toReply"})
	public String toReply(int empno, int sender, Model model ) {
		
		// sendId 조회하기
		String sendId = messageService.searchSendId(sender);
		model.addAttribute("sendId", sendId);
		
		// 안읽은메일 카운트
		int unreadCount = messageService.lookupOpendate(empno);
		model.addAttribute("unreadCount", unreadCount);
		
		// 휴지통 메일 카운트
		int trashMessage = messageService.trashCount(empno);
		model.addAttribute("trashMessage", trashMessage);
		
		return "/message/reply";
	}
	
	// 보낸메일함 페이지로 이동
//	@GetMapping(path= {"sendMessage"})
//	public String sendMessgaePage(int empno, Model model) {
//		
//		List<Message> messages = messageService.showMessagesByMe(empno);
//		model.addAttribute("messages", messages);
//		
//		// 안읽은메일 카운트
//		int unreadCount = messageService.lookupOpendate(empno);
//		model.addAttribute("unreadCount", unreadCount);
//		
//		// 휴지통 메일 카운트
//		int trashMessage = messageService.trashCount(empno);
//		model.addAttribute("trashMessage", trashMessage);
//		
//		return "/message/sendMessage";
//	}

	// 페이징 보낸메일함 페이지로 이동
	@GetMapping(path= {"sendMessage"})
	public String sendMessgaePage(int empno, Model model, @RequestParam(defaultValue="1")int pageNo, 
			@RequestParam(required = false) String searchType, @RequestParam(required=false)String searchKey, HttpServletRequest req) {
		
		int pageSize = 10;
		int pagerSize = 3;
		int beginning = (pageNo -1)* pageSize;
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("searchType", searchType);
		params.put("searchkey", searchKey);
		params.put("empno", empno);
		
		List<Message> messages = messageService.findMessageByMeWithPaging(params);
		int messageCount = messageService.findSendMessageCount(params);
		
		ThePager2 pager = new ThePager2(messageCount, pageNo, pageSize, pagerSize, "inbox", req.getQueryString());
		
		model.addAttribute("messages", messages);
		model.addAttribute("pager", pager);
		
		// 안읽은메일 카운트
		int unreadCount = messageService.lookupOpendate(empno);
		model.addAttribute("unreadCount", unreadCount);
		
		// 휴지통 메일 카운트
		int trashMessage = messageService.trashCount(empno);
		model.addAttribute("trashMessage", trashMessage);
		
		return "/message/sendMessage";
	}
	
	// 보낸 메일 상세 보기
	@GetMapping(path= {"sendContent"})
	public String sendContent(int empno, int mno, Model model) {

		Message message2 = messageService.sendMessageContent(mno);
		model.addAttribute("message", message2);
		
		// 읽은 메일의 읽은 시간 업데이트
		messageService.updateReadDate(mno);
		
		// 안읽은메일 카운트
		int unreadCount = messageService.lookupOpendate(empno);
		model.addAttribute("unreadCount", unreadCount);
		
		// 휴지통 메일 카운트
		int trashMessage = messageService.trashCount(empno);
		model.addAttribute("trashMessage", trashMessage);
		
		return "/message/sendContent";
	}
	
	// 페이징 휴지통으로 이동
	@GetMapping(path= {"/trashcan"})
	public String trashCan(int empno, Model model, @RequestParam(defaultValue="1")int pageNo, 
			@RequestParam(required = false) String searchType, @RequestParam(required=false)String searchKey, HttpServletRequest req) {
		
		int pageSize = 10;
		int pagerSize = 3;
		int beginning = (pageNo -1)* pageSize;
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("searchType", searchType);
		params.put("searchkey", searchKey);
		params.put("empno", empno);
		
		List<Message> messages = messageService.findTrashMessageWithPaging(params);
		int messageCount = messageService.findTrashMessageCount(params);
		
		ThePager2 pager = new ThePager2(messageCount, pageNo, pageSize, pagerSize, "inbox", req.getQueryString());
		
		model.addAttribute("messages", messages);
		model.addAttribute("pager", pager);
		
		///////////////////////////////////////////////////////////
		
		// 안읽은메일 카운트
		int unreadCount = messageService.lookupOpendate(empno);
		model.addAttribute("unreadCount", unreadCount);
		
		// 휴지통 메일 카운트
		int trashMessage = messageService.trashCount(empno);
		model.addAttribute("trashMessage", trashMessage);
		
		return "/message/trashCan";
	}
	
	
	
}
