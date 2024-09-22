package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TravelPlans {

	private int id;
	private int memberId; 
	private String loginId;
	private String startDate;
	private String endDate;
	private String regDate;
	private String updateDate; 
	private String region; 
	private int status;
	private boolean delStatus;
	private String delDate; 

}