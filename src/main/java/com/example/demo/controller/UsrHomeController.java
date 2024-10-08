package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrHomeController {

	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		return "/user/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {

		return "redirect:/usr/home/main";
	}
	
	@RequestMapping("/usr/recommended/travelAnswer")
	public String show() {

		return "/user/recommended/travelAnswer";
	}

	@RequestMapping("/usr/article/articleWrite")
	public String showw() {

		return "/user/article/articleWrite";
	}
	
}

