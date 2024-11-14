package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.TravelPlanPlaces;
import com.example.demo.vo.TravelPlans;

@Mapper
public interface TravelPlansRepository {

	// TravelPlans 테이블에 데이터 삽입
	@Insert("INSERT INTO `TravelPlans` " + "(memberId, loginId, startDate, endDate, regDate, updateDate, region) "
			+ "VALUES (#{loginedMemberId}, #{loginId}, #{startDate}, #{endDate}, NOW(), NOW(), #{region})")
	int writeTravelPlan(int loginedMemberId, String loginId, String startDate, String endDate, String region);

	// TravelPlanPlaces 테이블에 여러 장소 데이터 삽입
	@Insert({ "<script>", "INSERT INTO `travelPlanPlaces` (travelPlanId, placeName, regDate) ", "VALUES ",
			"<foreach collection='places' item='place' separator=','>", "(#{travelPlanId}, #{place}, NOW())",
			"</foreach>", "</script>" })
	void insertTravelPlanPlaces(@Param("travelPlanId") int travelPlanId, @Param("places") List<String> places);

	// 마지막 삽입된 ID 가져오기
	@Select("SELECT LAST_INSERT_ID()")
	int getLastInsertedId();

	@Select("""
			SELECT *
			FROM `travelPlans`
			WHERE memberId = #{loginedMemberId}
			AND delStatus = 0
			ORDER BY startDate DESC
			""")
	List<TravelPlans> getRecentPlans(int loginedMemberId);

	@Select("""
			SELECT *
			FROM `travelPlans`
			WHERE id = #{travelPlanId}
			""")
	TravelPlans getTravelPlanById(int travelPlanId);

	@Select("""
			SELECT travelPlanPlaces.id,
			travelPlanPlaces.placeName
			FROM travelPlans
			INNER JOIN travelPlanPlaces
			ON travelPlans.id = travelPlanPlaces.travelPlanId
			WHERE travelPlans.id = #{id}
			""")
	List<TravelPlanPlaces> getTravelPlansWithPlacesById(@Param("id") int travelPlanId);

	// travelPlanPlaces 테이블에서 travelPlanId에 해당하는 레코드 삭제
	@Delete("DELETE FROM travelPlanPlaces WHERE travelPlanId = #{travelPlanId}")
	void deleteTravelPlanPlaces(int travelPlanId);

	// travelPlans 테이블에서 travelPlanId에 해당하는 레코드 삭제
	@Delete("DELETE FROM travelPlans WHERE id = #{travelPlanId}")
	void deleteTravelPlan(int travelPlanId);

	   // memberId로 여행 계획을 조회하는 쿼리
    @Select("""
        SELECT * FROM travelPlans
        WHERE memberId = #{memberId}
        """)
    List<TravelPlans> findByMemberId(@Param("memberId") int memberId);

    // memberId로 여행 계획에 포함된 장소를 조회하는 쿼리
    @Select("""
        SELECT travelPlanPlaces.id, travelPlanPlaces.placeName, travelPlanPlaces.travelPlanId, travelPlanPlaces.regDate
        FROM travelPlanPlaces
        JOIN travelPlans ON travelPlanPlaces.travelPlanId = travelPlans.id
        WHERE travelPlans.memberId = #{memberId}
        """)
    List<TravelPlanPlaces> findPlacesByMemberId(@Param("memberId") int memberId);

    // 현재 게시글 ID 조회
    @Select("""
        SELECT MAX(id) FROM article
        """)
    int getCurrentArticleId();
}