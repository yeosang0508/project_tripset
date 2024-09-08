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

</head>
<body>
	<!-- 팝업 배경 -->
	<div class="login-popup-bg fixed inset-0 bg-black bg-opacity-50 hidden z-40"></div>

	<!-- 팝업 -->
	<div class="login-popup fixed inset-0 flex items-center justify-center hidden z-50">
		<div class="popup-container w-[550px] h-[550px] p-8 bg-white rounded-lg shadow-lg relative">
			<div class="popup-header flex justify-end">
				<button class="close-popup text-3xl font-bold">×</button>
			</div>
			<div class="popup-body mt-4">
				<h2 class="text-center font-bold text-lg">Please Fill out form to Register!</h2>
				<div class="w-full mt-6">
					<form class="input-container mb-4" action="../member/login" method="get" name="login">
						<label class="block text-left font-medium text-base mb-1">ID:</label>
						<input type="text" name="userId" class="input-field w-full h-[47px] px-4 border rounded-md" />
						<label class="block text-left font-medium text-base mb-1">Password:</label>
						<input type="password" name="userPw" class="input-field w-full h-[47px] px-4 border rounded-md" />
						<input type="submit" class="popup-login-button w-full h-[47px] bg-[#4D9FFF] text-white font-semibold rounded-md"
							value="로그인" />
					</form>

					<a class="signup-message mt-4 text-left text-gray-500 text-sm" href="../member/join">회원가입이 필요한가요?</a>
				</div>
			</div>
		</div>
	</div>
</body>
<%@ include file="../common/foot.jspf"%>