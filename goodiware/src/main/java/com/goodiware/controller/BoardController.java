package com.goodiware.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
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

import com.goodiware.service.BoardReplyService;
import com.goodiware.service.BoardService;
import com.goodiware.ui.ThePager;
import com.goodiware.ui.ThePager2;
import com.goodiware.vo.Board;
import com.goodiware.vo.Reply;

@Controller
@RequestMapping(path= {"/board"})
public class BoardController {
	
	@Autowired
	@Qualifier("boardService")
	private BoardService boardService;
	
	@Autowired
	@Qualifier("boardReplyService")
	BoardReplyService boardReplyService;

	// 자료실 목록으로 이동
	@GetMapping(path = { "/list" })
	public String toList(@RequestParam(defaultValue = "1") int pageNo, @RequestParam(required = false) String searchType, 
						@RequestParam(required = false) String searchKey, HttpServletRequest req, Model model) {
		
		int pageSize = 5;
		int pagerSize = 10;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("searchType", searchType);
		params.put("searchKey", searchKey);

		// 
		List<Board> boards = boardService.findBoardWithPaging(params);
		int boardCount = boardService.findBoardCount(params); // 전체 글 개수

		ThePager2 pager = new ThePager2(boardCount, pageNo, pageSize, pagerSize, "list", req.getQueryString());

		model.addAttribute("boards", boards);
		model.addAttribute("pager", pager);
		
		return "board/boardList";
	}
		
	// 게시판 글쓰기로 이동
	@GetMapping(path= {"/write"})
	public String toWrite() {
		return "/board/write";
	}
	
	@PostMapping(path = { "/write.action" })
	public String write(Board board, RedirectAttributes attr, Model model) { // 글쓰기 처리

		boardService.writeBoard(board);

		return "redirect:/board/list";
	}
	
	// 디테일  백업
//	@GetMapping(path = { "/detail" })
//	public String showDetail(@RequestParam("BNo") int bNo, Model model){
// 
//		Board board = boardService.findBoardByBNo(bNo);
//		
//		List<Reply> replies = boardReplyService.getReplyListByBno(bNo);
//		model.addAttribute("replies", replies);
//		
//		if (board == null) {
//			return "redirect:list";
//		}
//		
//
//		// 2. 조회된 데이터를 View에서 사용할 수 있도록 저장
//		model.addAttribute("board", board);
//
//		// 3. View로 이동
//		return "board/detail";
//	}
	
	// 게시판 디테일 + 댓글 페이징 
	@GetMapping(path = { "/detail" })
	public String showDetail(@RequestParam(value="RpageNo", defaultValue="1") int pageNo,@RequestParam("BNo") int bNo, Model model){
		
		// 게시글 디테일 조회
		Board board = boardService.findBoardByBNo(bNo);

		// 댓글 조회
		int pageSize = 5;
		int pagerSize = 3;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("bno", bNo);
		params.put("pageSize", pageSize);
		
		List<Reply> replies = boardReplyService.getReplyWithPagingByBno(params);
		int replyCount = boardReplyService.getReplyCount(params);
		
		///////////////////////////////////////////////////////////
		/// 페이징 맹글기
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
		
		System.out.println("replyCount : " + replyCount);
		System.out.println("pageCount : " + pageCount);
		System.out.println("pageBlock : " + pagerBlock);
		System.out.println("start : " + start);
		System.out.println("end : " + end);
		
		model.addAttribute("replies", replies);
		
		if (board == null) {
			return "redirect:list";
		}
		
		model.addAttribute("board", board);
		
		return "board/detail";
	}
	
	@GetMapping(path = { "/update" })
	public String showUpdateForm(int bNo, Model model) {
	
		Board board = boardService.findBoardByBNo(bNo);
		if (board == null) {
			return "redirect:list";
		}
		
		model.addAttribute("board", board);
		
		return "board/update";
	}
	
	@PostMapping(path = { "/update" })
	public String update(@RequestParam("bNo") int bno, int pageNo, String title, Board board, String smarteditor,
						@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchKey, HttpServletRequest req) {

		board.setBno(bno);
		
		board.setContent(smarteditor);
		
		boardService.updateBoard(board);
		
		String encodedKey = "";
		
		try {
			//URL경로에서 한글을 처리하기 위한 구현
			encodedKey = URLEncoder.encode(searchKey, "utf-8");
		} catch(Exception ex) {
		}
		
		return String.format("redirect:detail?BNo=%d&pageNo=%d&searchType=%s&searchKey=%s", board.getBno(), pageNo, searchType, encodedKey);
	}
	

	
	@GetMapping(path = { "/delete" })
	public String delete(int bNo, int pageNo, @RequestParam(required = false) String searchType, 
						@RequestParam(required = false) String searchKey) {
		
		boardService.deleteBoard(bNo);
		
		String encodedKey = "";
		try {
			//URL경로에서 한글을 처리하기 위한 구현
			encodedKey = URLEncoder.encode(searchKey, "utf-8");
		} catch(Exception ex) {
		}
		
		return String.format("redirect:list?pageNo=%d&searchKey=%s&searchType=%s", 
				 pageNo, encodedKey, searchType);
	}
	
	
}
