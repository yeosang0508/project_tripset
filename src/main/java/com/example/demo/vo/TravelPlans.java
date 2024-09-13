package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TravelPlans {

	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String memberId;
	private int startDate;
	private String endDate;
	private String destinationId;
	private String destinationName;
	private String status;
	private boolean delStatus;
	private String delDate;


}