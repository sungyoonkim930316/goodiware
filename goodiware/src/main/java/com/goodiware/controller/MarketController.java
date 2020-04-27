package com.goodiware.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.goodiware.service.MarketService;
import com.goodiware.ui.ThePager2;
import com.goodiware.vo.Board;

@Controller
@RequestMapping(path= {"/market"})
public class MarketController {
	
	@Autowired
	@Qualifier("marketService")
	private MarketService marketService;

	// 자료실 목록으로 이동
//	@GetMapping(path = { "/list" })
//	public String toList(@RequestParam(defaultValue = "1") int pageNo,
//			@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchKey,
//			HttpServletRequest req, Model model) {
//		
//		int pageSize = 5;
//		int pagerSize = 10;
//		HashMap<String, Object> params = new HashMap<>();
//		int beginning = (pageNo - 1) * pageSize;
//		params.put("beginning", beginning);
//		params.put("end", beginning + pageSize);
//		params.put("searchType", searchType);
//		params.put("searchKey", searchKey);
//
//		// 
//		List<Board> boards = marketService.findBoardWithPaging(params);
//		int boardCount = marketService.findBoardCount(params); // 전체 글 개수
//
//		ThePager2 pager = new ThePager2(boardCount, pageNo, pageSize, pagerSize, "list", req.getQueryString());
//
//		model.addAttribute("boards", boards);
//		model.addAttribute("pager", pager);
//		
//		
//		return "market/marketlist";
//	}

	// 리스트 페이징 수정
	@GetMapping(path = { "/list" })
	public String toList(@RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchKey,
			HttpServletRequest req, Model model) {
		
		int pageSize = 10;
		int pagerSize = 5;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("searchType", searchType);
		params.put("searchKey", searchKey);
		params.put("pageSize", pageSize);
		
		// 
		List<Board> boards = marketService.findBoardWithPaging(params);
		int boardCount = marketService.findBoardCount(params); // 전체 글 개수
		
		model.addAttribute("boards", boards);
		
		///////////////////////////////////////////////////////////
		int pageCount = ( boardCount / pageSize ) + (( boardCount % pageSize ) > 0 ? 1 : 0 );
		int pagerBlock = ( pageNo -1 ) / pagerSize;
		int start = (pagerBlock * pagerSize ) + 1;
		int end = start + pagerSize;
		
		HashMap<String, Integer> pager = new HashMap<String, Integer>();
		
		pager.put("pageNo", pageNo);
		pager.put("boardCount", boardCount);
		pager.put("pageCount", pageCount);
		pager.put("pageBlock", pagerBlock);
		pager.put("start", start);
		pager.put("end", end);
		model.addAttribute("pager", pager);
		
		return "market/marketlist";
	}
		
	// 게시판 글쓰기로 이동
	@GetMapping(path= {"/write"})
	public String toWrite() {
		return "/market/marketwrite";
	}
	
	@PostMapping(path = { "/write.action" })
	public String write(@RequestParam("filename") MultipartFile ref, HttpServletRequest req,
			String smarteditor, Board board) { // 글쓰기 처리
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/board");
		String fileName = ref.getOriginalFilename();
		try {
			File file = new File(path, fileName);
			ref.transferTo(file);
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("파일이 없습니다.");
		}
		
		System.out.println("스마트 에디터 본문 : " + smarteditor);
		System.out.println("파일 경로 : " + path);
		System.out.println("업로드 파일 : " + fileName);
		board.setContent(smarteditor);
		board.setPicture(fileName);
		board.setPicturepath(path);

		marketService.writeBoard(board);

		return "redirect:/market/list";
	}
	
