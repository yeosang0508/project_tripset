<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../common/head.jspf"%>
<%@ include file="../popups/CheckMySchedulePopup.jspf"%>

<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services"></script>

<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
	background-color: #ffffff;
}

#main-content {
	display: flex;
	justify-content: center;
	align-items: center;
}

#container {
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	align-items: center;
	height: 85vh;
	width: 80vw;
	box-sizing: border-box;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
	border-radius: 15px;
	overflow: hidden;
	overflow-y: auto;
	padding: 20px;
}

#map-container {
	width: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}

#staticMap {
	width: 100%;
	height: 350px;
	border-radius: 10px;
}

#sidebar {
	width: 100%;
	background-color: #f9f9f9;
	padding: 20px;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	align-items: center;
	border-top: 1px solid #ddd;
	margin-top: 20px;
}

.date-picker-container {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	width: 100%;
}

#travelPlanInfo {
	text-align: center;
	margin-top: 20px;
}

#travelPlanInfo h3 {
	margin-bottom: 10px;
}

#travelPlanInfo p {
	margin: 5px 0;
	font-size: 14px;
}
</style>
<style>
.dot {
	overflow: hidden;
	float: left;
	width: 12px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');
}

.dotOverlay {
	position: relative;
	bottom: 10px;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	float: left;
	font-size: 12px;
	padding: 5px;
	background: #fff;
}

.dotOverlay:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.number {
	font-weight: bold;
	color: #ee6152;
}

.dotOverlay:after {
	content: '';
	position: absolute;
	margin-left: -6px;
	left: 50%;
	bottom: -8px;
	width: 11px;
	height: 8px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')
}

.distanceInfo {
	position: relative;
	top: 5px;
	left: 5px;
	list-style: none;
	margin: 0;
}

.distanceInfo .label {
	display: inline-block;
	width: 50px;
}

.distanceInfo:after {
	content: none;
}
</style>

<body>

	<div id="main-content">
		<div id="container">
			<div id="map-container">
				<div id="staticMap">
					<div id="map" style="width: 100%; height: 400px;"></div>
				</div>
			</div>
			<div id="sidebar text-left">
				<div class="font-bold mt-20">${travelPlan.region}여행✨${travelPlan.startDate}~ ${travelPlan.endDate}</div>

				<div id="travelPlanInfo">
					<ul class="steps">
						<c:forEach var="plan" items="${travelPlaces}" varStatus="status">
							<li class="step step-neutral" data-content="${status.index + 1}">${plan.placeName}</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(36.332326, 127.434211), // 지도의 중심좌표 (대전역)
                level: 7 // 지도의 확대 레벨
            };

        var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성
        
        // 목적지 배열 (사용자가 원하는 목적지로 수정할 수 있다)
        var travelPlaces = [
            <c:forEach var="place" items="${travelPlaces}">
            {
                placeName: "${place.placeName}"
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ];

        // 장소 검색 객체를 생성합니다.
        var ps = new kakao.maps.services.Places();
        var linePath = []; // 폴리라인을 그리기 위한 좌표 배열
        var bounds = new kakao.maps.LatLngBounds(); // 지도 범위 설정을 위한 객체

        // 전달받은 travelPlaces 배열에 있는 각 장소에 대해 키워드 검색
        travelPlaces.forEach(function (place, index) {
            ps.keywordSearch(place.placeName, function (data, status) {
                if (status === kakao.maps.services.Status.OK) {
                    // 검색된 첫 번째 장소의 좌표를 가져와서 마커를 표시하고 좌표를 linePath에 추가
                    var position = new kakao.maps.LatLng(data[0].y, data[0].x);
                    place.latitude = data[0].y; // 좌표 추가
                    place.longitude = data[0].x;
                    linePath.push(position); // 폴리라인 경로에 좌표 추가
                    bounds.extend(position); // 지도 범위 확장

                    // 마커와 인포윈도우 추가
                    createMarker(position, place.placeName);

                    // 모든 장소의 검색이 끝난 후 폴리라인 그리기
                    if (linePath.length === travelPlaces.length) {
                        drawPolyline();
                        map.setBounds(bounds); // 지도의 범위를 경로에 맞춰서 설정
                    }
                } else {
                    console.error('목적지의 좌표를 찾을 수 없습니다: ' + place.placeName);
                }
            });
        });

        // 마커와 인포윈도우를 추가하는 함수
        function createMarker(position, title) {
            var marker = new kakao.maps.Marker({
                map: map,
                position: position,
                title: title
            });

            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;">' + title + '</div>'
            });

            // 마커에 마우스 오버 이벤트를 추가하여 인포윈도우를 표시합니다.
            kakao.maps.event.addListener(marker, 'mouseover', function () {
                infowindow.open(map, marker);
            });

            // 마커에서 마우스 아웃 이벤트를 추가하여 인포윈도우를 닫습니다.
            kakao.maps.event.addListener(marker, 'mouseout', function () {
                infowindow.close();
            });
        }

        // 폴리라인을 그리는 함수
        function drawPolyline() {
            var polyline = new kakao.maps.Polyline({
                path: linePath, 
                strokeWeight: 3,
                strokeColor: '#4B5563', 
                strokeOpacity: 0.8, 
                strokeStyle: 'solid' 
            });
            polyline.setMap(map); // 폴리라인을 지도에 표시
        }
    </script>
</body>