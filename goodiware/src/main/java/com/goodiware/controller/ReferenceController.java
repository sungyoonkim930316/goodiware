package com.goodiware.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
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
import org.springframework.web.multipart.MultipartFile;

import com.goodiware.service.ReferenceService;
import com.goodiware.vo.Reference;
import com.goodiware.ui.ThePager2;

@Controller
@RequestMapping(path = { "/reference" })
public class ReferenceController {

	@Autowired
	@Qualifier("referenceService")
	private ReferenceService referenceService;
	
	// 자료실 목록으로 이동
	@GetMapping(path = { "/list" })
	public String toList(@RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(required = false) String searchType, @RequestParam(required = false) String searchKey,
			HttpServletRequest req, Model model) {
		
		int pageSize = 5;
		int pagerSize = 10;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("searchType", searchType);
		params.put("searchKey", searchKey);

		// 
		List<Reference> references = referenceService.findRefWithPaging(params);
		int boardCount = referenceService.findRefCount(params); // 전체 글 개수

		ThePager2 pager = new ThePager2(boardCount, pageNo, pageSize, pagerSize, "list", req.getQueryString());

		model.addAttribute("references", references);
		model.addAttribute("pager", pager);
		
		return "/reference/list";
	}
	
	// 자료실 글쓰기로 이동
	@GetMapping(path = { "/upload" })
	public String toWrite() {
		return "/reference/upload";
	}
	
	// 자료실 업로드 요청 처리
	@PostMapping(path = { "/upload" })
	public String uploadRef(@RequestParam("filename") MultipartFile ref, HttpServletRequest req,
			String smarteditor, Reference reference) {
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/reference");
		String fileName = ref.getOriginalFilename();
		try {
			File file = new File(path, fileName);
			ref.transferTo(file);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		
		System.out.println("스마트 에디터 본문 : " + smarteditor);
		System.out.println("파일 경로 : " + path);
		System.out.println("업로드 파일 : " + fileName);
		reference.setRefcontent(smarteditor);
		reference.setReffilename(fileName);
		reference.setRefpath(path);
		
		referenceService.insertRef(reference);
		
		return "redirect:/reference/list";
	}
	
	@GetMapping(path = { "/detail" })
	public String showDetail(int refNo, @RequestParam(defaultValue = "1") int pageNo, Model model,
			HttpServletRequest req, HttpServletResponse resp) {
 
		Reference reference = referenceService.findRefByRefNo(refNo);
		
		if (reference == null) {
			return "redirect:list";
		}

		// 2. 조회된 데이터를 View에서 사용할 수 있도록 저장
		model.addAttribute("reference", reference);

		// 3. View로 이동
		return "reference/detail";
	}
	
	@GetMapping(path = { "/download" })
	public void downloadResume(int refNo, HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		Reference reference = referenceService.findUploadFileByRefNo(refNo);

		// 다운로드 처리
		// ServletContext : JSP의 application객체와 동일한 객체
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("resources/file/reference/" + reference.getReffilename());

		// System.out.println(fileName);

		// 브라우저가 응답 컨텐츠를 다운로드로 처리하도록 정보 설정 / 브라우저 속이기
		resp.setContentType("application/octet-stream;charset=utf-8");

		// 브라우저에게 다운로드하는 파일의 이름을 알려주는 코드
		resp.addHeader("Content-Disposition",
				// "Attachment;filename=\"" + fileName + "\"");
				"Attachment;filename=\"" + new String(reference.getReffilename().getBytes("utf-8"), "ISO-8859-1") + "\"");

		FileInputStream fis = new FileInputStream(path); // 파일을 읽는 도구
		OutputStream fos = resp.getOutputStream(); // 브라우저에게 전송하는 도구

		while (true) {
			int data = fis.read(); // 파일에서 1byte 읽기
			if (data == -1) { // 더 이상 읽을 데이터가 없다면 (EOF)
				break;
			}
			fos.write(data); // 응답 스트림에 1byte 쓰기
		}

		fis.close();
		fos.close();
	}
	
	@GetMapping(path = { "/delete" })
	public String delete(int refNo, int pageNo,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKey) {
		
		referenceService.deleteReference(refNo);
		
		String encodedKey = "";
		try {
			//URL경로에서 한글을 처리하기 위한 구현
			encodedKey = URLEncoder.encode(searchKey, "utf-8");
		} catch(Exception ex) {
		}
		
		return String.format("redirect:list?pageNo=%d&searchKey=%s&searchType=%s", 
							 pageNo, encodedKey, searchType);
	}
	
	@GetMapping(path = { "/update" })
	public String showUpdateForm(int refNo, Model model) {
	
		Reference reference = referenceService.findRefByRefNo(refNo);
		if (reference == null) {
			return "redirect:list";
		}
		
		model.addAttribute("reference", reference);
		
		return "reference/update";
	}
	
	@PostMapping(path = { "/update" })
	public String update(@RequestParam("refFile") MultipartFile ref, 
			Reference reference, int pageNo, String refName, int refNo, String smarteditor,
			@RequestParam(required = false) String searchType,
			@RequestParam(required = false) String searchKey, HttpServletRequest req) {
			
		reference.setRefno(refNo);
		reference.setRefcontent(smarteditor);
		
		ServletContext application = req.getServletContext();
					
		String path = application.getRealPath("resources/file/reference/" + refName);
		
		String newPath = application.getRealPath("resources/file/reference");
		String newFilename = ref.getOriginalFilename();
		
		System.out.println("**********************************");
		System.out.println("기존 파일 : " + path);
		System.out.println("경로 : " + newPath);
		System.out.println("새 파일 : " + newFilename);
		System.out.println("**********************************");
		
		//새로운 파일이 등록되었는지 확인
		if(ref.getOriginalFilename() != null && !ref.getOriginalFilename().equals("")) {
			// 기존 파일을 삭제
			new File(path).delete();
						
			// 새로 첨부한 파일을 등록
			try {
				File f = new File(newPath, newFilename);
				ref.transferTo(f);
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			System.out.println("새 자료 : " + newFilename);
			reference.setRefpath(newPath);
			reference.setReffilename(newFilename);
			
		} else { // 새 파일이 등록되지 않았다면
			// 기존 파일 그대로 사용
			reference.setReffilename(req.getParameter("refName"));
		}
		
		referenceService.updateRef(reference);
		
		String encodedKey = "";
		
		try {
			//URL경로에서 한글을 처리하기 위한 구현
			encodedKey = URLEncoder.encode(searchKey, "utf-8");
		} catch(Exception ex) {
		}
		
		return String.format(
				"redirect:detail?refNo=%d&pageNo=%d&searchType=%s&searchKey=%s", 
				reference.getRefno(), pageNo, searchType, encodedKey);
	}
	
}
