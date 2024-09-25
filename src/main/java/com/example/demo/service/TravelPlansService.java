package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.repository.TravelPlansRepository;
import com.example.demo.vo.TravelPlanPlaces;
import com.example.demo.vo.TravelPlans;


@Service
public class TravelPlansService {
	

	 private final TravelPlansRepository travelPlansRepository;

	    @Autowired
	    public TravelPlansService(TravelPlansRepository travelPlansRepository) {
	        this.travelPlansRepository = travelPlansRepository;
	    }

	    @Transactional
	    public void createTravelPlan(int loginedMemberId, String loginId, String startDate, String endDate, String region, List<String> places) {
	        // TravelPlans 테이블에 데이터 삽입
	        travelPlansRepository.writeTravelPlan(loginedMemberId, loginId, startDate, endDate, region);

	        // 삽입된 TravelPlan의 ID를 가져옴
	        int travelPlanId = travelPlansRepository.getLastInsertedId();

	        // travelPlanPlaces 테이블에 장소 목록을 삽입
	        travelPlansRepository.insertTravelPlanPlaces(travelPlanId, places);
	}

	    // 로그인한 회원 일정 가져오기
		public List<TravelPlans> getRecentPlans(int loginedMemberId) {
			
			return travelPlansRepository.getRecentPlans(loginedMemberId);
		}

		public TravelPlans getTravelPlanById(int travelPlanId) {
			
			return travelPlansRepository.getTravelPlanById(travelPlanId);
		}
		
		public List<TravelPlanPlaces> getTravelPlansWithPlacesById(int travelPlanId) {
			return travelPlansRepository.getTravelPlansWithPlacesById(travelPlanId);
		}

		
}
