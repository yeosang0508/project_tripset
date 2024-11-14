package com.example.demo.controller;

import com.example.demo.service.TravelPlansService;
import com.example.demo.vo.TravelPlans;
import com.example.demo.vo.TravelPlanPlaces;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import java.util.List;

public class BaseTravelPlanController {
    @Autowired
    protected TravelPlansService travelPlansService;

    // 공통으로 여행 계획 정보를 모델에 추가하는 메서드
    protected void addTravelPlanInfoToModel(int travelPlanId, Model model) {
        TravelPlans travelPlan = travelPlansService.getTravelPlanById(travelPlanId);
        List<TravelPlanPlaces> travelPlaces = travelPlansService.getTravelPlansWithPlacesById(travelPlanId);

        model.addAttribute("travelPlan", travelPlan);
        model.addAttribute("travelPlaces", travelPlaces);
        model.addAttribute("travelPlanId", travelPlanId);
    }
}
