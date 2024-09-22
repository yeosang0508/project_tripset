<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../common/head.jspf"%>
<%@ include file="../popups/regionalSelectionPopup.jspf"%>

<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ApiKey&libraries=services"></script>

<!-- Include jQuery for datepicker -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Include Date Range Picker -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<!-- Custom CSS -->
<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
}

#container {
	display: flex;
	height: 100vh;
	width: 100vw;
	box-sizing: border-box;
}

#map-container {
	flex: 2;
	position: relative;
}

#map {
	width: 100%;
	height: 100%;
}

#sidebar {
	flex: 1;
	background-color: #f5f5f5;
	padding: 20px;
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.container-layout {
	display: flex;
	flex-direction: row;
	gap: 20px;
	padding: 20px;
}

.map-container-layout {
	flex: 2;
	position: relative;
}

.sidebar-layout {
	flex: 1;
	display: flex;
	flex-direction: column;
	gap: 20px;
	flex-direction: column
}

.date-picker {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 0;
	background-color: #f9f9f9;
	border-radius: 5px;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	height: 40px;
	flex-grow: 1;
}

.date-picker-container {
	display: flex;
	align-items: center;
	gap: 10px;
}

.date-picker-container svg {
	margin-right: 5px;
	cursor: pointer;
}

.date-picker input {
	width: 100%;
	height: 100%;
	padding: 0;
	border-radius: 5px;
	font-size: 14px;
	outline: none;
	background-color: inherit;
	text-align: center;
}

#daterange {
	width: 100%;
	max-width: 300px;
	height: 100%;
	font-size: 18px;
	border: none;
	border-radius: 5px;
	box-sizing: border-box;
	background-color: inherit;
	font-weight: bold;
	text-align: center;
}

.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 15px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	flex-grow: 1;
}

#menu_wrap {
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	height: 40px;
}

.bg_white {
	background: #fff;
}

#placesList {
	max-height: 400px;
	overflow-y: auto;
}

#menu_wrap hr {
	display: block;
	border: 0;
	margin: 3px 0;
}

#menu_wrap .option {
	text-align: center;
}

#menu_wrap .option p {
	margin: 10px 0;
}

#menu_wrap .option button {
	margin-left: 5px;
}

/* 검색창 스타일 */
.search-box {
	display: flex;
	align-items: center;
	height: 40px;
	width: 100%;
	max-width: 600px;
	background-color: #f9f9f9;
	border-radius: 10px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

.search-txt {
	flex-grow: 1;
	border: none;
	outline: none;
	font-size: 16px;
	padding: 10px;
	height: 40px;
	background-color: #f9f9f9;
	border-radius: 10px 0 0 10px;
}

.search-btn {
	background-color: #58aaff;
	color: white;
	border: none;
	padding: 10px 15px;
	border-radius: 0 10px 10px 0;
	cursor: pointer;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 40px;
}

.search-btn i {
	font-size: 2em;
}

.search-btn:hover {
	background-color: #007bff;
}

#placesList {
	background-color: #f9f9f9;
	z-index: 10;
}

#placesList li {
	list-style: none;
}

#placesList .item {
	position: relative;
	border-bottom: 1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}

#placesList .item span {
	display: block;
	margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#placesList .item .info {
	padding: 10px 0 10px 55px;
}

#placesList .info .gray {
	color: #8a8a8a;
}

#placesList .info .jibun {
	padding-left: 26px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
		no-repeat;
}

#placesList .info .tel {
	color: #009900;
}

#placesList .item .markerbg {
	float: left;
	position: absolute;
	width: 36px;
	height: 37px;
	margin: 10px 0 0 10px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
		no-repeat;
}

#placesList .item .marker_1 {
	background-position: 0 -10px;
}

#placesList .item .marker_2 {
	background-position: 0 -56px;
}

#placesList .item .marker_3 {
	background-position: 0 -102px
}

#placesList .item .marker_4 {
	background-position: 0 -148px;
}

#placesList .item .marker_5 {
	background-position: 0 -194px;
}

#placesList .item .marker_6 {
	background-position: 0 -240px;
}

