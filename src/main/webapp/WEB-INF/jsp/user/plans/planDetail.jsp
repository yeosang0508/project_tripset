<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resource/css/planDetail.css" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../popups/CheckMySchedulePopup.jspf"%>
<%@ include file="../popups/CheckDeletePopup.jspf" %>

<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services"></script>
<script>
    // JSP 데이터를 JavaScript 배열로 변환하여 travelPlaces 변수에 전달
    var travelPlaces = [
        <c:forEach var="place" items="${travelPlaces}" varStatus="status">
        {
            placeName: "${place.placeName}"
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
</script>
<script src="/resource/js/planDetail.js"></script>

<main>
    <section class="container">
        <div id="map-container">
            <div id="staticMap">
                <div id="map" style="width: 100%; height: 350px;"></div>
            </div>
        </div>
        <aside>
            <div class="flex justify-between items-center w-full">
                <h2 class="font-bold">${travelPlan.region}여행✨${travelPlan.startDate}~${travelPlan.endDate}</h2>
                <div class="flex gap-2">
                    <div class="text-gray-500 cursor-pointer" onclick="location.href='/usr/plans/update?id=${travelPlan.id}'">수정</div>
                    <div class="nav-delete-button text-gray-500 cursor-pointer">삭제</div>
                </div>
            </div>

            <!-- 여행 계획 슬라이더 -->
            <section id="travelPlanSlider">
                <div id="travelPlanInfo" class="slider-container">
                    <c:forEach var="place" items="${travelPlaces}" varStatus="status">
                        <div class="timeline-item">
                            <div class="step-number">${status.index + 1}</div>
                            <div class="step-label">${place.placeName}</div>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </aside>
    </section>
</main>


</body>
