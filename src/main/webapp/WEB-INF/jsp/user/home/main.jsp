<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../common/head.jspf"%>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		// 팝업 열기 - 네비게이션 로그인 버튼 클릭 시 팝업 열림
		document.querySelector('.nav-login-button').addEventListener(
				'click',
				function() {
					document.querySelector('.login-popup').classList
							.remove('hidden');
					document.querySelector('.login-popup-bg').classList
							.remove('hidden');
				});

		// 팝업 닫기 (X 버튼 클릭 시)
		document.querySelector('.close-popup').addEventListener(
				'click',
				function() {
					document.querySelector('.login-popup').classList
							.add('hidden');
					document.querySelector('.login-popup-bg').classList
							.add('hidden');
				});
		// 배경 클릭 시 팝업 닫기
		document.querySelector('.login-popup-bg').addEventListener(
				'click',
				function() {
					document.querySelector('.login-popup').classList
							.add('hidden');
					document.querySelector('.login-popup-bg').classList
							.add('hidden');
				});

		// 팝업 내부 클릭 시 이벤트 전파 중지 (팝업이 닫히지 않도록)
		document.querySelector('.popup-container').addEventListener('click',
				function(event) {
					event.stopPropagation(); // 팝업 내부에서의 클릭은 배경으로 이벤트 전파되지 않도록 설정
				});

	});
</script>

<style>
html, body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	overflow-x: hidden;
	overflow-y: hidden;
}

.div, .div * {
	box-sizing: border-box;
}

.div {
	background: linear-gradient(180deg, rgba(218, 235, 255, 1) 12.5%,
		rgba(220, 236, 255, 1) 25%, rgba(223, 238, 255, 1) 37.5%,
		rgba(225, 239, 255, 1) 50%, rgba(228, 240, 255, 1) 56.25%,
		rgba(232, 243, 255, 1) 62.5%, rgba(238, 245, 255, 1) 75%,
		rgba(238, 245, 255, 1) 87.5%, rgba(255, 255, 255, 1) 100%);
	border-style: solid;
	border-color: rgba(0, 0, 0, 0.1);
	border-width: 1px;
	display: flex;
	flex-direction: column;
	gap: 20px;
	align-items: center;
	justify-content: flex-start;
	width: 100%;
	height: 100%;
	position: relative;
	overflow-y: auto;
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
}

.tripset {
	padding: 20px 90px 0 90px;
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
	font-weight: 400;
	position: relative;
	width: 100%;
}

.div13 {
	color: #000000;
	text-align: left;
	font-family: "Inter-Regular", sans-serif;
	font-size: 10px;
	line-height: 16px;
	font-weight: 400;
	position: relative;
	width: 100%;
}

.frame-3850 {
	display: flex;
	flex-direction: column;
	gap: 0;
	align-items: center;
	justify-content: flex-start;
	width: 100%;
	padding: 20px;
	margin-top: auto;
	position: relative;
}

