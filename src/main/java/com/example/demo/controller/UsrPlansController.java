package com.example.demo.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.TravelPlansService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.TravelPlans;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrPlansController {
	
	@Autowired
	private Rq rq;
	
	@Autowired
	private TravelPlansService travelPlansService;
	
	@RequestMapping("/usr/plans/write")
	public String showWrite(HttpServletRequest req,Model model) {
		
		return "/user/plans/write";

	}


	
	@RequestMapping("/usr/plans/doWriteTravelPlan")
	@ResponseBody
	public String doWriteTravelPlan(HttpServletRequest req, String startDate, String endDate) {

		Rq rq = (Rq) req.getAttribute("rq");
		
		boolean isLogined = rq.isLogined();
		
		if(isLogined == false) {
			return Ut.jsHistoryBack("F-1", "로그인 먼저 해주세요");
		}
		
		int loginedMemberId = rq.getLoginedMemberId();
		
		Member loginedMember = rq.getLoginedMember();	
		String loginId = loginedMember.getLoginId();
	
	
		travelPlansService.writeTravelPlan(loginedMemberId,loginId, startDate, endDate);
		
		
		
		return loginId;

	}

}
