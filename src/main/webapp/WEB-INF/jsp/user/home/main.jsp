<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../common/head.jspf"%>

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

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

		document.getElementById('prev-step')
				.addEventListener(
						'click',
						function() {
							document.getElementById('step2').classList
									.add('hidden');

							document.getElementById('step1').classList
									.remove('hidden');
						});
	});
</script>

<!-- 예약사이트 팝업 -->
<script>
	document.addEventListener('DOMContentLoaded', function() {
		// 팝업 열기 버튼 클릭 시 팝업을 표시
		document.querySelector('.nav-reservation-button').addEventListener(
				'click',
				function() {
					document.querySelector('.reservation-popup').classList
							.remove('hidden');
					document.querySelector('.popup1-bg').classList
							.remove('hidden');
				});

		// 닫기 버튼 클릭 시 팝업 닫기
		document.querySelector('.close-popup').addEventListener(
				'click',
				function() {
					document.querySelector('.reservation-popup').classList
							.add('hidden');
					document.querySelector('.popup1-bg').classList
							.add('hidden');
				});

	});
</script>

<!-- 회원가입 -->
<script>
	let validLoginId = ""; // 유효한 로그인 아이디를 저장할 전역 변수
	let loginId = ''; // 로그인 아이디 변수
	let loginPw = ''; // 비밀번호 변수
	let loginPwConfirm = '';

	// 다음 버튼 클릭 시, 아이디와 비밀번호를 step 2에 넘김
	document.addEventListener('DOMContentLoaded', function() {
		const nextStepButton = document.getElementById('next-step');

		if (nextStepButton) { // 요소가 존재하는지 확인
			nextStepButton.addEventListener('click', function() {

				// 입력된 값을 가져옴
				loginId = document.getElementById('loginId').value.trim();
				loginPw = document.getElementById('loginPw').value.trim();

				const loginPwConfirm = document
						.getElementById('loginPwConfirm').value.trim();

				// 아이디 유효성 검사
				if (loginId.length === 0) {
					alert('아이디를 입력해주세요');
					return;
				}
				if (loginId !== validLoginId) {
					alert('사용할 수 없는 아이디입니다.');
					document.getElementById('loginId').focus();
					return;
				}

				// 비밀번호 유효성 검사
				if (loginPw.length === 0) {
					alert('비밀번호를 입력해주세요');
					return;
				}
				if (loginPwConfirm.length === 0) {
					alert('비밀번호 확인을 입력해주세요');
					return;
				}
				if (loginPw !== loginPwConfirm) {
					alert('비밀번호가 일치하지 않습니다.');
					document.getElementById('loginPw').focus();
					return;
				}

				/* step2에 loginId, loginPw 넘길 수 있도록 step1에서 입력한 값 설정 */
				document.getElementById('hiddenLoginId').value = loginId;
				document.getElementById('hiddenLoginPw').value = loginPw;

			});
		} else {
			console.error("next-step 버튼을 찾을 수 없습니다.");
		}
	});
	// 회원가입 제출 폼
	function JoinForm__submit(form) {
		// 이름, 닉네임, 이메일, 전화번호 유효성 검사
		form.name.value = form.name.value.trim();
		if (form.name.value.length === 0) {
			alert('이름을 입력해주세요');
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value.length === 0) {
			alert('닉네임을 입력해주세요');
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length === 0) {
			alert('이메일을 입력해주세요');
			return;
		}
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value.length === 0) {
			alert('전화번호를 입력해주세요');
			return;
		}
		// 모든 검증을 통과하면 폼 제출
		form.submit();
	}

	// 아이디 중복 검사
	function checkLoginIdDup(el) {
		$('.checkDup-msg').empty();
		const form = $(el).closest('form').get(0);
		if (form.loginId.value.length === 0) {
			validLoginId = '';
			return;
		}

		// 서버로 아이디 중복 확인 요청
		$.get('../member/getLoginIdDup', {
			isAjax : 'Y',
			loginId : form.loginId.value
		}, function(data) {
			$('.checkDup-msg').html('<div class="">' + data.msg + '</div>')
			if (data.success) {
				validLoginId = data.data1;
			} else {
				validLoginId = '';
			}
		}, 'json');
	}

	// 디바운스: 입력한 아이디를 일정 시간 후에 중복 확인 (600ms)
	const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 600);
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

	<div class="popup1-bg fixed inset-0 bg-black bg-opacity-70 hidden z-40"></div>

	<!-- 예약사이트 팝업창 -->

	<div class="reservation-popup fixed inset-0 flex items-center justify-center hidden z-50">
		<div class="w-[10000px] h-[900px] p-8 bg-white rounded-lg shadow-lg relative overflow-y-auto">
			<div class="flex justify-between items-start">
				<div class="text-black text-left font-bold text-2xl">예약사이트</div>
				<button class="close-popup text-3xl font-bold">×</button>
			</div>
			<div class="mt-8">
				<!-- 항공예약 섹션 -->
				<div class="px-8 mb-10">
					<div class="text-blue-500 text-left font-bold text-2xl mb-6">항공예약</div>
					<div class="grid grid-cols-4 gap-10 justify-items-center">
						<div class="flex flex-col items-center">
							<a href="https://m.flyasiana.com/C/KR/KO/index" target="_blank">
								<img class="w-[200px] h-[200px] rounded-lg object-cover" src="/resource/images/asiana.png" />
							</a>
							<div class="text-black text-center font-normal text-base mt-2">아시아나항공</div>
						</div>
						<div class="flex flex-col items-center">
							<a
								href="https://kr.trip.com/?locale=ko_kr&allianceid=14887&sid=1621818&ppcid=ckid-14179040861_adid-701322319668_akid-kwd-415216391968_adgid-164000253518&utm_source=google&utm_medium=cpc&utm_campaign=21356875675&gad_source=1&gclid=CjwKCAjw3P-2BhAEEiwA3yPhwMKp3_RHC20fucfOF2bCORLm1IgkwUSv2X4bpXqVa3Trz9Y1u5pBtxoCRHEQAvD_BwE"
								target="_blank">
								<img class="w-[200px] h-[200px]  rounded-lg object-cover" src="/resource/images/tripcom.png" />
							</a>
							<div class="text-black text-center font-normal text-base mt-2">트립닷컴</div>
						</div>
						<div class="flex flex-col items-center">
							<a
								href="https://www.finnair.com/kr-ko?utm_source=google&utm_medium=cpc&utm_campaign=kr_book_always-on_always-on_kr-brand_ko&utm_content=MASTERBRAND&utm_term=&gad_source=1&gclid=CjwKCAjw3P-2BhAEEiwA3yPhwCHKHONrQFttox9AkS_yny4UyJHGL2qQxkYvihqlXj_fTSz8bAYxbBoCY1sQAvD_BwE&gclsrc=aw.ds"
								target="_blank">
								<img class="w-[200px] h-[200px]  rounded-lg object-cover" src="/resource/images/finnair.png" />
							</a>
							<div class="text-black text-center font-normal text-base mt-2">핀에어</div>
						</div>
						<div class="flex flex-col items-center">
							<a
								href="https://www.skyscanner.co.kr/?&utm_source=google&utm_medium=cpc&utm_campaign=KR-Travel-Search-Brand-SkyscannerPure-Desktop&utm_term=%EC%8A%A4%EC%B9%B4%EC%9D%B4%EC%8A%A4%EC%BA%90%EB%84%88&associateID=SEM_FLI_19465_00000&campaign_id=21457301665&adgroupid=170117947168&keyword_id=kwd-328473592748&gad_source=1&gclid=CjwKCAjw3P-2BhAEEiwA3yPhwNWqK2DaItqiWt924Th2kNKwaRIimIvwnkSo-YHz_E4ISDtu7S6-uRoCkmcQAvD_BwE&gclsrc=aw.ds"
								target="_blank">
								<img class="w-[200px] h-[200px]  rounded-lg object-cover" src="/resource/images/skyscanner.png" />
							</a>
							<div class="text-black text-center font-normal text-base mt-2">스카이스캐너</div>
						</div>
					</div>
				</div>
				<!-- 숙박예약 섹션 -->
				<div class="px-8">
					<div class="text-blue-500 text-left font-bold text-2xl mb-6">숙박예약</div>
					<div class="grid grid-cols-4 gap-10 justify-items-center">
						<div class="flex flex-col items-center">
							<a
								href="https://www.agoda.com/ko-kr/?site_id=1922887&tag=eeeb2a37-a3e0-4932-8325-55d6a8ba95a4&gad_source=1&device=c&network=g&adid=702606525837&rand=10582393992057784631&expid=&adpos=&aud=kwd-304551434341&gclid=CjwKCAjw3P-2BhAEEiwA3yPhwDlUJV76sly4sOwQK3KlJirsHtibq6WxwksEhDi1Yphu02dPFSz3oxoCuCYQAvD_BwE&pslc=1&ds=wGwGYTAtyu38D9OO"
								target="_blank">
								<img class="w-[200px] h-[200px]  rounded-lg object-cover" src="/resource/images/agoda.png" />
							</a>
							<div class="text-black text-center font-normal text-base mt-2">아고다</div>
						</div>
						<div class="flex flex-col items-center">
							<a
								href="https://www.hotelscombined.co.kr/Place/Daejeon_Metropolitan_City.htm?sck=SEM&skipapp=true&gclid=CjwKCAjw3P-2BhAEEiwA3yPhwCSZlUQ4jDQHE1G3_W0FeRfRlqH3rC_0Ld3rdOfiHmBjZmQ6RGxbjhoCNIsQAvD_BwE"
								target="_blank">
								<img class="w-[200px] h-[200px]  rounded-lg object-cover" src="/resource/images/hotelscombined.png" />
							</a>
							<div class="text-black text-center font-normal text-base mt-2">호텔스컴바인</div>
						</div>
						<div class="flex flex-col items-center">
							<a
								href="https://www.trivago.co.kr/ko-KR?themeId=280&sem_keyword=%ED%8A%B8%EB%A6%AC%EB%B0%94%EA%B3%A0&sem_creativeid=550079560013&sem_matchtype=e&sem_network=g&sem_device=c&sem_placement=&sem_target=&sem_adposition=&sem_param1=&sem_param2=&sem_campaignid=304262920&sem_adgroupid=100658847299&sem_targetid=kwd-309008850360&sem_location=1009880&cipc=br&cip=8219000005&gad_source=1&gclid=CjwKCAjw3P-2BhAEEiwA3yPhwKf6Vg2khIo6tgQkFggGrjpBkUwWDKSFGMK_YwtnIsMuZar-ZkuUFxoCGTEQAvD_BwE"
								target="_blank">
								<img class="w-[200px] h-[200px] rounded-lg object-cover" src="/resource/images/trivago.png" />
							</a>
							<div class="text-black text-center font-normal text-base mt-2">트리바고</div>
						</div>
						<div class="flex flex-col items-center">
							<a href="https://www.yanolja.com/" target="_blank">
								<img class="w-[200px] h-[200px]  rounded-lg object-cover" src="/resource/images/yanolja.png" />
							</a>
							<div class="text-black text-center font-normal text-base mt-2">야놀자</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


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
	</div>



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
				<input onkeyup="checkLoginIdDupDebounced(this);" type="text" id="loginId" name="loginId"
					class="input-field w-full h-[40px] px-4 border rounded-md mb-2" autocomplete="off" placeholder="아이디 입력해주세요(6~20자)" />
				<div class=" text-red-500 text-xs w-full mb-4"></div>

				<label class="block text-left font-bold text-lg w-full mb-1">비밀번호</label>
				<input type="password" id="loginPw" name="loginPw" class="input-field w-full h-[40px] px-4 border rounded-md mb-2"
					autocomplete="off" placeholder="비밀번호 입력해주세요(문자, 숫자, 특수문자 포함(8~20자)" />
				<div class="text-red-500 text-xs w-full mb-4">20자 이내 비밀번호를 입력해주세요.</div>

				<label class="block text-left font-bold text-lg w-full mb-1">비밀번호 확인</label>
				<input type="password" id="loginPwConfirm" name="loginPwConfirm"
					class="input-field w-full h-[40px] px-4 border rounded-md mb-2" autocomplete="off" placeholder="비밀번호를 다시 입력해주세요" />
				<div class="text-red-500 text-xs w-full mb-4">비밀번호가 일치하지 않습니다.</div>
				<div class="flex justify-end w-full gap-2">
					<button type="button" id="next-step" class="popup-login-button next-button text-black font-semibold rounded-md">다음</button>
				</div>
			</form>


			<form id="step2" class="input-container w-full flex flex-col items-center hidden" action="../member/doSignUp"
				method="POST" onsubmit="JoinForm__submit(this); return false;">

				<!-- hidden 필드를 통해서 이전 단계에서 받은 loginId와 loginPw를 서버로 전송 -->
				<input type="hidden" id="hiddenLoginId" name="loginId" />
				<input type="hidden" id="hiddenLoginPw" name="loginPw" />
				<label class="block text-left font-bold text-lg w-full mb-1">이름</label>
				<input type="text" name="name" class="input-field w-full h-[40px] px-4 border rounded-md mb-4" autocomplete="off"
					placeholder="이름을 입력해주세요" />

				<label class="block text-left font-bold text-lg w-full mb-1">닉네임</label>
				<input type="text" name="nickname" class="input-field w-full h-[40px] px-4 border rounded-md mb-4"
					autocomplete="off" placeholder="닉네임을 입력해주세요" />

				<label class="block text-left font-bold text-lg w-full mb-1">전화번호</label>
				<input type="text" name="cellphoneNum" class="input-field w-full h-[40px] px-4 border rounded-md mb-4"
					autocomplete="off" placeholder="전화번호를 입력해주세요('-'제외)" />

				<label class="block text-left font-bold text-lg w-full mb-1">이메일</label>
				<input type="email" name="email" class="input-field w-full h-[40px] px-4 border rounded-md mb-4" autocomplete="off"
					placeholder="이메일을 입력해주세요." />


				<div class="flex justify-end w-full gap-2">
					<button type="button" id="prev-step" class="prev-button text-black font-semibold rounded-md">이전</button>

					<button type="submit" class="popup-login-button font-semibold rounded-md">가입하기</button>
				</div>

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