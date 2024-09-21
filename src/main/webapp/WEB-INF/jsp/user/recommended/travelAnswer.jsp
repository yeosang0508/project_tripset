<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../common/head.jspf"%>
<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>

<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>

<!-- Tailwind CSS CDN -->
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

<body class="bg-gray-100">
	<div class="container mx-auto p-4">
		<!-- 여행 지역 제목과 스타일 -->
		<div class="text-4xl font-bold mt-8 mb-8">'${region}' ${style} ✨</div>

		<!-- 한 장의 이미지 -->
		<div class="flex justify-start items-center mb-8">
			<div class="w-2/3 h-96 overflow-hidden relative bg-white rounded-lg shadow-md">
				<img id="displayImage" class="w-full h-full object-contain" src="" alt="지역 이미지">
			</div>
			<div class="w-1/2 ml-4">
				<ul>
					<c:forEach var="location" items="${response}">
							<li class="text-xl font-semibold mb-4">
								<div>${location.info}</div>
							</li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<!-- 콘텐츠 레이아웃 -->
		<div class="flex justify-center items-start space-x-8">
			<!-- 왼쪽 리스트 -->
			<div class="w-1/4 bg-white p-4 rounded-lg shadow-md">
				<c:choose>
					<c:when test="${empty response}">
						<p>추천 결과가 없습니다.</p>
					</c:when>
					<c:otherwise>
						<ul class="space-y-4">
							<c:forEach var="location" items="${response}">
								<!-- 장소 이름 리스트 -->
								<c:if test="${location.name != ''}">
									<li class="p-4 border rounded-lg cursor-pointer hover:bg-gray-100">
										<a href="#" onclick="handleAddressClick('${location.name.replaceFirst('^\\d+\\.\\s*', '')}')">
											${location.name.replaceFirst('^\\d+\\.\\s*', '')}
										</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</c:otherwise>
				</c:choose>
			</div>

			<!-- 오른쪽 카카오 맵 -->
			<div id="map" class="w-3/5 h-96 bg-gray-200 rounded-lg shadow-md"></div>
		</div>

		<!-- 홈 버튼 -->
		<div class="mt-8 text-center">
			<button onclick="location.href='../home/main'" class="px-8 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition duration-300">홈으로</button>
		</div>
	</div>

	<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex: 1
		});

		var mapContainer = document.getElementById('map'); // 지도를 표시할 div
		var mapOption = {
			center: new kakao.maps.LatLng(36.332326, 127.434211),
			level: 8 // 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		function handleAddressClick(address, event) {
			// 기본 이벤트 막기
			if (event) event.preventDefault();

			// openAI에서 받은 주소로 키워드 검색
			ps.keywordSearch(address, placesSearchCB);
		}

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {
				console.log("검색 결과: ", data);

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
				// LatLngBounds 객체에 좌표를 추가합니다
				var bounds = new kakao.maps.LatLngBounds();

				for (var i = 0; i < data.length; i++) {
					displayMarker(data[i]);
					bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
				}

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				map.setBounds(bounds);
			} else {
				console.log("검색 결과가 없습니다.");
			}
		}

		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
			// 마커를 생성하고 지도에 표시합니다
			var marker = new kakao.maps.Marker({
				map: map,
				position: new kakao.maps.LatLng(place.y, place.x)
			});

			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function () {
				// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
				infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
				infowindow.open(map, marker);
			});
		}

		// API 키
		const API_KEY = 'APIKEY';

		// API를 통해 이미지 불러오기
		fetch('http://apis.data.go.kr/B551011/PhotoGalleryService1/gallerySearchList1?serviceKey=' + API_KEY + '&MobileOS=ETC&MobileApp=AppTest&keyword=제주도&numOfRows=10&pageNo=1')
			.then(response => response.text()) // XML 데이터를 텍스트로 가져옴
			.then(data => {
				const parser = new DOMParser();
				const xmlDoc = parser.parseFromString(data, "application/xml");

				const imageUrlElements = xmlDoc.getElementsByTagName("galWebImageUrl");

				if (imageUrlElements.length > 0) {
					const imageUrl = imageUrlElements[0].textContent;
					console.log('Image URL:', imageUrl);

					// 이미지 URL을 <img> 태그의 src 속성에 설정
					document.getElementById('displayImage').src = imageUrl;
				} else {
					console.log('No galWebImageUrl elements found.');
				}
			})
			.catch(error => console.error('Error fetching data:', error));
	</script>

	<%@ include file="../common/foot.jspf"%>