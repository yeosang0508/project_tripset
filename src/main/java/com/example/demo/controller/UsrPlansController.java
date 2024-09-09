package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UsrPlansController {
	@RequestMapping("/usr/plans/write")
	public String showMain() {

		return "/user/plans/write";
	}


}
