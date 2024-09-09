<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../common/head.jspf"%>



<!-- Include Kakao Maps -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=apikey"></script>

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
</style>

</head>
<body>

	<div id="container">
		<!-- Map Container -->
		<div id="map-container">
			<div id="map"></div>
		</div>

		<!-- Sidebar -->
		<div id="sidebar">
			<div class="date-picker">
				<h3>날짜를 선택해주세요</h3>
				<input type="text" class="duration" value="" />
			</div>
			<ul class="location-list">
				<li>
					<div class="location-details">
						<div class="location-name">오란</div>
						<div class="location-info">도보 16분 - 양식, 유성구 지족동</div>
					</div>
				</li>
				<li>
					<div class="location-details">
						<div class="location-name">프렌치리하우스</div>
						<div class="location-info">도보 18분 - 베이커리, 유성구 반석동</div>
					</div>
				</li>
				<li>
					<div class="location-details">
						<div class="location-name">만화카페 수상한단팥빵</div>
						<div class="location-info">도보 3분 - 북카페, 유성구 지족동</div>
					</div>
				</li>
				<li>
					<div class="location-details">
						<div class="location-name">칼질만반찬찜</div>
						<div class="location-info">도보 13분 - 중식당, 유성구 지족동</div>
					</div>
				</li>
				<li>
					<div class="location-details">
						<div class="location-name">은구비공원</div>
						<div class="location-info">도보 22분 - 근린공원, 유성구 지족동</div>
					</div>
				</li>
				<li>
					<div class="location-details">
						<div class="location-name">Leaful</div>
						<div class="location-info">도보 22분 - 카페, 유성구 죽동</div>
					</div>
				</li>
			</ul>
			<button class="save-button">저장</button>
		</div>
	</div>

	<!-- Data Range Picker 설정 -->
	<script type="text/javascript">
		$(function() {
			$('.duration')
					.daterangepicker(
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
									"daysOfWeek" : [ "일", "월", "화", "수", "목",
											"금", "토" ],
									"monthNames" : [ "1월", "2월", "3월", "4월",
											"5월", "6월", "7월", "8월", "9월",
											"10월", "11월", "12월" ]
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
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(36.332326, 127.434211), // 사용자 위치 확인 안될 경우 대전역으로 기본값 
			level : 10
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation.getCurrentPosition(function(position) {
				var lat = position.coords.latitude, // 위도
				lon = position.coords.longitude; // 경도
				var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				message = '<div style="padding:5px;">현위치</div>'; // 인포윈도우에 표시될 내용입니다
				// 마커와 인포윈도우를 표시합니다
				displayMarker(locPosition, message);
			});
		} else { // GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
			var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없어요..';
			displayMarker(locPosition, message);
		}

		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition, message) {
			var marker = new kakao.maps.Marker({
				map : map,
				position : locPosition
			});
			var infowindow = new kakao.maps.InfoWindow({
				content : message,
				removable : true
			});
			infowindow.open(map, marker);
			map.setCenter(locPosition);
		}
	</script>


</body>