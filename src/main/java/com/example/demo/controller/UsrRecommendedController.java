package com.example.demo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.RecommendedService;

@Controller
@RequestMapping("/usr/recommended")
public class UsrRecommendedController {

	private final RecommendedService recommendedService;

	@Autowired
	public UsrRecommendedController(RecommendedService recommendedService) {
		this.recommendedService = recommendedService;
	}

	// 질문을 받아 Flask 서버에 보내는 메서드
	@GetMapping("/ask")
	public String askQuestion(@RequestParam Map<String, String> params, Model model) {
		// Flask 서버로 질문을 전달하고 응답을 받음
		List<Map<String, String>> response = recommendedService.sendQuestionToFlask(params);

		String region = params.get("region");
		String style = params.get("style");

		// JSP로 데이터 전달
		model.addAttribute("response", response);
		model.addAttribute("region", region);
		model.addAttribute("style", style);
		
		return "user/recommended/travelAnswer";
	}
}
