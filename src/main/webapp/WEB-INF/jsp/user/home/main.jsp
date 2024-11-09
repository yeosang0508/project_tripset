<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/resource/main.css" />

<%@ include file="../common/head.jspf"%>
<%@ include file="../popups/reservationPopup.jspf"%>
<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>
<%@ include file="../popups/travelRecommendChecklist.jspf"%>
<%@ include file="../popups/CheckMySchedulePopup.jspf"%>
<%@ include file="../popups/ChecklistPopup.jspf"%>


<main class="container mx-auto">
	<!-- Introduction Section -->
	<section class="contents">
		<header class="tripset">
			<div class="tripset2">
				<h1 class="trip-set">TRIPSET</h1>
				<p class="description">당신만의 여행 계획을 세우고, 특별한 경험을 만들어 보세요. 여행지 추천, 일정 관리, 체크리스트까지 한 곳에서 편리하게!</p>
			</div>
			<nav class="action-link">
				<a href="../plans/write" class="write">
					<div class="arrow">
						<span></span>
						<span></span>
						<span></span>
					</div>
				</a>
			</nav>
		</header>

		<!-- Feature Section -->
		<section class="features">
			<article class="feature">
				<figure class="image">
					<button class="nav-reservation-button">
						<img class="frame-3849" src="/resource/images/reservation.png" alt="항공 및 숙박 예약" />
					</button>
				</figure>
				<div class="info">
					<h2 class="title">항공 및 숙박 예약하기</h2>
					<p class="description">여행 계획할 때 필요한 항공편과 숙박 예약을 할 수 있도록 바로 이동할 수 있습니다.</p>
				</div>
			</article>

			<article class="feature">
				<figure class="image">
					<button class="nav-checklist-button">
						<img class="frame-3849" src="/resource/images/checklist.png" alt="체크리스트" />
					</button>
				</figure>
				<div class="info">
					<h2 class="title">체크리스트</h2>
					<p class="description">여행 전 챙겨야 할 필수 아이템을 놓치지 않도록 확인해보세요.</p>
				</div>
			</article>

			<article class="feature">
				<figure class="image">
					<button class="nav-travelRecommend-button">
						<img class="frame-3849" src="/resource/images/customtravel.png" alt="맞춤형 여행 추천" />
					</button>
				</figure>
				<div class="info">
					<h2 class="title">맞춤형 여행 추천 서비스</h2>
					<p class="description">AI 맞춤형 추천으로 완벽한 여행을 계획하세요!</p>
				</div>
			</article>

			<article class="feature">
				<figure class="image">
					<a href="/usr/article/list" class="button">
						<img class="frame-3849" src="/resource/images/article.png" alt="여행 계획 모아보기" />
					</a>
				</figure>
				<div class="info">
					<h2 class="title">여행 계획 모아보기</h2>
					<p class="description">
						다양한 사람들이 공유한 여행 계획을 확인해보세요!
						<br />
					</p>
				</div>
			</article>
		</section>
	</section>
</main>

<%@ include file="../common/foot.jspf"%>