document.addEventListener("DOMContentLoaded", function() {
	const travelPlanInfo = document.getElementById("travelPlanInfo");
	if (travelPlanInfo) {
		travelPlanInfo.scrollLeft = 0; // 초기 스크롤 위치를 설정

		// 자동으로 첫 번째 아이템을 볼 수 있도록 설정
		const firstItem = travelPlanInfo.querySelector(".timeline-item");
		if (firstItem) {
			firstItem.scrollIntoView({ behavior: "smooth", block: "nearest", inline: "start" });
		}
	}
	
	var mapContainer = document.getElementById('map');
	if (!mapContainer) {
		console.error("Map container element not found.");
		return;
	}

	var mapOption = {
		center: new kakao.maps.LatLng(36.332326, 127.434211),
		level: 7
	};

	var map = new kakao.maps.Map(mapContainer, mapOption);

	// travelPlaces 배열은 JSP에서 렌더링
	var travelPlaces = window.travelPlaces || [];

	var ps = new kakao.maps.services.Places();
	var linePath = [];
	var bounds = new kakao.maps.LatLngBounds();

	// 순서대로 각 여행지의 좌표를 검색하고, 마커와 경로를 생성
	(async function fetchPlaceCoordinates() {
		for (const place of travelPlaces) {
			await new Promise((resolve) => {
				ps.keywordSearch(place.placeName, function(data, status) {
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

		kakao.maps.event.addListener(marker, 'mouseover', function() {
			infowindow.open(map, marker);
		});

		kakao.maps.event.addListener(marker, 'mouseout', function() {
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
});
