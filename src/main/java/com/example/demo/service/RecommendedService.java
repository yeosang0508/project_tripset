package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class RecommendedService {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    @Autowired
    public RecommendedService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
        this.objectMapper = new ObjectMapper();
    }

    public List<Map<String, String>> sendQuestionToFlask(Map<String, String> params) {
        String url = "http://127.0.0.1:5001/api/text";

        // Flask 서버에 보낼 데이터 구성
        Map<String, String> requestData = new HashMap<>(params);
        String who = params.get("who");
        String how = params.get("how");
        String time = params.get("time");
        String style = params.get("style");
        String region = params.get("region");
        
        requestData.put("who", who);
        requestData.put("how", how);
        requestData.put("time", time);
        requestData.put("style", style);
        requestData.put("region", region);
        
        // Flask 서버에 POST 요청 보내기
        ResponseEntity<String> response = restTemplate.postForEntity(url, requestData, String.class);

        System.err.println("응답 데이터: " + response.getBody());
        
        // Flask 서버에서 받은 응답 처리
        if (response.getStatusCode() == HttpStatus.OK) {
        	try {
        	    // JSON 문자열을 Map으로 변환
        	    Map<String, Object> responseBody = objectMapper.readValue(
        	            response.getBody(), new TypeReference<Map<String, Object>>() {});

        	    System.out.println("파싱된 응답 데이터: " + responseBody);

        	    Object resultObject = responseBody.get("result");
        	    if (resultObject instanceof List) {
        	        return (List<Map<String, String>>) resultObject;
        	    } else {
        	        throw new RuntimeException("Result 필드가 예상한 형식이 아닙니다. 현재 형식: " + resultObject.getClass().getName());
        	    }
        	} catch (ClassCastException e) {
        	    e.printStackTrace();
        	    throw new RuntimeException("Result 필드의 형식 변환 실패: " + e.getMessage());
        	} catch (Exception e) {
        	    e.printStackTrace();
        	    throw new RuntimeException("flask 파싱 실패", e);
        	}

        } else {
            throw new RuntimeException("flask 응답 실패");
        }
    }
}