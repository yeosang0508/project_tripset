package com.example.demo.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.client.RestTemplate;

@Controller
public class UsrRecommendedController {

    @GetMapping("/test.do")
    public ModelAndView test() {
        ModelAndView mav = new ModelAndView();
        
        // Flask 서버 URL
        String url = "http://127.0.0.1:5001/tospring";
        
        // RestTemplate을 사용하여 GET 요청 보내기
        RestTemplate restTemplate = new RestTemplate();
        try {
            // GET 요청으로 Flask 서버에서 데이터를 가져오기
            String response = restTemplate.getForObject(url, String.class);
            mav.addObject("test1", response);  // JSP에서 사용할 데이터
            mav.addObject("fail", false);      // 성공 여부 전달
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("fail", true);       // 실패 시 JSP에 전달
        }
        
        mav.setViewName("test");  // JSP 파일 이름 (test.jsp)
        return mav;
    }
}
