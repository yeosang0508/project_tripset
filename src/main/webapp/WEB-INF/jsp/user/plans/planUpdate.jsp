<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resource/css/planUpdate.css" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../popups/CheckMySchedulePopup.jspf"%>
<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>

<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapKey}&libraries=services"></script>

<!-- Include jQuery for datepicker -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Include Date Range Picker -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<input type="hidden" id="travelPlanId" value="${placeIds}" />
<input type="hidden" id="region" value="${travelPlan.getRegion()}" />
</head>

<script>
    var travelPlaces = [
        <c:forEach var="plan" items="${travelPlaces}" varStatus="status">
            "${plan.placeName}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
</script>

<script src="/resource/js/planUpdate.js"></script>

<body>

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
					<input type="text" name="date" id="daterange" />
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
					<ul id="placesList">
					</ul>
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



	<!-- Kakao Map 설정 -->
<script>
    // Kakao Map 설정

    var markers = [];
    var savedPlaces = []; // 저장된 장소 리스트
    var ps; // Kakao Places 객체

    document.addEventListener("DOMContentLoaded", function () {
        var mapContainer = document.getElementById('map');
        if (!mapContainer) {
            console.error("Map container with id 'map' not found.");
            return;
        }

        var mapOption = {
            center: new kakao.maps.LatLng(36.332326, 127.434211), // 기본 위치
            level: 2
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        ps = new kakao.maps.services.Places();

        var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

        function searchPlaces() {
            const savedRegion = localStorage.getItem('region');
            const keywordInput = document.getElementById('keyword');

            if (!keywordInput) {
                console.error("Keyword input with id 'keyword' not found.");
                return;
            }

            let keyword = keywordInput.value.trim();

            if (savedRegion && keyword) {
                keyword = savedRegion + ' ' + keyword;
            }

            if (!keyword) {
                alert("검색어를 입력하세요.");
                return;
            }

            ps.keywordSearch(keyword, placesSearchCB);
            keywordInput.value = '';
        }

        function placesSearchCB(data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {
                displayPlaces(data);
                displayPagination(pagination);
                showPlacesList();
            } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                alert('검색 결과가 존재하지 않습니다.');
                hidePlacesList();
            } else if (status === kakao.maps.services.Status.ERROR) {
                alert('검색 결과 중 오류가 발생했습니다.');
                hidePlacesList();
            }
        }

        function displayPlaces(places) {
            const listEl = document.getElementById('placesList');
            const fragment = document.createDocumentFragment();
            const bounds = new kakao.maps.LatLngBounds();

            if (!listEl) {
                console.error("Element with id 'placesList' not found.");
                return;
            }

            removeAllChildNodes(listEl);
            removeMarker();

            for (let i = 0; i < places.length; i++) {
                const placePosition = new kakao.maps.LatLng(places[i].y, places[i].x);
                const marker = addMarker(placePosition, i + 1); // i + 1로 정확한 마커 번호 사용
                const itemEl = getListItem(i + 1, places[i]); // 리스트 번호 동기화

                bounds.extend(placePosition);

                (function (marker, title) {
                    kakao.maps.event.addListener(marker, 'mouseover', function () {
                        displayInfowindow(marker, title);
                    });

                    kakao.maps.event.addListener(marker, 'mouseout', function () {
                        infowindow.close();
                    });

                    itemEl.onmouseover = function () {
                        displayInfowindow(marker, title);
                    };

                    itemEl.onmouseout = function () {
                        infowindow.close();
                    };

                    itemEl.onclick = function () {
                        addDestination(title);
                        hidePlacesList();
                    };
                })(marker, places[i].place_name);

                fragment.appendChild(itemEl);
            }

            listEl.appendChild(fragment);
            map.setBounds(bounds);
        }

        function addMarker(position, number) {
            const markerImageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
            const markerImageSize = new kakao.maps.Size(36, 37);
            const markerImageOptions = {
                spriteSize: new kakao.maps.Size(36, 691),
                spriteOrigin: new kakao.maps.Point(0, (number - 1) * 46), // 정확한 번호로 sprite 위치 설정
                offset: new kakao.maps.Point(13, 37)
            };

            const markerImage = new kakao.maps.MarkerImage(
                markerImageSrc, markerImageSize, markerImageOptions
            );

            const marker = new kakao.maps.Marker({
                position: position,
                image: markerImage
            });

            marker.setMap(map);
            markers.push(marker);

            return marker;
        }

        function removeMarker() {
            markers.forEach(marker => marker.setMap(null));
            markers = [];
        }

        function removeAllChildNodes(el) {
            while (el?.hasChildNodes()) {
                el.removeChild(el.lastChild);
            }
        }

        function hidePlacesList() {
            const placesListEl = document.getElementById('placesList');
            if (placesListEl) {
                placesListEl.style.display = 'none';
            }
        }

        function showPlacesList() {
            const placesListEl = document.getElementById('placesList');
            if (placesListEl) {
                placesListEl.style.display = 'block';
            }
        }

        function getListItem(number, places) {
            const el = document.createElement('li');
            el.innerHTML = `
                <span class="markerbg marker_${number}"></span>
                <div class="info">
                    <h5>${number}. ${places.place_name}</h5>
                    ${places.road_address_name ? `<span>${places.road_address_name}</span>` : ''}
                    <span class="tel">${places.phone || ''}</span>
                </div>`;
            el.className = 'item';

            return el;
        }

        function displayPagination(pagination) {
            const paginationEl = document.getElementById('pagination');
            if (!paginationEl) {
                console.error("Pagination element not found.");
                return;
            }

            removeAllChildNodes(paginationEl);

            for (let i = 1; i <= pagination.last; i++) {
                const el = document.createElement('a');
                el.href = "#";
                el.innerHTML = i;

                if (i === pagination.current) {
                    el.className = 'on';
                } else {
                    el.onclick = (function (i) {
                        return function () {
                            pagination.gotoPage(i);
                        };
                    })(i);
                }

                paginationEl.appendChild(el);
            }
        }

        function displayInfowindow(marker, title) {
            infowindow.setContent(`<div style="padding:5px;z-index:1;">${title}</div>`);
            infowindow.open(map, marker);
        }

        function addDestination(placeName) {
            if (savedPlaces.includes(placeName)) {
                alert('이미 저장된 장소입니다.');
                return;
            }
            savedPlaces.push(placeName);
            console.log('Saved places:', savedPlaces);
        }

        const searchBtn = document.querySelector('.search-btn');
        if (searchBtn) {
            searchBtn.addEventListener('click', function (e) {
                e.preventDefault();
                searchPlaces();
            });
        } else {
            console.error("Search button with class 'search-btn' not found.");
        }

        const searchForm = document.querySelector('.search-box');
        if (searchForm) {
            searchForm.onsubmit = function (e) {
                e.preventDefault();
                searchPlaces();
            };
        } else {
            console.error("Search form with class 'search-box' not found.");
        }
    });
</script>

	<script>
	document.getElementById('saveButton').addEventListener(
			'click',
			function() {
				// localStorage에 저장된 값 가져오기
				const savedPlaces = JSON.parse(localStorage
						.getItem('savedPlaces'))
						|| [];
				
				const travelPlanId = document.getElementById('travelPlanId').value;
				const startDate = localStorage.getItem('startDate');
				const endDate = localStorage.getItem('endDate');
				const selectedRegion = localStorage
						.getItem('selectedRegion');

				console.log(localStorage.getItem('selectedRegion'));
				
				
				// 저장할 데이터를 하나의 객체로 구성
				const dataToSend = {
					id: travelPlanId,
					places : savedPlaces,
					startDate : startDate,
					endDate : endDate,
					region : selectedRegion
				};

				console.log(dataToSend);
				
				// 저장할 목적지 배열이 비어있는지 확인
				if (savedPlaces.length > 0 && startDate && endDate
						&& selectedRegion) {
					$.ajax({
						type : 'POST',
						url : '/usr/plans/doUpdateTravelPlan',
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