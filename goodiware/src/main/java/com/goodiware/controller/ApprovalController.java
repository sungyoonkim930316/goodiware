package com.goodiware.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.goodiware.service.ApprovalService;
import com.goodiware.vo.ApprDiv;

@Controller
@RequestMapping(path= {"/appr/"})
public class ApprovalController {
	
	@Autowired
	@Qualifier("approvalService")
	ApprovalService approvalService;

	@GetMapping(path= {"/regist"})
	public String getApprRegist(Model model) {
		
		List<ApprDiv> apprdivs = approvalService.getApprDivs();
		model.addAttribute("apprdivs", apprdivs);
		
		return "/approval/regist";
	}
	
}
