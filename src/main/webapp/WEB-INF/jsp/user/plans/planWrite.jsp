'<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../common/head.jspf"%>
<%@ include file="../popups/regionalSelectionPopup.jspf"%>
<%@ include file="../popups/CheckMySchedulePopup.jspf"%>

<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services"></script>

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
    background-color: #f0f0f0;
}

#container {
    display: flex;
    height: 75vh;
    width: 90vw;
    max-width: 1200px;
    margin: auto;
    border-radius: 15px;
    box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
    overflow: hidden;
    background-color: #ffffff;
}

/* Map Container */
#map-container {
    flex: 2;
    position: relative;
    align-items: center;
    padding: 20px;
    box-sizing: border-box;
    border-right: 1px solid #d0d0d0;
}

#map {
    width: 100%;
    height: 100%;
    border-radius: 10px;
}

/* Sidebar */
#sidebar {
    flex: 1;
    background-color: #f9f9f9;
    padding: 30px 20px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: center;
    border-radius: 0 15px 15px 0;
}

.container-layout {
    display: flex;
    flex-direction: row;
    gap: 20px;
    padding: 20px;
}

/* Date Picker */
.date-picker-container {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;
}

.date-picker {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0;
    border-radius: 5px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    height: 40px;
    flex-grow: 1;
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
    border: 1px solid #d0d0d0;
}

/* Search Box */
.search-box {
    display: flex;
    align-items: center;
    height: 40px;
    width: 100%;
    max-width: 400px;
    background-color: #f0f7ff;
    border-radius: 10px;
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}

.search-txt {
    flex-grow: 1;
    border: none;
    outline: none;
    font-size: 16px;
    padding: 10px;
    height: 40px;
    border-radius: 10px 0 0 10px;
    border: 1px solid #d0d0d0;
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
    border: 1px solid #58aaff;
}

.search-btn:hover {
    background-color: #007bff;
}

#placesList {
    max-height: 400px;
    overflow-y: auto;
    position: relative;
    width: 100%;
    background-color: #fff;
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
    z-index: 2;
    margin-top: 10px;
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
	height: 30px;
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

#numbered-list {
    z-index: 1;
    margin-right: 10px;
}

ul.numbered {
    margin-top: 30px;
    counter-reset: numbered-list;
    margin-left: 10px;
    position: relative;
    max-height: 350px;
    overflow-y: auto;
    padding-left: 20px;
}

/* Custom scrollbar styling for WebKit browsers */
ul.numbered::-webkit-scrollbar {
    width: 10px;
}

ul.numbered::-webkit-scrollbar-thumb {
    background: #666;
    border-radius: 20px;
}

ul.numbered::-webkit-scrollbar-track {
    background: #ddd;
    border-radius: 20px;
}

ul.numbered li {
    font-size: 16px;
    line-height: 1.5;
    margin-bottom: 15px;
    position: relative;
    display: flex;
    justify-content: space-between; 
    align-items: center;
}

ul.numbered li:before {
    content: counter(numbered-list);
    counter-increment: numbered-list;
    background-color: #4CAF50;
    color: white;
    border-radius: 50%;
    font-weight: bold;
    width: 24px;
    height: 24px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 14px;
    margin-right: 10px; 
}

ul.numbered li i {
    margin-left: auto; 
    cursor: pointer;
    color: #666; 
}


/* Pagination */
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
    border-radius: 5px;
}

