package com.example.demo.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.TravelPlansService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.Rq;
import com.example.demo.vo.TravelPlanPlaces;
import com.example.demo.vo.TravelPlans;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrPlansController {

	@Autowired
	private Rq rq;

	@Autowired
	private TravelPlansService travelPlansService;

	@RequestMapping("/usr/plans/write")
	public String showWrite(HttpServletRequest req, Model model) {

		return "/user/plans/planWrite";

	}

	@RequestMapping("/usr/plans/doWriteTravelPlan")
	@ResponseBody
	public String doWriteTravelPlan(@RequestBody Map<String, Object> requestData, HttpServletRequest req) {
		// 로그인 확인
		Rq rq = (Rq) req.getAttribute("rq");
		boolean isLogined = rq.isLogined();

		if (isLogined == false) {
			return Ut.jsHistoryBack("F-1", "로그인 먼저 해주세요");
		}

		// 로그인된 사용자 정보 가져오기
		int loginedMemberId = rq.getLoginedMemberId();
		Member loginedMember = rq.getLoginedMember();
		String loginId = loginedMember.getLoginId();

		// 요청 데이터에서 startDate, endDate, region, places 추출
		String startDate = (String) requestData.get("startDate");
		String endDate = (String) requestData.get("endDate");
		String region = (String) requestData.get("region");
		List<String> places = (List<String>) requestData.get("places");

		// 여행 일정 저장 로직 (여기서 여행 일정과 지역, 목적지 리스트를 함께 저장하도록 구현해야 함)
		travelPlansService.createTravelPlan(loginedMemberId, loginId, startDate, endDate, region, places);

		return Ut.jsReplace("저장되었습니다.", "/usr/plans/list");
	}

	@RequestMapping("/usr/plans/getUserTravelPlan")
	@ResponseBody
	public List<TravelPlans> getUserTravelPlan(HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");
		int loginedMemberId = rq.getLoginedMemberId();
		return travelPlansService.getRecentPlans(loginedMemberId);
	}

	@RequestMapping("/usr/plans/detail")
	public String showTravelPlanDetail(@RequestParam("id") int travelPlanId, Model model) {
		// travelPlanId에 해당하는 여행 계획 정보 조회
		TravelPlans travelPlan = travelPlansService.getTravelPlanById(travelPlanId);
		List<TravelPlanPlaces> travelPlaces = travelPlansService.getTravelPlansWithPlacesById(travelPlanId);
		
		// 여행 계획 정보 모델에 추가
		model.addAttribute("travelPlan", travelPlan);
		
		// 여행 계획 장소 모델에 추가
		model.addAttribute("travelPlaces", travelPlaces);
		
		System.err.println(travelPlaces);

		return "user/plans/planDetail";
	}
	
	
}
