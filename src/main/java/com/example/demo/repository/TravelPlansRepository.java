package com.example.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.TravelPlans;

@Mapper
public interface TravelPlansRepository {

	@Insert("INSERT INTO `TravelPlans` SET memberId = #{loginedMemberId}, loginId = #{loginId}, startDate = #{startDate}, endDate = #{endDate}, regDate = NOW(), updateDate = NOW(), destinationId = 1, destinationName = '서울' ") 
	public  TravelPlans giveDateValue(int loginedMemberId, String loginId, String startDate, String endDate);


}