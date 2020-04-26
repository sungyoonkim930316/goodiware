package com.goodiware.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.goodiware.service.ReferenceService;
import com.goodiware.vo.Reference;
import com.goodiware.vo.Refreply;
import com.goodiware.ui.ThePager2;

@Controller
@RequestMapping(path = { "/reference" })
public class ReferenceController {

	@Autowired
	@Qualifier("referenceService")
	private ReferenceService referenceService;
	
	// 자료실 목록으로 이동 - 자료실 리스트 백업
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
//		List<Reference> references = referenceService.findRefWithPaging(params);
//		int boardCount = referenceService.findRefCount(params); // 전체 글 개수
//
//		ThePager2 pager = new ThePager2(boardCount, pageNo, pageSize, pagerSize, "list", req.getQueryString());
//
//		model.addAttribute("references", references);
//		model.addAttribute("pager", pager);
//		
//		return "/reference/list";
//	}
	
	// 자료실 리스트 페이징 수정
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
		List<Reference> references = referenceService.findRefWithPaging(params);
		int boardCount = referenceService.findRefCount(params); // 전체 글 개수
		model.addAttribute("references", references);
		
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
			System.out.println("파일이 없습니다.");
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
	public String showDetail(int refNo, @RequestParam(defaultValue = "1") int pageNo, Model model,
			HttpServletRequest req, HttpServletResponse resp) {
 
		Reference reference = referenceService.findRefByRefNo(refNo);
		
		if (reference == null) {
			return "redirect:list";
		}

		// 2. 조회된 데이터를 View에서 사용할 수 있도록 저장
		model.addAttribute("reference", reference);

		// 댓글 조회
		int pageSize = 10;
		int pagerSize = 5;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("refno", refNo);
		params.put("pageSize", pageSize);
		
		List<Reference> replies = referenceService.getReplyWithPagingByRefNo(params);
		int replyCount = referenceService.getReplyCount(params);
		
		model.addAttribute("replies", replies);
		
		///////////////////////////////////////////////////////////
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
	
	//////////////////////////////////////////////////////////////
	
	// 댓글 영역
	@RequestMapping(path= {"replyWrite"})
	@ResponseBody
	public String replyWrite(Refreply refreply) {
		
		referenceService.writeReply(refreply);
		
		return "success";
		
	}
	
	@GetMapping(path= {"/list-by/{refno}/{pageNo}"})
	public String listByRefno(@PathVariable int refno, @PathVariable int pageNo, Model model) {
		
		int pageSize = 10;
		int pagerSize = 5;
		HashMap<String, Object> params = new HashMap<>();
		int beginning = (pageNo - 1) * pageSize;
		params.put("beginning", beginning);
		params.put("end", beginning + pageSize);
		params.put("refno", refno);
		params.put("pageSize", pageSize);
		
		List<Reference> replies = referenceService.getReplyWithPagingByRefNo(params);
		int replyCount = referenceService.getReplyCount(params);
		
		model.addAttribute("replies", replies);
		
		///////////////////////////////////////////////////////////
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
		
		return "/reference/reply-list";
	}
	
	@DeleteMapping(path= {"/delete/{refrno}"})
	@ResponseBody
	public String deleteReply(@PathVariable int refrno ) {
		
		referenceService.deleteReply(refrno);
		
		return "success";
	}
	
	@PutMapping(path= {"/update/"}, consumes="application/json")
	@ResponseBody
	public String editReply(@RequestBody Refreply refreply) {
		
		System.out.println("content : " +refreply.getReplycontent());
		
		referenceService.editReply(refreply);
		
		return "success";
	}
	
	@PostMapping(path= {"rewrite"})
	@ResponseBody
	public String rewrite(Refreply refreply) {
		
		referenceService.insertReReply(refreply);
		
		return "success";
	}
	
}
