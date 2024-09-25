package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TravelPlanPlaces {

	private int id;
	private int travelPlanId;
	private String placeName;
	private String regDate;
	
}
