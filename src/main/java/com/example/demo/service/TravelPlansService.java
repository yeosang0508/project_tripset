package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.TravelPlansRepository;
import com.example.demo.vo.TravelPlans;

@Service
public class TravelPlansService {
	

	@Autowired
	private TravelPlansRepository travelPlansRepository;

	public TravelPlans writeTravelPlan(int loginedMemberId, String loginId, String startDate, String endDate) {
		System.err.println(loginedMemberId);
		System.err.println(loginId);
		System.err.println(startDate);
		System.err.println(endDate);
		
		return travelPlansRepository.writeTravelPlan(loginedMemberId, loginId, startDate, endDate);
	}


}