#placesList .item .marker_7 {
	background-position: 0 -286px;
}

#placesList .item .marker_8 {
	background-position: 0 -332px;
}

#placesList .item .marker_9 {
	background-position: 0 -378px;
}

#placesList .item .marker_10 {
	background-position: 0 -423px;
}

#placesList .item .marker_11 {
	background-position: 0 -470px;
}

#placesList .item .marker_12 {
	background-position: 0 -516px;
}

#placesList .item .marker_13 {
	background-position: 0 -562px;
}

#placesList .item .marker_14 {
	background-position: 0 -608px;
}

#placesList .item .marker_15 {
	background-position: 0 -654px;
}

#pagination {
	margin: 10px auto;
	text-align: center;
}

#pagination a {
	display: inline-block;
	margin-right: 10px;
}

#pagination .on {
	font-weight: bold;
	cursor: default;
	color: #777;
}

#numbered-list {
	z-index: 1;
}

ul.numbered {
	margin-top: 30px;
	border-left: 3px solid #b3b3b3;
	counter-reset: numbered-list;
	margin-left: 10px;
	position: relative;
}

ul.numbered li {
	font-size: 16px;
	line-height: 1.2;
	margin-bottom: 30px;
	padding-left: 30px;
	position: relative;
}

ul.numbered li:last-child {
	border-left: 3px solid white;
	margin-left: -3px;
}

ul.numbered li:before {
	background-color: #b3b3b3;
	border: 3px solid white;
	border-radius: 50%;
	color: white;
	content: counter(numbered-list);
	counter-increment: numbered-list;
	display: block;
	font-weight: bold;
	width: 30px;
	height: 30px;
	margin-left: 4px;
	line-height: 30px;
	position: absolute;
	left: -21px;
	text-align: center;
}

/* 페이지 네이션 스타일 */
.pagination {
	margin-top: 20px;
	text-align: center;
}

.pagination button {
	padding: 5px 10px;
	margin: 0 5px;
	background-color: #27A4FC;
	color: white;
	border: none;
	cursor: pointer;
}

.pagination button:disabled {
	background-color: #ccc;
	cursor: not-allowed;
}
</style>

<script>
	document.addEventListener('DOMContentLoaded', function(){
		const regionSelect = document.getElementById('region-select');
		const regionConfirmBtn = document.getElementById('region-confirm-btn');
		
		regionConfirmBtn.addEventListener('click', function(){
			const selectedRegion = regionSelect.value;
			if(selectedRegion){
				localStorage.setItem('selectedRegion', selectedRegion);
				alert('선택된 지역: ' + selectedRegion);
				document.querySelector('.region-popup').classList.add('hidden');
				document.querySelector('.popup-bg').classList.add('hidden');
			} else {
				alert('지역을 선택해주세요!');
			}
			
		});
	});
</script>

