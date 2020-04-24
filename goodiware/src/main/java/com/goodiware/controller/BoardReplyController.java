package com.goodiware.controller;

import java.util.HashMap;
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
import com.goodiware.ui.ThePager;
import com.goodiware.vo.Reply;

@Controller
@RequestMapping(path = {"/reply"})
public class BoardReplyController {
	
	@Autowired
	@Qualifier("boardReplyService")
	BoardReplyService boardReplyService;

	@PostMapping(path= {"/write"})
	@ResponseBody
	public String write(Reply reply) {
		
		boardReplyService.writeReply(reply);
		
		return "success";
	}
	
	// 리스트 로드 백업
//	@GetMapping(path= {"/list-by/{bno}"})
//	public String listByBno(@PathVariable int bno, Model model) {
//		
//		List<Reply> replies = boardReplyService.getReplyListByBno(bno);
//		model.addAttribute("replies", replies);
//		
//		
//		
//		return "/board/reply-list2";
//		
//	} 

	@GetMapping(path= {"/list-by/{bno}/{pageNo}"})
	public String listByBno(@PathVariable int bno, @PathVariable int pageNo, Model model) {
		
		int pageSize = 5;
		int pagerSize = 3;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("bno", bno);
		params.put("pageSize", pageSize);
		
		List<Reply> replies = boardReplyService.getReplyWithPagingByBno(params);
		int replyCount = boardReplyService.getReplyCount(params);

		int pageCount = ( replyCount / pageSize ) + (( replyCount % pageSize ) > 0 ? 1 : 0 );
		int pagerBlock = ( pageNo -1 ) / pagerSize;
		int start = (pagerBlock * pagerSize ) + 1;
		int end = start + pagerSize;

		HashMap<String, Integer> pager = new HashMap<String, Integer>();
		
		pager.put("pageNo", pageNo);
		pager.put("replyCount", replyCount);
		pager.put("pageCount", pageCount);
		pager.put("pageBlock", pagerBlock);
		pager.put("start", start);
		pager.put("end", end);
		model.addAttribute("pager", pager);
		
		model.addAttribute("replies", replies);
		
		return "/board/reply-list2";
//		return String.format("/board/reply-list?pageNo=%d", pageNo);
		
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

	@PostMapping(path= {"/rewrite"})
	@ResponseBody
	public String rewrite(Reply reply) {
		
		System.out.println("rno : " + reply.getRno());
		System.out.println("empno : " + reply.getEmpno());
		System.out.println("rcontent : " + reply.getRcontent());
		System.out.println("bno : " + reply.getBNo());

		boardReplyService.insertReReply(reply);
		
		return "success";
	}
	
	@GetMapping(path= {"/page/{rPageNo}"})
	@ResponseBody
	public String replyPage() {
		
		
		
		return "/board/reply-list2";
	}
	
	
}
