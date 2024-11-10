<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resource/planDetail.css" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../popups/CheckMySchedulePopup.jspf"%>

<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
	  const travelPlanInfo = document.getElementById("travelPlanInfo");
	  travelPlanInfo.scrollLeft = 0; // 초기 스크롤 위치를 설정

	  // 스크롤이 중간에서 시작하지 않도록 강제로 다시 설정
	  setTimeout(() => {
	    travelPlanInfo.scrollLeft = 0;
	  }, 100);
	});

</script>
<main>
	<section class="container">
		<div id="map-container">
			<div id="staticMap">
				<div id="map" style="width: 100%; height: 350px;"></div>
			</div>
		</div>
		<aside>
			<h2 class="font-bold">${travelPlan.region}여행 ✨ ${travelPlan.startDate} ~ ${travelPlan.endDate}</h2>

			<!-- 여행 계획 정보 슬라이더 -->
			<section id="travelPlanSlider">
				<div id="travelPlanInfo" class="slider-container">
					<c:forEach var="plan" items="${travelPlaces}" varStatus="status">
						<div class="timeline-item">
							<div class="step-number">${status.index + 1}</div>
							<div class="step-label">${plan.placeName}</div>
						</div>
					</c:forEach>
				</div>
			</section>
		</aside>
	</section>
</main>
<script>
    var mapContainer = document.getElementById('map'),
        mapOption = {
            center: new kakao.maps.LatLng(36.332326, 127.434211),
            level: 7
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);
    
    var travelPlaces = [
        <c:forEach var="place" items="${travelPlaces}">
        {
            placeName: "${place.placeName}"
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    var ps = new kakao.maps.services.Places();
    var linePath = [];
    var bounds = new kakao.maps.LatLngBounds();

    // 순서대로 각 여행지의 좌표를 검색하고, 마커와 경로를 생성
    (async function fetchPlaceCoordinates() {
        for (const place of travelPlaces) {
            await new Promise((resolve, reject) => {
                ps.keywordSearch(place.placeName, function (data, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        var position = new kakao.maps.LatLng(data[0].y, data[0].x);
                        place.latitude = data[0].y;
                        place.longitude = data[0].x;
                        linePath.push(position);
                        bounds.extend(position);

                        // 마커를 생성하고 지도에 추가
                        createMarker(position, place.placeName);

                        resolve(); // 좌표 검색 완료
                    } else {
                        console.error('목적지의 좌표를 찾을 수 없습니다: ' + place.placeName);
                        resolve(); // 검색 실패 시에도 resolve를 호출
                    }
                });
            });
        }

        // 모든 좌표를 검색한 후 폴리라인을 그리고 지도 범위 설정
        drawPolyline();
        map.setBounds(bounds);
    })();

    function createMarker(position, title) {
        var marker = new kakao.maps.Marker({
            map: map,
            position: position,
            title: title
        });

        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="padding:5px;">' + title + '</div>'
        });

        kakao.maps.event.addListener(marker, 'mouseover', function () {
            infowindow.open(map, marker);
        });

        kakao.maps.event.addListener(marker, 'mouseout', function () {
            infowindow.close();
        });
    }

    // linePath 배열의 좌표를 따라 폴리라인을 그립니다.
    function drawPolyline() {
        var polyline = new kakao.maps.Polyline({
            path: linePath, // 계획된 순서대로 경로를 설정
            strokeWeight: 3,
            strokeColor: '#4B5563',
            strokeOpacity: 0.8,
            strokeStyle: 'solid'
        });
        polyline.setMap(map);
    }
</script>

</body>
