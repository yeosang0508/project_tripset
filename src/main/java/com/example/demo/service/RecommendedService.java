package com.example.demo.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class RecommendedService {
    private final RestTemplate restTemplate;

    @Autowired
    public RecommendedService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public String sendQuestionToFlask(String question) {
        String url = "http://127.0.0.1:5001/api/text";

        // Flask 서버에 보낼 데이터 구성
        Map<String, String> requestData = new HashMap<>();
        requestData.put("question", question);

        // Flask 서버에 POST 요청 보내기
        ResponseEntity<Map> response = restTemplate.postForEntity(url, requestData, Map.class);

        // Flask 서버에서 받은 응답 처리
        if (response.getStatusCode() == HttpStatus.OK) {
            Map responseBody = response.getBody();
            return responseBody != null ? (String) responseBody.get("result") : "No result";
        } else {
            throw new RuntimeException("Failed to get response from Flask server");
        }
    }
}
