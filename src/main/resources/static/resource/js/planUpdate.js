// Date Range Picker 설정

$(function() {
	// JSP에서 전달받은 startDate와 endDate 값을 JavaScript 변수에 할당합니다.
	// JSON 데이터를 서버에서 받아오는 방식으로 변경 필요
	let startDate = "2023/01/01"; // 기본값으로 설정 (서버 데이터를 JSON으로 받아 대체)
	let endDate = "2023/01/07";   // 기본값으로 설정 (서버 데이터를 JSON으로 받아 대체)

	console.log(startDate); // 시작 날짜 확인
	console.log(endDate);   // 종료 날짜 확인

	// 현재 설정된 날짜 범위를 입력 필드에 표시하는 함수
	function updateDateDisplay() {
		$('#daterange').val(startDate + ' - ' + endDate); // 기본적으로 설정된 날짜 범위를 표시
	}

	// 초기 화면에서 날짜 범위를 업데이트합니다.
	updateDateDisplay();

	// Date Range Picker 초기화
	$('input[name="date"]').daterangepicker(
		{
			locale: {
				format: 'YYYY/MM/DD', // 날짜 형식 지정
				applyLabel: "확인",   // 적용 버튼 라벨
				cancelLabel: "취소",  // 취소 버튼 라벨
				daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"], // 요일 이름
				monthNames: ["1월", "2월", "3월", "4월", "5월", "6월",
					"7월", "8월", "9월", "10월", "11월", "12월"] // 월 이름
			},
			startDate: startDate, // 시작 날짜 설정
			endDate: endDate      // 종료 날짜 설정
		},
		function(start, end) {
			// 사용자가 선택한 날짜 범위를 startDate와 endDate에 업데이트합니다.
			startDate = start.format('YYYY/MM/DD');
			endDate = end.format('YYYY/MM/DD');
			updateDateDisplay();

			// localStorage에 날짜 데이터를 저장합니다.
			localStorage.setItem('startDate', startDate);
			localStorage.setItem('endDate', endDate);

			console.log('Start Date:', startDate); // 업데이트된 시작 날짜 확인
			console.log('End Date:', endDate);   // 업데이트된 종료 날짜 확인
		}
	);

	// 이전 날짜로 이동 버튼 클릭 시 동작
	$('#prevDay').on('click', function() {
		if (moment(startDate).isAfter(startDate)) { // 시작 날짜보다 크면 이전 날짜로 이동 가능
			startDate = moment(startDate).subtract(1, 'days').format('YYYY/MM/DD');
			updateDateDisplay(); // 날짜를 업데이트합니다.
		} else {
			alert("이전 날짜로 이동할 수 없습니다."); // 이동 불가 메시지
		}
	});

	// 다음 날짜로 이동 버튼 클릭 시 동작
	$('#nextDay').on('click', function() {
		if (moment(endDate).isSameOrBefore(endDate)) { // 종료 날짜보다 같거나 작을 때만 이동 가능
			startDate = moment(startDate).add(1, 'days').format('YYYY/MM/DD');
			updateDateDisplay(); // 날짜를 업데이트합니다.
		} else {
			alert("다음 날짜로 이동할 수 없습니다."); // 이동 불가 메시지
		}
	});
});



var savedPlaces = []; // 목적지 이름 배열
var savedPlacesCoordinates = []; // 좌표 배열
var markers = []; // 생성된 마커 배열


// 페이지 로드 후 travelPlaces 데이터를 numbered-list에 추가
document.addEventListener("DOMContentLoaded", function() {
	const listEl = document.getElementById('numbered-list');
	if (!listEl) {
		console.error("Element with id 'numbered-list' not found.");
		return;
	}

	travelPlaces.forEach(function(destination) {
		console.log("Adding destination:", destination); // 확인용
		addDestination(destination);
	});
});

// 목적지를 numbered-list와 지도에 추가하는 함수
function addDestination(destination) {
	if (!savedPlaces.includes(destination)) {
		savedPlaces.push(destination);

		const listEl = document.getElementById('numbered-list');
		if (!listEl) {
			console.error("Element with id 'numbered-list' not found.");
			return;
		}

		// 리스트 항목 생성
		const li = document.createElement('li');
		li.style.display = 'flex';
		li.style.alignItems = 'center';
		li.style.justifyContent = 'space-between';
		li.style.padding = '5px 0';

		// 텍스트와 삭제 아이콘을 개별적으로 추가
		const text = document.createElement('span');
		text.textContent = destination;

		const removeIcon = document.createElement('i');
		removeIcon.classList.add('bi', 'bi-dash-square-dotted');
		removeIcon.style.cursor = 'pointer';
		removeIcon.style.marginLeft = '10px';

		// 삭제 아이콘 클릭 시 목적지 제거
		removeIcon.addEventListener('click', function(event) {
			event.stopPropagation(); // 부모 클릭 이벤트 전파 방지
			removeDestination(destination, li);
		});

		li.appendChild(text);
		li.appendChild(removeIcon);
		listEl.appendChild(li);

		searchAndAddMarker(destination);
	} else {
		console.warn("Destination already added:", destination);
	}
}

// 장소 검색 후 좌표를 가져와 마커 추가하는 함수
function searchAndAddMarker(destination) {
	ps.keywordSearch(destination, function(data, status) {
		if (status === kakao.maps.services.Status.OK) {
			const placePosition = new kakao.maps.LatLng(data[0].y, data[0].x);
			savedPlacesCoordinates.push(placePosition);
			updateMarkers();
		} else {
			console.error('Unable to find coordinates for:', destination);
		}
	});
}

// 목적지를 제거하는 함수
function removeDestination(destination, listItem) {
	const index = savedPlaces.indexOf(destination);
	if (index > -1) {
		savedPlaces.splice(index, 1);
		savedPlacesCoordinates.splice(index, 1);
		listItem.remove();
		updateMarkers();
	}
	console.log('Updated places:', savedPlaces);
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수
function addMarker(position, idx) {
	var marker = new kakao.maps.Marker({
		position: position,
		map: map,
		title: savedPlaces[idx],
		zIndex: idx + 1
	});
	markers.push(marker);
}

// 모든 마커를 제거하고 현재 저장된 위치로 다시 마커를 추가
function updateMarkers() {
	removeMarker();

	savedPlacesCoordinates.forEach((position, index) => {
		addMarker(position, index);
	});

	if (savedPlacesCoordinates.length > 0) {
		map.setCenter(savedPlacesCoordinates[savedPlacesCoordinates.length - 1]);
	}
}

// 지도 위의 모든 마커를 제거하는 함수
function removeMarker() {
	markers.forEach(marker => marker.setMap(null));
	markers = [];
}


// Kakao Map 설정

var markers = [];
var savedPlaces = []; // 저장된 장소 리스트

var mapContainer = document.getElementById('map'), mapOption = {
	center: new kakao.maps.LatLng(36.332326, 127.434211), // 사용자 위치 확인 안될 경우 대전역으로 기본값 
	level: 2
};

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
	zIndex: 1
});

// 장소 선택 시 저장된 지역을 기반으로 키워드 검색
function searchPlaces() {
	const savedRegion = localStorage.getItem('region');
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
			spriteSize: new kakao.maps.Size(36, 691),
			spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
			offset: new kakao.maps.Point(13, 37)
		}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
			imgOptions), marker = new kakao.maps.Marker({
				position: position,
				image: markerImage
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