.pagination button:disabled {
    background-color: #ccc;
    cursor: not-allowed;
}
</style>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		const regionSelect = document.getElementById('region-select');
		const regionConfirmBtn = document.getElementById('region-confirm-btn');

		regionConfirmBtn.addEventListener('click',
				function() {
					const selectedRegion = regionSelect.value;
					if (selectedRegion) {
						localStorage.setItem('selectedRegion', selectedRegion);
						document.querySelector('.region-popup').classList
								.add('hidden');
						document.querySelector('.popup-bg').classList
								.add('hidden');
					} else {
						alert('지역을 선택해주세요!');
					}

					console.log(selectedRegion);
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
					<ul id="placesList"></ul>
				</div>
				<div>
					<ul class="numbered" id="numbered-list"></ul>
				</div>
			</div>
		</div>
	</div>

	<div class="flex justify-center mt-6">
		<button id="saveButton" class="w-32 h-10 bg-blue-500 text-white hover:bg-blue-700 font-bold rounded-lg">저장</button>
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
					},
					function(start, end) {
						startDate = start;
						endDate = end;
						currentDate = startDate.clone(); // 선택된 범위의 첫날을 현재 날짜로 설정
						updateDateDisplay(); // 현재 날짜를 필드에 업데이트

						// localStorage에 startDate와 endDate를 저장
						localStorage.setItem('startDate', startDate
								.format('YYYY/MM/DD'));
						localStorage.setItem('endDate', endDate
								.format('YYYY/MM/DD'));
						console.log('Start Date:', startDate
								.format('YYYY/MM/DD'));
						console.log('End Date:', endDate.format('YYYY/MM/DD'));
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

<script>

// numbered-list에 추가된 장소의 좌표를 저장할 배열
var savedPlacesCoordinates = [];

//목적지를 numbered-list에 추가하는 함수
function addDestination(destination) {
    if (!savedPlaces.includes(destination)) {
        savedPlaces.push(destination);
        const listEl = document.getElementById('numbered-list');
        const li = document.createElement('li');

        // li 요소에 flexbox 적용하여 아이콘과 텍스트를 수직 가운데 정렬 
        li.style.display = 'flex';
        li.style.alignItems = 'center';
        li.style.justifyContent = 'space-between';
        
        // 리스트 항목에 목적지와 아이콘을 추가
        li.innerHTML = destination + `<i class="bi bi-dash-square-dotted" style="cursor: pointer; margin-left: 10px;"></i>`;
        listEl.appendChild(li);

        // 목적지를 localStorage에 저장
        localStorage.setItem('savedPlaces', JSON.stringify(savedPlaces));

        // 검색어로 장소 검색 후 해당 위치의 좌표를 가져옴
        ps.keywordSearch(destination, function(data, status) {
            if (status === kakao.maps.services.Status.OK) {
                // 검색된 첫 번째 장소의 좌표를 가져와 마커를 표시
                const placePosition = new kakao.maps.LatLng(data[0].y, data[0].x);
                addMarker(placePosition, savedPlaces.length - 1);
                map.setCenter(placePosition); // 지도의 중심을 해당 위치로 이동
                savedPlacesCoordinates.push(placePosition);

                removeMarker(); // 기존 마커 제거

                //저장된 좌표들만 마커로 표시
                savedPlacesCoordinates.forEach((position, index) => {
                    addMarker(position, index);
                });

                // 지도의 중심을 마지막 추가된 위치로 이동
                map.setCenter(placePosition);
            } else {
                console.error('목적지의 좌표를 찾을 수 없습니다.');
            }
        });

        // 삭제 버튼 클릭 시 동작
        li.querySelector('i').addEventListener('click', function() {
            removeDestination(destination, li);
        });
    } else {
        alert('이미 추가된 목적지입니다.');
    }
}

// 목적지를 제거하는 함수
function removeDestination(destination, listItem) {
    // savedPlaces 배열에서 목적지 제거
    const index = savedPlaces.indexOf(destination);
    if (index > -1) {
        savedPlaces.splice(index, 1);
    }

    // savedPlacesCoordinates 배열에서도 좌표 제거
    savedPlacesCoordinates.splice(index, 1);

    // 리스트에서 해당 항목 제거
    listItem.remove();

    // localStorage 업데이트
    localStorage.setItem('savedPlaces', JSON.stringify(savedPlaces));

    // 마커 갱신 (기존 마커를 제거하고 남은 마커만 다시 추가)
    removeMarker();
    savedPlacesCoordinates.forEach((position, index) => {
        addMarker(position, index);
    });

    console.log('Updated places:', savedPlaces);
}
</script>

	<!-- Kakao Map 설정 -->
	<script>
		var markers = [];
		var savedPlaces = []; // 저장된 장소 리스트

		var mapContainer = document.getElementById('map'), mapOption = {
			center : new kakao.maps.LatLng(36.332326, 127.434211), // 사용자 위치 확인 안될 경우 대전역으로 기본값 
			level : 2
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places();

		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex : 1
		});

		// 장소 선택 시 저장된 지역을 기반으로 키워드 검색
		function searchPlaces() {
			const savedRegion = localStorage.getItem('selectedRegion');
			let keyword = document.getElementById('keyword').value;

			if (savedRegion && keyword) {
				keyword = savedRegion + ' ' + keyword;
			}

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

		function hidePlacesList() {
			var placesListEl = document.getElementById('placesList');
			placesListEl.style.display = 'none';
		}

		function showPlacesList() {
			var placesListEl = document.getElementById('placesList');
			placesListEl.style.display = 'block';
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
						hidePlacesList(); //클릭하면 placesList 숨기기
					};
				})(marker, places[i].place_name, places[i]);

				fragment.appendChild(itemEl);
			}

			// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
			listEl.appendChild(fragment);
			menuEl.scrollTop = 0;

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			map.setBounds(bounds);

			showPlacesList(); // 검색 결과 목록 표시
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

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
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
	<script>
		document.getElementById('saveButton').addEventListener(
				'click',
				function() {
					// localStorage에 저장된 값 가져오기
					const savedPlaces = JSON.parse(localStorage
							.getItem('savedPlaces'))
							|| [];
					const startDate = localStorage.getItem('startDate');
					const endDate = localStorage.getItem('endDate');
					const selectedRegion = localStorage
							.getItem('selectedRegion');

					// 저장할 데이터를 하나의 객체로 구성
					const dataToSend = {
						places : savedPlaces,
						startDate : startDate,
						endDate : endDate,
						region : selectedRegion
					};

					// 저장할 목적지 배열이 비어있는지 확인
					if (savedPlaces.length > 0 && startDate && endDate
							&& selectedRegion) {
						$.ajax({
							type : 'POST',
							url : '/usr/plans/doWriteTravelPlan',
							contentType : 'application/json',
							data : JSON.stringify(dataToSend),
							success : function(response) {
								alert('일정이 저장되었습니다.');
								window.location.href = '/usr/home/main';
							},
							error : function(xhr, status, error) {
								console.error('저장 중 오류 발생:', error);
								alert('저장 중 오류가 발생했습니다.');
							}
						});
					} else {
						alert('저장할 목적지, 날짜 또는 지역 정보가 부족합니다.');
					}
				});
	</script>
</body>