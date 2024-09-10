<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../common/head.jspf"%>

<!-- Include Kakao Maps -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=Apikey&libraries=services"></script>

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

.date-picker {
	margin-bottom: 20px;
}

.location-list {
	list-style: none;
	padding: 0;
	margin: 0;
	width: 100%;
	overflow-y: auto;
	max-height: calc(100vh - 150px);
}

.location-list li {
	padding: 15px 10px;
	margin: 5px 0;
	background-color: #fff;
	border: 1px solid #ddd;
	cursor: pointer;
	display: flex;
	align-items: flex-start;
	position: relative;
}

/* 좌측 아이콘과 점선 스타일 */
.location-list li::before {
	content: '●';
	position: absolute;
	left: 10px;
	top: 20px;
	font-size: 12px;
	color: #333;
}

.location-list li::after {
	content: '';
	position: absolute;
	left: 16px;
	top: 35px;
	bottom: 0;
	width: 2px;
	background-color: #333;
}

/* 상세 정보 텍스트와 아이콘 간격 설정 */
.location-details {
	margin-left: 40px;
}

.location-name {
	font-weight: bold;
	margin-bottom: 5px;
}

.location-info {
	font-size: 12px;
	color: #888;
}

.save-button {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 20px;
	cursor: pointer;
	margin-top: auto;
	align-self: flex-end;
}

.save-button:hover {
	background-color: #0056b3;
}

.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 500px;
}

#menu_wrap {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	width: 250px;
	margin: 10px 0 30px 10px;
	padding: 5px;
	overflow-y: auto;
	background: rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size: 12px;
	border-radius: 10px;
}

.bg_white {
	background: #fff;
}

#menu_wrap hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 2px solid #5F5F5F;
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
</style>

