<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../common/head.jspf"%>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=apikey"></script>



<!-- Data Range Picker설정 -->
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
						"daysOfWeek" : [ "일", "월", "화", "수", "목", "금", "토" ],
						"monthNames" : [ "1월", "2월", "3월", "4월", "5월", "6월",
								"7월", "8월", "9월", "10월", "11월", "12월" ]
					},
					"startDate" : "2024/09/09",
					"endDate" : "2024/10/10",
					"opens" : "center"
				},
				function(start, end, label) {
					console.log('New date range selected: '
							+ start.format('YYYY-MM-DD') + ' to '
							+ end.format('YYYY-MM-DD') + ' (predefined range: '
							+ label + ')');
				});
	});
	
	

	
</script>


</head>
<body>

	<div id="map" style="width: 800px; height: 600px;"></div>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		};
		
		var map = new kakao.maps.Map(mapContainer, mapOption);
	</script>


	<h2>날짜를 먼저 선택해주세요</h2>
	<input type="text" class="duration" value="" />
</body>
