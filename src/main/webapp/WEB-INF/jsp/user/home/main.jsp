<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../common/head.jspf"%>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		document.querySelector('.nav-login-button').addEventListener(
				'click',
				function() {
					document.querySelector('.login-popup').classList
							.remove('hidden');
					document.querySelector('.popup-bg').classList
							.remove('hidden');
				});

		document.querySelector('.login-popup .close-popup')
				.addEventListener(
						'click',
						function() {
							document.querySelector('.login-popup').classList
									.add('hidden');
							document.querySelector('.popup-bg').classList
									.add('hidden');
						});

	
		document.querySelectorAll('.popup-container').forEach(
				function(container) {
					container.addEventListener('click', function(event) {
						event.stopPropagation();
					});
				});

	});
</script>

<style>
html, body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	background: linear-gradient(180deg, rgba(218, 235, 255, 1) 12.5%,
		rgba(220, 236, 255, 1) 25%, rgba(223, 238, 255, 1) 37.5%,
		rgba(225, 239, 255, 1) 50%, rgba(228, 240, 255, 1) 56.25%,
		rgba(232, 243, 255, 1) 62.5%, rgba(238, 245, 255, 1) 75%,
		rgba(238, 245, 255, 1) 87.5%, rgba(255, 255, 255, 1) 100%);
}

.div * {
	box-sizing: border-box;
}

.contents {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: flex-start;
	width: 100%;
	padding: 20px;
	flex-grow: 1;
	position: relative;
	line-height: 2.0;
}

.div12, .div13, .paintings2, .paintings3 {
	line-height: 1.8; /* 기존 1.6에서 1.8로 줄 간격을 넓힘 */
}

.tripset {
	padding: 10px 90px 0 90px;
	display: flex;
	flex-direction: row;
	gap: 20px;
	align-items: center;
	justify-content: space-between;
	flex-wrap: wrap;
	width: 100%;
	position: relative;
}

.tripset2 {
	padding: 0 15px;
	display: flex;
	flex-direction: column;
	gap: 17px;
	align-items: flex-start;
	justify-content: flex-start;
	width: 612px;
	max-width: 100%;
	position: relative;
}

.trip-set {
	color: #000000;
	text-align: left;
	font-family: "Inter-Bold", sans-serif;
	font-size: 52px;
	line-height: 56px;
	font-weight: 700;
	position: relative;
}

.div7 {
	color: #000000;
	text-align: left;
	font-family: "Inter-Medium", sans-serif;
	font-size: 16px;
	font-weight: 500;
	position: relative;
	width: 100%;
}

.div8 {
	flex-shrink: 0;
	width: 51.49px;
	height: 24px;
	position: relative;
}

.div9 {
	width: 100%;
	height: 100%;
	position: absolute;
	right: 0;
	left: 0;
	bottom: 0;
	top: 0;
	overflow: visible;
}

.div10 {
	display: flex;
	flex-direction: row;
	gap: 24px;
	align-items: flex-start;
	justify-content: flex-start;
	width: 100%;
	position: relative;
}

.div11 {
	display: flex;
	flex-direction: column;
	gap: 4px;
	align-items: center;
	justify-content: flex-start;
	flex: 1;
	height: 434.47px;
	position: relative;
}

.image {
	padding: 10px;
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
	width: 100%;
	position: relative;
}

