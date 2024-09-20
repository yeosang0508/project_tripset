<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%@ include file="../common/head.jspf"%>

<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>

<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=apiKey&libraries=services"></script>

</head>
<body>

	<img id="displayImage" alt="API로 가져온 이미지" style="width: 300px; height: auto;">

	<script>

const API_KEY = 'key';	

	fetch('http://apis.data.go.kr/B551011/PhotoGalleryService1/galleryDetailList1?serviceKey='+ API_KEY+ '&MobileOS=ETC&MobileApp=AppTest&title=%EC%9D%B4%ED%83%9C%EC%9B%90%EA%B1%B0%EB%A6%AC&numOfRows=1&pageNo=1')
 	 	.then(response => response.text()) // XML 데이터를 텍스트로 가져옴
  		.then(data => {
    // XML을 파싱합니다.
   		 const parser = new DOMParser();
   		 const xmlDoc = parser.parseFromString(data, "application/xml");

   	// 'galWebImageUrl' 태그를 가져온다.
         const imageUrlElements = xmlDoc.getElementsByTagName("galWebImageUrl");

         if (imageUrlElements.length > 0) {
             // 'galWebImageUrl' 태그의 첫 번째 요소를 사용한다.
             const imageUrl = imageUrlElements[0].textContent;
             console.log('Image URL:', imageUrl);
             
             
             document.getElementById('displayImage').src = imageUrl;
         } else {
        	 console.log('No galWebImageUrl elements found.');
         }
     })
     .catch(error => console.error('Error fetching data:', error));

   </script>

		<div class="absolute left-1/4" style="top: 130px">
			 <c:choose>
			<c:when test="${empty response}">
				<p>추천 결과가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<ul class="steps steps-vertical">
					<c:forEach var="location" items="${response}">
						<li class="step">

							<a href="#" onclick="handleAddressClick('${location.name.replaceFirst('^\\d+\\.\\s*', '')}')"> ${location.name.replaceFirst('^\\d+\\.\\s*', '')}
							</a>

							<br>

						</li>
					</c:forEach>
				</ul>
			</c:otherwise>
		</c:choose>
		</div>

		<div id="map" style="width: 700px; height: 400px; top: 130px" class="absolute left-2/4"></div>

		<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(36.332326, 127.434211), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		function handleAddressClick(address, event) {
			// 기본 이벤트 막기
			if (event)
				event.preventDefault();

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
				map : map,
				position : new kakao.maps.LatLng(place.y, place.x)
			});

			// 마커에 클릭이벤트를 등록합니다
			kakao.maps.event.addListener(marker, 'click', function() {
				// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
				infowindow
						.setContent('<div style="padding:5px;font-size:12px;">'
								+ place.place_name + '</div>');
				infowindow.open(map, marker);
			});
		}
	</script>

	<%@ include file="../common/foot.jspf"%>