.div14 {
	padding: 9px 83px;
	display: flex;
	flex-direction: row;
	gap: 10px;
	align-items: flex-start;
	justify-content: flex-start;
	width: 100%;
	position: relative;
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

.div15 {
	display: flex;
	flex-direction: row;
	gap: 100px;
	align-items: center;
	justify-content: center;
	width: 100%;
	position: relative;
}

.div16 {
	flex-shrink: 0;
	width: 150px;
	height: 151.51px;
	position: relative;
	object-fit: cover;
}

.div17 {
	display: flex;
	flex-direction: column;
	gap: 5px;
	align-items: flex-start;
	justify-content: flex-end;
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

.e-mail-yeosang-0508-gmail-com {
	color: #000000;
	text-align: left;
	font-family: "-", sans-serif;
	font-size: 14px;
	line-height: 26px;
	letter-spacing: 0.88px;
	font-weight: 400;
	position: relative;
}

.e-mail-yeosang-0508-gmail-com-span,
	.e-mail-yeosang-0508-gmail-com-span2,
	.e-mail-yeosang-0508-gmail-com-span3,
	.e-mail-yeosang-0508-gmail-com-span4,
	.e-mail-yeosang-0508-gmail-com-span5 {
	color: #000000;
	font-size: 14px;
	line-height: 26px;
	letter-spacing: 0.88px;
	font-weight: 300;
}

.github {
	flex-shrink: 0;
	width: 29.95px;
	height: 29.93px;
	position: relative;
}

.github2 {
	width: 100%;
	height: 100%;
	position: absolute;
	overflow: visible;
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
</style>
</head>
<body>
	<!-- 팝업 배경 -->
	<div class="login-popup-bg fixed inset-0 bg-black bg-opacity-50 hidden z-40"></div>

	<!-- 팝업 -->
	<div class="login-popup fixed inset-0 flex items-center justify-center hidden z-50">
		<table class="popup-container w-[550px] h-[550px] p-8 bg-white rounded-lg shadow-lg relative">
			<thead>
				<tr>
					<th class="popup-header flex justify-end">
						<button class="close-popup text-3xl font-bold">×</button>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<div class="popup-body mt-4">
							<h2 class="text-center font-bold text-lg">Please Fill out form to Register!</h2>
							<div class="w-full mt-6">
								<form class="input-container mb-4" action="../member/doLogin" method="POST" name="login">
				
									<label class="block text-left font-medium text-base mb-1">ID:</label>
									<input type="text" name="loginId" class="input-field w-full h-[47px] px-4 border rounded-md"
										placeholder="아이디를 입력해주세요." />

									<label class="block text-left font-medium text-base mb-1">Password:</label>
									<input type="password" name="loginPw" class="input-field w-full h-[47px] px-4 border rounded-md"
										placeholder="비밀번호를 입력해주세요." />

									<button class="popup-login-button w-full h-[47px] bg-[#4D9FFF] text-white font-semibold rounded-md">로그인</button>
								</form>


								<a class="signup-message mt-4 text-left text-gray-500 text-sm" href="../member/join">회원가입이 필요한가요?</a>
							</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<!-- 주요기능 -->
	<div class="div">
		<div class="contents">
			<div class="tripset">
				<div class="tripset2">
					<div class="trip-set">TripSet</div>
					<div class="div7">당신만의 여행 계획을 세우고, 특별한 경험을 만들어 보세요. 여행지 추천, 일정 관리, 체크리스트까지 한 곳에서 편리하게!</div>
				</div>
				<div class="div8">
					<img class="div9" src="div7.svg" />
				</div>
			</div>
			<div class="div10">
				<div class="div11">
					<div class="image">
						<img class="frame-3849" src="frame-38490.png" />
					</div>
					<div class="info">
						<div class="div12">항공 및 숙박 예약하기</div>
						<div class="div13">여행 계획할 때 필요한 항공편과 숙박 예약을 할 수 있도록 바로 이동할 수 있습니다.</div>
					</div>
				</div>
				<div class="div11">
					<div class="image">
						<img class="frame-3849" src="frame-38491.png" />
					</div>
					<div class="info">
						<div class="div12">체크리스트</div>
						<div class="div13">여행 전 챙겨야 할 필수 아이템을 놓치지 않도록 확인해보세요.</div>
					</div>
				</div>
				<div class="div11">
					<div class="image">
						<img class="frame-3849" src="frame-38492.png" />
					</div>
					<div class="info">
						<div class="div12">맞춤형 여행 추천 서비스</div>
						<div class="div13">AI 맞춤형 추천으로 완벽한 여행을 계획하세요!</div>
					</div>
				</div>
				<div class="div11">
					<div class="image">
						<img class="frame-3849" src="frame-38493.png" />
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
		<div class="frame-3850">
			<div class="div14">
				<div class="paintings2">개발자 정보</div>
			</div>
			<div class="div15">
				<img class="div16" src="div23.png" />
				<div class="div17">
					<div class="paintings3">
						안녕하세요! 저는 웹 개발자 신승애입니다.
						<br />
						이 프로젝트는 여행을 계획하는 사람들에게 여행 계획에 소요되는 시간을 줄일 수 있고, 보다 직관적이고,
						<br />
						효율적인 계획을 세울 수 있도록 돕기 위해 개발되었습니다.
					</div>
					<div class="e-mail-yeosang-0508-gmail-com">
						<span>
							<span class="e-mail-yeosang-0508-gmail-com-span">e-mail :</span>
							<span class="e-mail-yeosang-0508-gmail-com-span2"></span>
							<span class="e-mail-yeosang-0508-gmail-com-span3">yeosang</span>
							<span class="e-mail-yeosang-0508-gmail-com-span4">0508@</span>
							<span class="e-mail-yeosang-0508-gmail-com-span5">gmail.com</span>
						</span>
					</div>
					<div class="github">
						<img class="github2" src="github1.svg" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../common/foot.jspf"%>