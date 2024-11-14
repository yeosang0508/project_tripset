package com.example.demo.service;

import java.util.List;
import java.util.stream.Collectors;

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
	public void createTravelPlan(int loginedMemberId, String loginId, String startDate, String endDate, String region,
			List<String> places) {
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

	@Transactional
	public void deleteTravelPlan(int travelPlanId) {
		travelPlansRepository.deleteTravelPlanPlaces(travelPlanId);
		travelPlansRepository.deleteTravelPlan(travelPlanId);
	}
	
	@Transactional
	public void updateTravelPlan(int loginedMemberId, String loginId, List<Integer> placeIds, String startDate,
	                             String endDate, String region, List<String> places) {

	    // 여행 계획의 기본 정보를 업데이트
		for (Integer placeId : placeIds) {

	            travelPlansRepository.deleteTravelPlanPlaces(placeId);
	       
	    }
		
		
		if (!region.isEmpty()) {
	         // TravelPlans 테이블에 데이터 삽입
	    		travelPlansRepository.writeTravelPlan(loginedMemberId, loginId, startDate, endDate, region);

	    		// 삽입된 TravelPlan의 ID를 가져옴
	    		int travelPlanId = travelPlansRepository.getLastInsertedId();

	    		// travelPlanPlaces 테이블에 장소 목록을 삽입
	    		travelPlansRepository.insertTravelPlanPlaces(travelPlanId, places);
	        }
		
	}

	 public List<TravelPlans> getTravelPlansByMemberId(int memberId) {
	        return travelPlansRepository.findByMemberId(memberId);
	    }

	    public List<TravelPlanPlaces> getTravelPlanPlacesByMemberId(int memberId) {
	        return travelPlansRepository.findPlacesByMemberId(memberId);
	    }

	    public int getCurrentArticleId() {
	        return travelPlansRepository.getCurrentArticleId();
	    }


}
