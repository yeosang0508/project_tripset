package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface TravelPlansRepository {

    // TravelPlans 테이블에 데이터 삽입
    @Insert("INSERT INTO `TravelPlans` " +
            "(memberId, loginId, startDate, endDate, regDate, updateDate, region) " +
            "VALUES (#{loginedMemberId}, #{loginId}, #{startDate}, #{endDate}, NOW(), NOW(), #{region})")
    int writeTravelPlan(int loginedMemberId, String loginId, String startDate, String endDate, String region);

    // TravelPlanPlaces 테이블에 여러 장소 데이터 삽입
    @Insert({
        "<script>",
        "INSERT INTO `travelPlanPlaces` (travelPlanId, placeName, regDate) ",
        "VALUES ",
        "<foreach collection='places' item='place' separator=','>",
        "(#{travelPlanId}, #{place}, NOW())",
        "</foreach>",
        "</script>"
    })
    void insertTravelPlanPlaces(@Param("travelPlanId") int travelPlanId, @Param("places") List<String> places);

    // 마지막 삽입된 ID 가져오기
    @Select("SELECT LAST_INSERT_ID()")
    int getLastInsertedId();
}
