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

	document.querySelector('.nav-signup-button').addEventListener(
			'click',
			function() {
				document.querySelector('.signup-popup').classList
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

	document.querySelector('.signup-popup .close-popup')
			.addEventListener(
					'click',
					function() {
						document.querySelector('.signup-popup').classList
								.add('hidden');
						document.querySelector('.popup-bg').classList
								.add('hidden');
					});

	document.querySelector('.popup-bg')
			.addEventListener(
					'click',
					function() {
						document.querySelectorAll(
								'.login-popup, .signup-popup').forEach(
								function(popup) {
									popup.classList.add('hidden');
								});
						document.querySelector('.popup-bg').classList
								.add('hidden');
					});

	document.querySelectorAll('.popup-container').forEach(
			function(container) {
				container.addEventListener('click', function(event) {
					event.stopPropagation();
				});
			});

	document.getElementById('next-step')
			.addEventListener(
					'click',
					function() {
						document.getElementById('step1').classList
								.add('hidden');

						document.getElementById('step2').classList
								.remove('hidden');
					});
});

// 회원가입 다음 버튼 클릭 시 step1(아이디, 비밀번호)값을 임시 저장 

document.getElementById('next-step').addEventListener('click', function() {
	const loginId = document.getElementById('loginId').value;
	const loginPw = document.getElementById('loginPw').value;
	const confirmPw = document.getElementById('confirmPw').value;

	// step1의 값을 step2로 전달하기 위해 hidden input에 값 설정 
	document.getElementById('hiddenLoginId').value = loginId;
	document.getElementById('hiddenLoginPw').value = loginPw;

	// step1을 숨기고 step2를 보여줌
	document.getElementById('step1').classList.add('hidden');
	document.getElementById('step2').classList.remove('hidden');

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

<!-- 로그인 팝업 -->
	<div class="popup-bg fixed inset-0 bg-black bg-opacity-70 hidden z-40"></div>
	<div class="login-popup fixed inset-0 flex items-center justify-center hidden z-50">
		<div class="popup-container w-[450px] h-[500px] p-8 bg-white rounded-lg shadow-lg relative">
			<div class="popup-header flex justify-end">
				<button class="close-popup text-3xl font-bold">×</button>
			</div>
			<div class="popup-body mt-4">
				<h2 class="text-center font-bold text-2xl mb-8">LOGIN</h2>
				<div class="w-full mt-6">
					<form class="input-container mb-4" action="../member/doLogin" method="POST" name="login">

						<label class="block text-left font-medium text-base mb-1">ID:</label>
						<input type="text" name="loginId" class="input-field w-full h-[47px] px-4 border rounded-md mb-6"
							placeholder="아이디를 입력해주세요." />

						<label class="block text-left font-medium text-base mb-1">Password:</label>
						<input type="password" name="loginPw" class="input-field w-full h-[47px] px-4 border rounded-md mb-6"
							placeholder="비밀번호를 입력해주세요." />
						<button class="popup-login-button w-full h-[47px] bg-[#4D9FFF] text-white font-semibold rounded-md mt-4">
							로그인</button>
					</form>
					<a class="signup-message mt-4 text-left text-gray-500 text-sm" href="../member/join">회원가입이 필요한가요?</a>
				</div>
			</div>
		</div>
	</div>>
	
	
	<!-- 회원가입 팝업 -->
	<div class="popup-bg fixed inset-0 bg-black bg-opacity-70 hidden z-40"></div>
	<div class="signup-popup fixed inset-0 flex items-center justify-center hidden z-50">
		<div class="popup-container w-[450px] h-[500px] p-8 bg-white rounded-lg shadow-lg relative">
			<div class="popup-header flex justify-end">
				<button class="close-popup text-3xl font-bold">×</button>
			</div>
			<h2 class="text-center font-bold text-2xl mb-8">SIGNUP</h2>

			<form id="step1" class="input-container w-full flex flex-col items-center">
				<label class="block text-left font-bold text-lg w-full mb-1">아이디</label>
				<input type="text" name="loginId" class="input-field w-full h-[40px] px-4 border rounded-md mb-2"
					placeholder="아이디 입력해주세요(6~20자)" />
				<div class="text-red-500 text-xs w-full mb-4">사용할 수 없는 아이디입니다.</div>

				<label class="block text-left font-bold text-lg w-full mb-1">비밀번호</label>
				<input type="password" name="loginPw" class="input-field w-full h-[40px] px-4 border rounded-md mb-2"
					placeholder="비밀번호 입력해주세요(문자, 숫자, 특수문자 포함(8~20자)" />
				<div class="text-red-500 text-xs w-full mb-4">20자 이내 비밀번호를 입력해주세요.</div>

				<label class="block text-left font-bold text-lg w-full mb-1">비밀번호 확인</label>
				<input type="password" name="confirmPw" class="input-field w-full h-[40px] px-4 border rounded-md mb-2"
					placeholder="비밀번호를 다시 입력해주세요" />
				<div class="text-red-500 text-xs w-full mb-4">비밀번호가 일치하지 않습니다.</div>

				<button type="button" id="next-step"
					class="popup-login-button w-full h-[40px] bg-[#4D9FFF] text-white font-semibold rounded-md mt-4">다음</button>
			</form>

			<form id="step2" class="input-container w-full flex flex-col items-center hidden" action="../member/doSignUp"
				method="POST">

				<label class="block text-left font-bold text-lg w-full mb-1">이름</label>
				<input type="text" name="name" class="input-field w-full h-[40px] px-4 border rounded-md mb-4"
					placeholder="이름을 입력해주세요" />

				<label class="block text-left font-bold text-lg w-full mb-1">닉네임</label>
				<input type="text" name="nickname" class="input-field w-full h-[40px] px-4 border rounded-md mb-4"
					placeholder="닉네임을 입력해주세요" />


				<label class="block text-left font-bold text-lg w-full mb-1">전화번호</label>
				<input type="text" name="cellphoneNum" class="input-field w-full h-[40px] px-4 border rounded-md mb-4"
					placeholder="전화번호를 입력해주세요('-'제외)" />

				<label class="block text-left font-bold text-lg w-full mb-1">이메일</label>
				<input type="email" name="email" class="input-field w-full h-[40px] px-4 border rounded-md mb-4"
					placeholder="이메일을 입력해주세요." />


				<button type="submit"
					class="popup-login-button w-full h-[40px] bg-[#4D9FFF] text-white font-semibold rounded-md mt-4">가입하기</button>
			</form>
		</div>
	</div>
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