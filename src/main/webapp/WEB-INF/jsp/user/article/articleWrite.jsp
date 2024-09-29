<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>
<%@ include file="../popups/CheckMySchedulePopup.jspf"%>
<hr />

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 20px;
}

h1 {
	text-align: center;
	color: #333;
	font-size: 24px;
	margin-bottom: 40px;
}

.timeline-container {
	position: relative;
	width: 80%;
	margin: 0 auto;
	padding-left: 50px;
	padding-right: 50px;
}

/* 중앙 타임라인 선 */
.timeline-container::before {
	content: '';
	position: absolute;
	top: 0;
	bottom: 0;
	left: 50%;
	width: 4px;
	background-color: #ffa500;
}

.timeline-item {
	position: relative;
	width: 45%;
	margin-bottom: 40px;
	padding: 20px;
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* 왼쪽에 표시될 일정 */
.timeline-item.left {
	left: 0;
}

/* 오른쪽에 표시될 일정 */
.timeline-item.right {
	left: 55%;
}

/* 선과 연결되는 원형 */
.timeline-item::before {
	content: '';
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	width: 20px;
	height: 20px;
	border-radius: 50%;
	background-color: #ffa500;
	z-index: 1;
}

.timeline-item.left::before {
	right: -30px;
}

.timeline-item.right::before {
	left: -30px;
}

.timeline-item img {
	width: 100%;
	border-radius: 10px;
	margin-bottom: 10px;
}

.timeline-item h3 {
	font-size: 18px;
	color: #333;
	margin-bottom: 10px;
}

.timeline-item p {
	color: #666;
	font-size: 14px;
}
</style>
</head>
<body>

	<div class="flex justify-between items-center m-10">
		<h1 class="font-bold">대전 여행 일정</h1>
		<i class="bi bi-heart" style="font-size: 30px;"></i>
	</div>

	<div class="timeline-container">
		<!-- 1일차 -->
		<div class="timeline-item left">
			<img src="https://via.placeholder.com/300x200" alt="1일차">
			<h3>1일차: 대전 도착 및 시내 관광</h3>
			<p>대전역 도착, 시내 주요 관광지 탐방</p>
		</div>

		<!-- 2일차 -->
		<div class="timeline-item right">
			<img src="https://via.placeholder.com/300x200" alt="2일차">
			<h3>2일차: 한밭수목원 & 대전 엑스포 과학공원</h3>
			<p>한밭수목원 산책 및 대전 엑스포 과학공원 탐방</p>
		</div>

		<!-- 3일차 -->
		<div class="timeline-item left">
			<img src="https://via.placeholder.com/300x200" alt="3일차">
			<h3>3일차: 유성 온천 & 대청호</h3>
			<p>유성 온천에서 휴식, 대청호 드라이브</p>
		</div>

		<!-- 4일차 -->
		<div class="timeline-item right">
			<img src="https://via.placeholder.com/300x200" alt="4일차">
			<h3>4일차: 계족산 황톳길 걷기</h3>
			<p>계족산에서 황톳길 걷기 체험</p>
		</div>

		<!-- 5일차 -->
		<div class="timeline-item left">
			<img src="https://via.placeholder.com/300x200" alt="5일차">
			<h3>5일차: 대전 오월드</h3>
			<p>대전 오월드 방문 후 출발</p>
		</div>
	</div>


</body>
</html>

