package com.example.demo.controller;

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

    // 질문 입력 페이지를 렌더링하는 메서드
    @GetMapping("/question")
    public String showQuestionForm() {
        return "user/recommended/question";  
    }

    // 질문을 받아 Flask 서버에 보내는 메서드
    @GetMapping("/ask")
    public String askQuestion(@RequestParam("question") String question, Model model) {
        // 질문을 Flask 서버로 전달하고 응답을 받음
        String response = recommendedService.sendQuestionToFlask(question);

        model.addAttribute("response", response);

        return "user/recommended/answer";
    }
}



