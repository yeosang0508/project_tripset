<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../common/head.jspf"%>
<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>

<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY
&libraries=services"></script>

<!-- Tailwind CSS CDN -->
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

<style>
html, body {
	background: linear-gradient(180deg, rgba(218, 235, 255, 1) 12.5%,
		rgba(220, 236, 255, 1) 25%, rgba(223, 238, 255, 1) 37.5%,
		rgba(225, 239, 255, 1) 50%, rgba(228, 240, 255, 1) 56.25%,
		rgba(232, 243, 255, 1) 62.5%, rgba(238, 245, 255, 1) 75%,
		rgba(238, 245, 255, 1) 87.5%, rgba(255, 255, 255, 1) 100%);
}
</style>

<body class="bg-gradient-to-r to-indigo-100 min-h-screen">
	<!-- 여행 지역 제목과 스타일 -->
	<header>
		<h1 class="text-3xl font-bold m-6">'${region}' ${style} ✨</h1>
	</header>
	<!-- 추천 장소와 지도 -->
	<section class="flex flex-col lg:flex-row justify-between mx-auto px-8 md:px-16 space-y-16 lg:space-y-0 lg:space-x-16">
		<!-- 추천 장소 리스트 -->
		<div class="lg:w-1/3 bg-white p-8 rounded-lg shadow-lg">
			<h2 class="text-2xl font-semibold text-indigo-700 mb-6">추천 장소</h2>
			<c:choose>
				<c:when test="${empty response}">
					<p class="text-gray-500">추천 결과가 없습니다.</p>
				</c:when>
				<c:otherwise>
					<ul class="space-y-4">
						<c:forEach var="location" items="${response}">
							<!-- 장소 이름 리스트 -->
							<c:if test="${location.name != ''}">
								<li class="p-4 border-l-4 border-indigo-500 bg-gray-50 rounded-lg cursor-pointer hover:bg-indigo-100 transition duration-300">
									<a href="#" class="text-indigo-600 font-semibold" onclick="handleAddressClick('${location.name.replaceFirst('^\\d+\\.\\s*', '')}')">
										${location.name.replaceFirst('^\\d+\\.\\s*', '')} </a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
		<!-- 오른쪽 카카오 맵 -->
		<div id="map" class="lg:flex-1 h-96 lg:h-auto bg-gray-200 rounded-lg shadow-lg"></div>
	</section>
	<!-- 한 장의 이미지와 정보 -->
	<section
		class="flex flex-col md:flex-row items-center justify-center mx-auto px-8 md:px-16 space-y-8 md:space-y-0 md:space-x-16 flex-grow min-h-screen">


		<div class="relative flex justify-center items-center mb-8">
			<!-- 좌측 버튼 -->
			<button id="prevBtn" class="absolute left-0 z-10 p-4 bg-gray-300 rounded-full hover:bg-gray-500 focus:outline-none">&#10094;</button>

			<!-- 이미지 슬라이드 -->
			<div class=" h-96 overflow-hidden relative bg-white rounded-lg shadow-md">
				<img id="displayImage" class="w-full h-full object-contain" src="" alt="지역 이미지">
			</div>

			<!-- 우측 버튼 -->
			<button id="nextBtn" class="absolute right-0 z-10 p-4 bg-gray-300 rounded-full hover:bg-gray-500 focus:outline-none">&#10095;</button>
		</div>

		<!-- 여행 정보 리스트 (상하 가운데 정렬) -->
		<div class="md:flex-1 bg-white p-8 rounded-lg shadow-lg flex items-center justify-center">
			<div>
				<h2 class="text-2xl font-semibold text-indigo-700 mb-6">여행 정보</h2>
				<ul class="space-y-6">
					<c:forEach var="location" items="${response}">
						<li class="text-lg text-gray-700">${location.info}</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</section>



	<!-- 홈 버튼 -->
	<footer class="bg-white shadow-lg text-center flex items-center justify-center">
		<button onclick="location.href='../home/main'" class="w-24 h-9 bg-blue-500 text-white font-bold rounded-lg hover:bg-blue-700 float-right">홈으로</button>
	</footer>
</body>

<script>
    // 지도 컨테이너 확인용 콘솔 로그
    var mapContainer = document.getElementById('map'); 
    console.log(mapContainer); // 컨테이너 확인

    var mapOption = {
        center: new kakao.maps.LatLng(36.332326, 127.434211), // 지도 중심 좌표
        level: 3 // 지도 확대 레벨
    };

    // 지도를 생성
    var map = new kakao.maps.Map(mapContainer, mapOption);

    // 장소 검색 객체 생성
    var ps = new kakao.maps.services.Places();
    var infowindow = new kakao.maps.InfoWindow({zIndex: 1});

    function handleAddressClick(address, event) {
        if (event) event.preventDefault();

        // 주소 클릭 시 호출 여부 확인하기
        console.log("주소 클릭됨:", address);
        
        // 키워드 검색
        ps.keywordSearch(address, function(data, status) {
            if (status === kakao.maps.services.Status.OK) {
                console.log("검색 결과:", data);

                var bounds = new kakao.maps.LatLngBounds();

                for (var i = 0; i < data.length; i++) {
                    displayMarker(data[i]);
                    bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                }

                map.setBounds(bounds); // 지도의 범위를 검색 결과에 맞게 설정
            } else {
                console.log("검색 실패:", status);
            }
        });
    }

    // 마커를 지도에 표시하는 함수
    function displayMarker(place) {
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x)
        });

        kakao.maps.event.addListener(marker, 'click', function() {
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>'
            });
            infowindow.open(map, marker);
        });
    }
    
    
</script>


<script>
		const API_KEY = 'APIKEY';

		const region = '${region}';
		
		// API를 통해 이미지 불러오기
		let images = [];
		let currentIndex = 0;
		
		fetch('http://apis.data.go.kr/B551011/PhotoGalleryService1/gallerySearchList1?serviceKey=' + API_KEY + '&MobileOS=ETC&MobileApp=AppTest&keyword='+ encodeURIComponent(region) +'&numOfRows=10&pageNo=1')
			.then(response => response.text()) // XML 데이터를 텍스트로 가져옴
			.then(data => {
				const parser = new DOMParser();
				const xmlDoc = parser.parseFromString(data, "application/xml");

				const imageUrlElements = xmlDoc.getElementsByTagName("galWebImageUrl");

		        if (imageUrlElements.length > 0) {
		            for (let i = 0; i < imageUrlElements.length; i++) {
		                images.push(imageUrlElements[i].textContent);
		            }
		            // 첫 번째 이미지를 표시
		            document.getElementById('displayImage').src = images[currentIndex];
				} else {
					console.log('No galWebImageUrl elements found.');
				}
			})
			.catch(error => console.error('Error fetching data:', error));
		
		// 슬라이드 이미지 변경 함수
		function changeSlide(direction) {
		    currentIndex += direction;
		    if (currentIndex < 0) {
		        currentIndex = images.length - 1; // 마지막 이미지로
		    } else if (currentIndex >= images.length) {
		        currentIndex = 0; // 첫 번째 이미지로
		    }
		    document.getElementById('displayImage').src = images[currentIndex];
		}

		// 좌우 버튼 클릭 시 이동
		document.getElementById('prevBtn').addEventListener('click', () => changeSlide(-1));
		document.getElementById('nextBtn').addEventListener('click', () => changeSlide(1));
	</script>

<%@ include file="../common/foot.jspf"%>