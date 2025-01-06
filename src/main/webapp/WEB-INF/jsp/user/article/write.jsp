<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>
<%@ include file="../popups/CheckMySchedulePopup.jspf"%>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
    
        if (!localStorage.getItem('selectedSchedule')) {
            document.querySelector('.check-my-schedule-popup').classList.remove('hidden');
            document.querySelector('.popup-bg').classList.remove('hidden');
        }
 
        $('.check-my-schedule-popup').on('click', function() {
            $.ajax({
                url: '/usr/plans/getUserTravelPlan',
                method: 'GET',
                dataType: 'json',
                success: function(plans) {
                    var htmlContent = '';

                    if (plans && plans.length > 0) {
                        plans.forEach(function(plan) {
                            htmlContent += `
                                <div class="flex justify-between items-center px-4 py-3 rounded-lg bg-gray-200">
                                    <a href="#" onclick="selectSchedule(${plan.id})" class="block flex-1">
                                        <span>${plan.region} 여행 ${plan.startDate} ~ ${plan.endDate}</span>
                                    </a>
                                </div>`;
                        });
                    } else {
                        htmlContent = '<div class="flex items-center justify-center h-[300px] text-gray-500">예정된 여행 일정이 없습니다.</div>';
                    }

                    document.querySelector('.check-my-schedule-popup .popup-body').innerHTML = htmlContent;
                },
                error: function(xhr, status, error) {
                    console.error('AJAX 요청 실패:', error);
                }
            });
        });

        
        window.selectSchedule = function(scheduleId) {
            localStorage.setItem('selectedSchedule', scheduleId);
            document.querySelector('.check-my-schedule-popup').classList.add('hidden');
            document.querySelector('.popup-bg').classList.add('hidden');
        };


        document.querySelector('.check-my-schedule-popup .close-popup').addEventListener('click', function() {
            document.querySelector('.check-my-schedule-popup').classList.add('hidden');
            document.querySelector('.popup-bg').classList.add('hidden');
        });


        document.querySelector('.popup-bg').addEventListener('click', function() {
            document.querySelector('.check-my-schedule-popup').classList.add('hidden');
            document.querySelector('.popup-bg').classList.add('hidden');
        });
    });
</script>

<html>
<head>
<title>나만의 여행 일정 공유하기</title>
<link rel="stylesheet" href="/path/to/your/css">
</head>
<body class="bg-blue-50 text-gray-800">
	<div class="popup-bg fixed inset-0 bg-black bg-opacity-50 hidden z-40"></div>
	<div class="check-my-schedule-popup fixed inset-0 flex items-center justify-center hidden z-50">
		<div class="popup-container relative w-[450px] h-[500px] bg-white rounded-lg shadow-lg">
			<div class="popup-header absolute top-0 left-0 w-full flex justify-between items-start p-6">
				<h2 class="font-bold text-2xl">My일정확인</h2>
				<button class="close-popup text-3xl font-bold">×</button>
			</div>
			<div class="popup-body relative mt-[88px] p-8"></div>
		</div>
	</div>

	<header class="bg-blue-50 text-gray-800 p-4 border-b border-blue-200">
		<div class="container mx-auto">
			<h1 class="text-3xl font-bold">📅 나만의 여행 일정 공유하기</h1>
		</div>
	</header>

	<main class="container mx-auto max-w-4xl p-8 bg-white shadow-md rounded-md mt-8">
		<section class="p-6 rounded-lg shadow-md mb-8 border border-blue-200">
			<h2 class="text-2xl font-bold mb-4">📋 내 일정 목록</h2>
			<div class="flex overflow-x-auto space-x-4">
				<c:forEach var="plan" items="${travelPlans}" varStatus="status">
					<div class="p-4 rounded-lg flex items-center justify-between min-w-[250px] border border-blue-300">
						<div>
							<span class="font-bold text-lg">${status.index + 1}. ${plan.region}</span>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>

		<form onsubmit="ArticleWrite__submit(this); return false;" action="../article/doWrite" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="body" />
			<input type="hidden" name="${currentId}">

			<div class="grid grid-cols-2 gap-6">
				<div>
					<label class="block text-lg font-semibold mb-2" for="title">📝 제목</label>
					<input class="w-full px-4 py-3 border border-blue-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" name="title" id="title"
						autocomplete="off" type="text" placeholder="제목을 입력해주세요" />
				</div>
			</div>
			</div>

			<div class="mt-6">
				<label class="block text-lg font-semibold mb-2">🖋️ 내용</label>
				<div class="toast-ui-editor border border-blue-300 p-4 rounded-md"></div>
			</div>

			<div class="text-center mt-8 flex justify-between items-center">
				<!-- 왼쪽 정렬된 뒤로가기 버튼 -->
				<button class="text-blue-600 hover:underline font-semibold" type="button" onclick="history.back()">⬅️ 뒤로가기</button>

				<!-- 오른쪽 정렬된 공유하기 버튼 -->
				<button
					class="border border-blue-300 text-blue-600 font-bold py-3 px-8 rounded-md transition duration-300 ease-in-out hover:bg-blue-600 hover:text-white"
					type="submit">공유하기</button>
			</div>

		</form>


	</main>
	<%@ include file="../common/foot.jspf"%>