</head>
<body>

	<div id="container">
		<!-- Map Container -->
		<div id="map-container">
			<div id="map"></div>
		</div>

		<!-- Sidebar -->
		<ul id="sidebar">
			<li class="date-picker">
				<h3>날짜를 선택해주세요</h3>
				<input type="text" class="duration" value="" />
			</li>

			<li>

				<div id="menu-wrap" class="bg-white">
					<div class="option">
						<div>
							<form onsubmit="searchPlaces(); return false;">
								<input type="text" id="keyword" placeholder="목적지를 입력해주세요" />
								<button type="submit">검색하기</button>
							</form>
						</div>
					</div>
					<hr>
					<ul id="placesList"></ul>
					<div id="pagination"></div>
				</div>
			</li>
		</ul>


		<!-- Data Range Picker 설정 -->
		<script type="text/javascript">
			$(function() {
				$('.duration').daterangepicker(
						{
							"locale" : {
								"format" : "YYYY/MM/DD",
								"separator" : " ~ ",
								"applyLabel" : "확인",
								"cancelLabel" : "취소",
								"fromLabel" : "From",
								"toLabel" : "To",
								"customRangeLabel" : "Custom",
								"weekLabel" : "W",
								"daysOfWeek" : [ "일", "월", "화", "수", "목", "금",
										"토" ],
								"monthNames" : [ "1월", "2월", "3월", "4월", "5월",
										"6월", "7월", "8월", "9월", "10월", "11월",
										"12월" ]
							},
							"startDate" : "2024/09/09",
							"endDate" : "2024/10/10",
							"opens" : "center"
						},
						function(start, end, label) {
							console.log('New date range selected: '
									+ start.format('YYYY-MM-DD') + ' to '
									+ end.format('YYYY-MM-DD')
									+ ' (predefined range: ' + label + ')');
						});
			});
		</script>

		<!-- Kakao Map 설정 -->
		<script>
			var markers = [];

			var mapContainer = document.getElementById('map'), mapOption = {
				center : new kakao.maps.LatLng(36.332326, 127.434211), // 사용자 위치 확인 안될 경우 대전역으로 기본값 
				level : 3
			};

			var map = new kakao.maps.Map(mapContainer, mapOption);

			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();

			var infoWindow = new kakao.maps.InfoWindow({
				zIndex : 1
			});

			// 키워드로 장소를 검색한다.
			searchPlaces();

			//키워드 검색을 요청하는 함수이다.
			function searchPlaces() {
				var keyword = document.getElementById('keyword').value;

				if (!keyword.replace(/^\s+|\s+$/g, '')) {
					alert('목적지를 입력해주세요!')
					return false;
				}

				// 키워드로 장소 검색
				ps.keywordSearch(keyword, placesSearchCB);
			}

			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB(data, status, pagination) {
				if (status === kakao.maps.services.Status.OK) {

					//정상적으로 검색이 완료됐으면 
					// 검색 목록과 마커를 표출

					displayPlaces(data);

					displayPagination(pagination);

				} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
					removeAllChildNods(list);
					alert('검색 결과가 존재하지 않습니다.');
					return;

				} else if (status === kakao.maps.services.Status.ERROR) {

					alert('검색 결과 중 오류가 발생했습니다.');
					return;
				}
			}

			// 검색 결과 목록과 마커를 표출하는 함수입니다
			function displayPlaces(places) {

				var listEl = document.getElementById('placesList'), menuEl = document
						.getElementById('menu_wrap'), fragment = document
						.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

				// 검색 결과 목록에 추가된 항목들을 제거합니다
				removeAllChildNods(listEl);

				// 지도에 표시되고 있는 마커를 제거합니다
				removeMarker();

				for (var i = 0; i < places.length; i++) {

					// 마커를 생성하고 지도에 표시합니다
					var placePosition = new kakao.maps.LatLng(places[i].y,
							places[i].x), marker = addMarker(placePosition, i), itemEl = getListItem(
							i, places[i]); // 검색 결과 항목 Element를 생성합니다

					// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
					// LatLngBounds 객체에 좌표를 추가합니다
					bounds.extend(placePosition);

					// 마커와 검색결과 항목에 mouseover 했을때
					// 해당 장소에 인포윈도우에 장소명을 표시한다.
					// mouseout 했을 때는 인포윈도우를 닫는다.
					(function(marker, title) {
						kakao.maps.event.addListener(marker, 'mouseover',
								function() {
									displayInfowindow(marker, title);
								});

						kakao.maps.event.addListener(marker, 'mouseout',
								function() {
									infowindow.close();
								});

						itemEl.onmouseover = function() {
							displayInfowindow(marker, title);
						};

						itemEl.onmouseout = function() {
							infowindow.close();
						};
					})(marker, places[i].place_name);

					fragment.appendChild(itemEl);
				}

				// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
				listEl.appendChild(fragment);
				menuEl.scrollTop = 0;

				// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
				map.setBounds(bounds);
			}

			// 검색결과 항목을 Element로 반환하는 함수입니다
			function getListItem(index, places) {

				var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
						+ (index + 1)
						+ '"></span>'
						+ '<div class="info">'
						+ '   <h5>' + places.place_name + '</h5>';

				if (places.road_address_name) {
					itemStr += '    <span>' + places.road_address_name
							+ '</span>' + '   <span class="jibun gray">'
							+ places.address_name + '</span>';
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
			function addMarker(position, idx, title) {
				var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
				imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
				imgOptions = {
					spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
					spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
					offset : new kakao.maps.Point(13, 37)
				// 마커 좌표에 일치시킬 이미지 내에서의 좌표
				}, markerImage = new kakao.maps.MarkerImage(imageSrc,
						imageSize, imgOptions), marker = new kakao.maps.Marker(
						{
							position : position, // 마커의 위치
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
				while (paginationEl.hasChildNodes()) {
					paginationEl.removeChild(paginationEl.lastChild);
				}

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
							}
						})(i);
					}

					fragment.appendChild(el);
				}
				paginationEl.appendChild(fragment);
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
			function removeAllChildNods(el) {
				while (el.hasChildNodes()) {
					el.removeChild(el.lastChild);
				}
			}
		</script>
</body>