	// 스마트 에디터 이미지 업로드
	@RequestMapping(path = "/galleryimageupload")
	public String imageUpload(MultipartFile Filedata, String callback, String callback_func, HttpServletRequest req) throws Exception {
		
		String return1 = callback;
		String return2 = "?callback_func=" + callback_func;
		String return3 = "";
		String fileName = "";
		
		if (Filedata != null) {
					
			fileName = Filedata.getOriginalFilename();
            String ext = fileName.substring(fileName.lastIndexOf(".")+1);
            //파일 기본경로
            String defaultPath = req.getServletContext().getRealPath("/");
            //파일 기본경로 _ 상세경로
            String path = defaultPath + "resources" + File.separator + "upload" + File.separator;
             
            File file = new File(path);
             
            //디렉토리 존재하지 않을경우 디렉토리 생성
            if(!file.exists()) {
                file.mkdirs();
            }
            
            //서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)
            String realname = UUID.randomUUID().toString() + "." + ext;
            ///////////////// 서버에 파일쓰기 ///////////////// 
            Filedata.transferTo(new File(path + realname));
            
            System.out.println("경로 : " + path);
    		System.out.println("파일네임 : " + fileName);
    		System.out.println("리얼네임 : " + realname);

            return3 += "&bNewLine=true&sFileName="+fileName+"&sFileURL=/resources/upload/"+realname;
        }else {
            return3 += "&errstr=error";
        }
		
		return "redirect:" + return1+return2+return3;
	}
		
	@RequestMapping(path = "/galleryimageupload2")
	@ResponseBody
	public String imageUpload2(HttpServletRequest req) throws Exception {
		String sFileInfo = "";
		//파일명 - 싱글파일업로드와 다르게 멀티파일업로드는 HEADER로 넘어옴 
		String name = req.getHeader("file-name");
		String ext = name.substring(name.lastIndexOf(".")+1);
		//파일 기본경로
		String defaultPath = req.getServletContext().getRealPath("/");
		//파일 기본경로 _ 상세경로
		String path = defaultPath + "upload" + File.separator;
		File file = new File(path);
		if(!file.exists()) {
		    file.mkdirs();
		}
		String realname = UUID.randomUUID().toString() + "." + ext;
		InputStream is = req.getInputStream();
		OutputStream os=new FileOutputStream(path + realname);
		int numRead;
		// 파일쓰기
		byte b[] = new byte[Integer.parseInt(req.getHeader("file-size"))];
		while((numRead = is.read(b,0,b.length)) != -1){
		    os.write(b,0,numRead);
		}
		if(is != null) {
		    is.close();
		}
		os.flush();
		os.close();
		sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+"/goodiware/upload/"+realname;
		
		return sFileInfo;
		
	}
	
	@GetMapping(path = { "/detail" })
	public String showDetail(@RequestParam("BNo") int bNo, Model model){
 
		Board board = marketService.findBoardByBNo(bNo);
		
		if (board == null) {
			return "redirect:list";
		}
		

		// 2. 조회된 데이터를 View에서 사용할 수 있도록 저장
		model.addAttribute("board", board);

		// 3. View로 이동
		return "market/marketdetail";
	}
	
	@GetMapping(path = { "/update" })
	public String showUpdateForm(int bNo, Model model) {
	
		Board board = marketService.findBoardByBNo(bNo);
		if (board == null) {
			return "redirect:list";
		}
		
		model.addAttribute("board", board);
		
		return "market/marketupdate";
	}
	
	@PostMapping(path = { "/update" })
	public String update(@RequestParam("bNo") int bno, int pageNo, String title,
			Board board, String smarteditor,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKey, HttpServletRequest req) {

		
		board.setBno(bno);
		
		board.setContent(smarteditor);
		
		marketService.updateBoard(board);
		
		String encodedKey = "";
		
		try {
			//URL경로에서 한글을 처리하기 위한 구현
			encodedKey = URLEncoder.encode(searchKey, "utf-8");
		} catch(Exception ex) {
		}
		
		
		
		return String.format(
				"redirect:detail?BNo=%d&pageNo=%d&searchType=%s&searchKey=%s", 
				board.getBno(), pageNo, searchType, encodedKey);
	}
	

	
	@GetMapping(path = { "/delete" })
	public String delete(int bNo, int pageNo,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKey) {
		
		marketService.deleteBoard(bNo);
		
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