.frame-3849 {
	background: linear-gradient(to left, #d9d9d9, #d9d9d9);
	border-radius: 10px;
	flex: 1;
	height: 334.3px;
	position: relative;
	overflow: hidden;
	object-fit: cover;
}

.info {
	padding: 0 15px;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
	justify-content: space-between;
	width: 100%;
	position: relative;
}

.div12 {
	color: #000000;
	text-align: left;
	font-family: "Inter-Regular", sans-serif;
	font-size: 14px;
	line-height: 16px;
	font-weight: bold;
	position: relative;
	width: 100%;
}

.div13 {
	color: #000000;
	text-align: left;
	font-family: "Inter-Regular", sans-serif;
	font-size: 11px;
	line-height: 16px;
	font-weight: 400;
	position: relative;
	width: 100%;
	margin-top: 10px;
}

.paintings2 {
	color: var(--black, #161412);
	text-align: left;
	font-family: "Inter-Regular", sans-serif;
	font-size: 16px;
	line-height: 26px;
	letter-spacing: 0.88px;
	font-weight: 400;
	text-transform: uppercase;
	position: relative;
}

.paintings3 {
	color: var(--black, #161412);
	text-align: left;
	font-family: "Inter-Regular", sans-serif;
	font-size: 14px;
	line-height: 26px;
	letter-spacing: 0.88px;
	font-weight: 400;
	text-transform: uppercase;
	position: relative;
}

@media ( max-width : 768px) {
	.div2 {
		flex-direction: row;
		align-items: center;
		justify-content: space-between;
		padding: 10px;
	}
	.div3 {
		display: none;
	}
	.frame-3848 {
		position: absolute;
		left: 50%;
		transform: translateX(-50%);
		top: 10px;
	}
	.div4 {
		position: absolute;
		right: 10px;
		top: 10px;
		gap: 10px;
	}
	.div5, .signup-btn {
		font-size: 12px;
		padding: 5px 10px;
	}
}

@media ( min-width : 769px) {
	.div3 {
		display: flex;
	}
	.div4 {
		justify-content: flex-end;
	}
	.div5, .signup-btn {
		font-size: 16px;
		padding: 14px 24px;
	}
}

.arrow {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	transform: rotate(-90deg);
	cursor: pointer;
}

.arrow span {
	display: block;
	width: 1.5vw;
	height: 1.5vw;
	border-bottom: 5px solid black;
	border-right: 5px solid black;
	transform: rotate(45deg);
	margin: -10px;
	animation: animate 2s infinite;
}

.arrow span:nth-child(2) {
	animation-delay: -0.2s;
}

.arrow span:nth-child(3) {
	animation-delay: -0.4s;
}

@keyframes animate {
    0% {
        opacity: 0;
        transform: rotate(45deg) translate(-20px, -20px);
    }
    50% {
        opacity: 1;
    }
    100% {
        opacity: 0;
        transform: rotate(45deg) translate(20px, 20px);
    }
}
</style>
</head>
<body>

<%@ include file="../popups/reservationPopup.jspf" %>
<%@ include file="../popups/loginPopup.jspf" %>
<%@ include file="../popups/signUpPopup.jspf" %>

	<!-- 주요기능 -->

	<div class="contents">
		<div class="tripset">
			<div class="tripset2">
				<div class="trip-set">TRIPSET</div>
				<div class="div7">당신만의 여행 계획을 세우고, 특별한 경험을 만들어 보세요. 여행지 추천, 일정 관리, 체크리스트까지 한 곳에서 편리하게!</div>
			</div>
			<div class="div8">
				<a href="../plans/write">
					<div class="arrow">
						<span></span>
						<span></span>
						<span></span>
					</div>
				</a>

			</div>
		</div>
		<div class="div10">
			<div class="div11">
				<div class="image">
					<button class="nav-reservation-button">
						<img class="frame-3849" src="/resource/images/reservation.png" />
					</button>
				</div>
				<div class="info">
					<div class="div12">항공 및 숙박 예약하기</div>
					<div class="div13">여행 계획할 때 필요한 항공편과 숙박 예약을 할 수 있도록 바로 이동할 수 있습니다.</div>
				</div>
			</div>
			<div class="div11">
				<div class="image">
					<img class="frame-3849" src="/resource/images/checklist.png" />
				</div>
				<div class="info">
					<div class="div12">체크리스트</div>
					<div class="div13">여행 전 챙겨야 할 필수 아이템을 놓치지 않도록 확인해보세요.</div>
				</div>
			</div>
			<div class="div11">
				<div class="image">
					<img class="frame-3849" src="/resource/images/customtravel.png" />
				</div>
				<div class="info">
					<div class="div12">맞춤형 여행 추천 서비스</div>
					<div class="div13">AI 맞춤형 추천으로 완벽한 여행을 계획하세요!</div>
				</div>
			</div>
			<div class="div11">
				<div class="image">
					<img class="frame-3849" src="/resource/images/model.png" />
				</div>
				<div class="info">
					<div class="div12">날씨 기반 옷 스타일링 추천</div>
					<div class="div13">
						오늘 날씨에 맞는 스타일링을 추천받으세요!
						<br />
						현재 위치의 날씨와 계절에 따라 적절한 옷차림을 제안합니다.
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../common/foot.jspf"%>