package com.goodiware.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.goodiware.service.MessageService;
import com.goodiware.ui.ThePager2;
import com.goodiware.vo.Employee;
import com.goodiware.vo.Message;


@Controller
@RequestMapping(path= {"/message"})
public class MessageController {
	
	@Autowired
	@Qualifier("messageService")
	MessageService messageService;

	// 페이징받은메일함 페이지로 이동 - 페이징 수정
	@GetMapping(path= {"/inbox"})
	public String getMail(int empno, Model model, @RequestParam(defaultValue="1")int pageNo, 
			@RequestParam(required = false) String searchType, @RequestParam(required=false)String searchKey, HttpServletRequest req) {
		
		int pageSize = 10;
		int pagerSize = 5;
		int beginning = (pageNo -1)* pageSize;
		
		HashMap<String, Object> params = new HashMap<>();
		params.put("empno", empno);
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("searchType", searchType);
		params.put("searchKey", searchKey);
		params.put("pageSize", pageSize);
		
		List<Message> messages = messageService.findMessageWithPaging(params);
		int messageCount = messageService.findMessageCount(params);
		model.addAttribute("messages", messages);

		///////////////////////////////////////////////////////////
		int pageCount = ( messageCount / pageSize ) + (( messageCount % pageSize ) > 0 ? 1 : 0 );
		int pagerBlock = ( pageNo -1 ) / pagerSize;
		int start = (pagerBlock * pagerSize ) + 1;
		int end = start + pagerSize;
		
		HashMap<String, Integer> pager = new HashMap<String, Integer>();
		
		pager.put("pageNo", pageNo);
		pager.put("boardCount", messageCount);
		pager.put("pageCount", pageCount);
		pager.put("pageBlock", pagerBlock);
		pager.put("start", start);
		pager.put("end", end);
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
	
	// 메세지 전송 처리 - 첨부파일
	@PostMapping(path= {"/sendMessage"})
	public String sendMessage(Message message, RedirectAttributes attr, @RequestParam("filename")MultipartFile msg, HttpServletRequest req) {
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/message");
		String fileName = msg.getOriginalFilename();
		
		try {
			File file = new File(path, fileName);
			msg.transferTo(file);
		} catch (Exception e) {
			System.out.println("파일이 없읍니다");
		}
		
		System.out.println("파일 이름 : "+ fileName);
		System.out.println("파일 경로 : "+ path);
		
		message.setMsgfilename(fileName);
		message.setFilepath(path);
		
		messageService.sendMessage(message);
		attr.addAttribute("success", message.getMno());
		
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
	public String trashMessage(int empno, int mno, Model model) {
		
		messageService.trashMessage(mno);
		
//		return String.format("redirect:/message/trash?empno=%d", empno);
		return String.format("redirect:/message/inbox?empno=%d", empno);

	}
	
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
		params.put("searchKey", searchKey);
		params.put("empno", empno);
		params.put("pageSize", pageSize);
		
		List<Message> messages = messageService.findMessageByMeWithPaging(params);
		int messageCount = messageService.findSendMessageCount(params);
		
		model.addAttribute("messages", messages);
		
		int pageCount = ( messageCount / pageSize ) + (( messageCount % pageSize ) > 0 ? 1 : 0 );
		int pagerBlock = ( pageNo -1 ) / pagerSize;
		int start = (pagerBlock * pagerSize ) + 1;
		int end = start + pagerSize;
		
		HashMap<String, Integer> pager = new HashMap<String, Integer>();
		
		pager.put("pageNo", pageNo);
		pager.put("boardCount", messageCount);
		pager.put("pageCount", pageCount);
		pager.put("pageBlock", pagerBlock);
		pager.put("start", start);
		pager.put("end", end);
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
		params.put("searchKey", searchKey);
		params.put("empno", empno);
		params.put("pageSize", pageSize);
		
		List<Message> messages = messageService.findTrashMessageWithPaging(params);
		int messageCount = messageService.findTrashMessageCount(params);
		
		model.addAttribute("messages", messages);
		///////////////////////////////////////////////////////////
		int pageCount = ( messageCount / pageSize ) + (( messageCount % pageSize ) > 0 ? 1 : 0 );
		int pagerBlock = ( pageNo -1 ) / pagerSize;
		int start = (pagerBlock * pagerSize ) + 1;
		int end = start + pagerSize;
		
		HashMap<String, Integer> pager = new HashMap<String, Integer>();
		
		pager.put("pageNo", pageNo);
		pager.put("boardCount", messageCount);
		pager.put("pageCount", pageCount);
		pager.put("pageBlock", pagerBlock);
		pager.put("start", start);
		pager.put("end", end);
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
	
	// 다운로드
	@GetMapping(path= {"/download"})
	public void downloadFile(int mno, HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		Message message = messageService.findFileByMno(mno);
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/message/" + message.getMsgfilename());
		
		System.out.println("path : " + path);
		
		resp.setContentType("application/octet-stream;charset=utf-8");
		
		resp.addHeader("Content-Disposition", "Attachment;filename=\"" + new String(message.getMsgfilename().getBytes("utf-8"), "ISO-8859-1") + "\"");
		
		FileInputStream fis = new FileInputStream(path);
		OutputStream fos = resp.getOutputStream();
		
		while (true) {
			int data = fis.read();
			if( data == -1) {
				break;
			}
			fos.write(data);
		}
		fis.close();
		fos.close();
	}

	@GetMapping(path = { "/get-suggestions" }, produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<Employee> getSeggestions(String receiveid) {
				
		List<Employee> receiveidList = messageService.searchReceiveIdList(receiveid);
				
		return receiveidList;
	}
	
}