</head>
<body>
	<%@ include file="../popups/loginPopup.jspf"%>
	<%@ include file="../popups/signUpPopup.jspf"%>

	<div id="container" class="container-layout">
		<!-- Map Container -->
		<div id="map-container" class="map-container-layout">
			<div id="map"></div>
		</div>

		<!-- Sidebar -->
		<div id="sidebar" class="sidebar-layout">
			<!-- Date Picker -->
			<div class="date-picker-container">
				<svg id="prevDay" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
                <path fill-rule="evenodd"
						d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0" />
            </svg>
				<div class="date-picker">
					<input type="text" name="date" id="daterange" placeholder="날짜를 선택해주세요" />
				</div>
				<svg id="nextDay" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                <path fill-rule="evenodd"
						d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708" />
            </svg>
			</div>

			<!-- Map Search and Options -->
			<div class="map_wrap">
				<div id="menu_wrap" class="bg_white">
					<div class="option">
						<form onsubmit="searchPlaces(); return false;" class="search-box">
							<input type="text" id="keyword" class="search-txt" placeholder="목적지를 입력해주세요" />
							<button type="submit" class="search-btn">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                <path
										d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
                            </svg>
							</button>
						</form>
					</div>
					<hr>
					<ul id="placesList"></ul>
				</div>
				<div>
					<ul class="numbered" id="numbered-list"></ul>
				</div>
			</div>
		</div>
	</div>

	<!-- Date Range Picker 설정 -->
	<script type="text/javascript">
		$(function() {
			let currentDate = moment();
			let startDate = currentDate;
			let endDate = currentDate;

			function updateDateDisplay() {
				$('#daterange').val(currentDate.format('YYYY/MM/DD')); // 현재 날짜만 표시
			}

			updateDateDisplay();

			$('input[name="date"]').daterangepicker(
					{
						locale : {
							format : 'YYYY/MM/DD',
							applyLabel : "확인",
							cancelLabel : "취소",
							daysOfWeek : [ "일", "월", "화", "수", "목", "금", "토" ],
							monthNames : [ "1월", "2월", "3월", "4월", "5월", "6월",
									"7월", "8월", "9월", "10월", "11월", "12월" ]
						},
						startDate : currentDate,
						endDate : currentDate
					}, function(start, end) {
						startDate = start;
						endDate = end;
						currentDate = startDate.clone(); // 선택된 범위의 첫날을 현재 날짜로 설정
						updateDateDisplay(); // 현재 날짜를 필드에 업데이트
					});

			// 이전 날짜로 이동
			$('#prevDay').on('click', function() {
				if (currentDate.isAfter(startDate)) { // 시작 날짜보다 크면 이전 날짜로 이동 가능
					currentDate = currentDate.subtract(1, 'days'); 
					updateDateDisplay(); 
				} else {
					alert("이전 날짜로 이동할 수 없습니다."); 
				}
			});

			// 다음 날짜로 이동
			$('#nextDay').on('click', function() {
				if (currentDate.isSameOrBefore(endDate)) { // 종료 날짜보다 같거나 작을 때만 이동 가능
					updateDateDisplay(); 
					currentDate = currentDate.add(1, 'days'); 
				} else {
					alert("다음 날짜로 이동할 수 없습니다."); 
				}
			});
		});
	</script>



	<!-- Kakao Map 설정 -->
	<script>
		var markers = [];
		var savedPlaces = []; // 저장된 장소 리스트

		var mapContainer = document.getElementById('map'), mapOption = {
			center : new kakao.maps.LatLng(36.332326, 127.434211), // 사용자 위치 확인 안될 경우 대전역으로 기본값 
			level : 3
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		// 키워드로 장소를 검색합니다
		function searchPlaces() {
			let keyword = document.getElementById('keyword').value;

			if (keyword.trim() === "") {
				alert("검색어를 입력하세요.");
				return;
			}

			// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			ps.keywordSearch(keyword, placesSearchCB);

			// 검색 후 입력창을 비웁니다.
			document.getElementById('keyword').value = '';
		}

		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {
				// 정상적으로 검색이 완료됐으면 검색 목록과 마커를 표출합니다
				displayPlaces(data);
				// 페이지 번호를 표출합니다
				displayPagination(pagination);
				// 검색 결과 목록을 다시 표시
				showPlacesList();
			} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
				alert('검색 결과가 존재하지 않습니다.');
				hidePlacesList(); // 검색 결과가 없을 때 검색 결과 창을 숨깁니다.
				return;
			} else if (status === kakao.maps.services.Status.ERROR) {
				alert('검색 결과 중 오류가 발생했습니다.');
				hidePlacesList();
				return;
			}
		}

		// 검색 결과 목록과 마커를 표출하는 함수입니다
		function displayPlaces(places) {
			var listEl = document.getElementById('placesList'), menuEl = document
					.getElementById('menu_wrap'), fragment = document
					.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds();

			// 검색 결과 목록에 추가된 항목들을 제거합니다
			removeAllChildNodes(listEl);

			// 지도에 표시되고 있는 마커를 제거합니다
			removeMarker();

			for (var i = 0; i < places.length; i++) {
				// 마커를 생성하고 지도에 표시합니다
				var placePosition = new kakao.maps.LatLng(places[i].y,
						places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
						i, places[i]); // 검색 결과 항목 Element를 생성합니다

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해 LatLngBounds 객체에 좌표를 추가합니다
				bounds.extend(placePosition);

				(function(marker, title, place) {
					kakao.maps.event.addListener(marker, 'mouseover',
							function() {
								displayInfowindow(marker, title);
							});

					kakao.maps.event.addListener(marker, 'mouseout',
							function() {
								infowindow.close();
							});

					// 리스트 항목에 마우스를 올리면 인포윈도우를 표시합니다
					itemEl.onmouseover = function() {
						displayInfowindow(marker, title);
					};

					itemEl.onmouseout = function() {
						infowindow.close();
					};

					// 리스트 항목을 클릭하면 선택한 장소로 이동 및 리스트에 추가
					itemEl.onclick = function() {
						addDestination(place.place_name); // numbered-list에 장소 추가
					};
				})(marker, places[i].place_name, places[i]);

				fragment.appendChild(itemEl);
			}

			// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
			listEl.appendChild(fragment);
			menuEl.scrollTop = 0;

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			map.setBounds(bounds);
		}

		// 목적지를 numbered-list에 추가하는 함수
		function addDestination(destination) {
			if (!savedPlaces.includes(destination)) {
				savedPlaces.push(destination);
				const listEl = document.getElementById('numbered-list');
				const li = document.createElement('li');
				li.textContent = destination;
				listEl.appendChild(li);
			} else {
				alert('이미 추가된 목적지입니다.');
			}
		}

		// 검색결과 목록을 숨기는 함수
		function hidePlacesList() {
			var placesListEl = document.getElementById('placesList');
			placesListEl.style.display = 'none';
		}

		// 검색결과 목록을 표시하는 함수
		function showPlacesList() {
			var placesListEl = document.getElementById('placesList');
			placesListEl.style.display = 'block';
		}

		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {
			var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
					+ (index + 1)
					+ '"></span>'
					+ '<div class="info">'
					+ '   <h5>' + places.place_name + '</h5>';

			if (places.road_address_name) {
				itemStr += '    <span>' + places.road_address_name + '</span>'
						+ '   <span class="jibun gray">' + places.address_name
						+ '</span>';
			} else {
				itemStr += '    <span>' + places.address_name + '</span>';
			}

			itemStr += '  <span class="tel">' + places.phone + '</span>'
					+ '</div>';
			el.innerHTML = itemStr;
			el.className = 'item';

			return el;
		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx) {
			var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', imageSize = new kakao.maps.Size(
					36, 37), imgOptions = {
				spriteSize : new kakao.maps.Size(36, 691),
				spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10),
				offset : new kakao.maps.Point(13, 37)
			}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imgOptions), marker = new kakao.maps.Marker({
				position : position,
				image : markerImage
			});

			marker.setMap(map); // 지도 위에 마커를 표출합니다
			markers.push(marker); // 배열에 생성된 마커를 추가합니다

			return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
			var paginationEl = document.getElementById('pagination'), fragment = document
					.createDocumentFragment(), i;

			// 기존에 추가된 페이지번호를 삭제합니다
			removePagination();

			for (i = 1; i <= pagination.last; i++) {
				var el = document.createElement('a');
				el.href = "#";
				el.innerHTML = i;

				if (i === pagination.current) {
					el.className = 'on';
				} else {
					el.onclick = (function(i) {
						return function() {
							pagination.gotoPage(i);
						};
					})(i);
				}

				fragment.appendChild(el);
			}
			paginationEl.appendChild(fragment);
		}

		// 페이지네이션을 삭제하는 함수
		function removePagination() {
			var paginationEl = document.getElementById('pagination');
			while (paginationEl.hasChildNodes()) {
				paginationEl.removeChild(paginationEl.lastChild);
			}
		}

		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
			var content = '<div style="padding:5px;z-index:1;">' + title
					+ '</div>';
			infowindow.setContent(content);
			infowindow.open(map, marker);
		}

		// 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNodes(el) {
			while (el.hasChildNodes()) {
				el.removeChild(el.lastChild);
			}
		}
	</script>



</body>