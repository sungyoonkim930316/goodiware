package com.goodiware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goodiware.service.BoardReplyService;
import com.goodiware.vo.Reply;

@Controller
@RequestMapping(path = {"/reply"})
public class BoardReplyController {
	
	@Autowired
	@Qualifier("boardReplyService")
	BoardReplyService boardReplyService;

	@PostMapping(path= {"/write"})
	@ResponseBody
	public String write(Reply reply,String action) {
		
//		if(action.equals("reply")) {
			boardReplyService.writeReply(reply);
//		} else if(action.equals("re-reply")) {
//			
//		}
		
		return "success";
	}
	
	@GetMapping(path= {"/list-by/{bno}"})
	public String listByBno(@PathVariable int bno, Model model) {
		
		List<Reply> replies = boardReplyService.getReplyListByBno(bno);
		model.addAttribute("replies", replies);
		
		return "/board/reply-list";
		
	}
	
	@DeleteMapping(path= {"delete/{rno}"})
	@ResponseBody
	public String deleteReply(@PathVariable int rno) {
		
		boardReplyService.deleteReply(rno);
		
		return "success";
	}
	
	@PutMapping(path= {"/update"}, consumes="application/json")
	@ResponseBody
	public String editReply(@RequestBody Reply reply) {
		
		System.out.println("reply.rno : " + reply.getRno());
		System.out.println("reply.rcontent : " + reply.getRcontent());
		
		boardReplyService.editReply(reply);
		
		return "success";
	}


	
	
}
