<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>
<%@ include file="../popups/CheckMySchedulePopup.jspf"%>
<hr />

</head>
<style>
html, body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	background: #EFF6FF;
	overflow-y: auto;
}

.list-body {
	background: #FFFFFF;
}

.list-body:hover {
	background-color: #EFEFEF;
	transition: background-color 0.3s ease;
}

.Seoul:hover, .Busan:hover, .Daegu:hover, .Incheon:hover, .Gwangju:hover,
	.Daejeon:hover, .Ulsan:hover, .Sejong:hover, .Gyeonggi:hover, .Gangwon:hover,
	.Chungbuk:hover, .Chungnam:hover, .Jeonbuk:hover, .Jeonnam:hover,
	.Gyeongbuk:hover, .Gyeongnam:hover, .Jeju:hover {
	background-color: #EFEFEF;
	transition: background-color 0.3s ease;
}

.icon {
	color: black;
	transition: color 0.3s ease;
}

.icon:hover {
	color: #4D9FFF;
}
</style>
<body>
	<div class="container mx-auto p-6">
		<!-- 상단 타이틀 및 아이콘 -->
		<div class="flex justify-between items-center w-full mb-6">
			<div class="text-3xl font-bold text-black">일정 공유해요 📝</div>
			<a href="write" class="icon text-3xl">
				<i class="bi bi-pencil-square"></i>
			</a>
		</div>

		<!-- 지역 선택 영역 -->
		<div class="bg-white rounded-lg p-6 mb-8 shadow-lg">
			<div class="text-lg font-semibold text-black mb-4">지역</div>
			<div class="region grid grid-cols-4 sm:grid-cols-6 lg:grid-cols-9 gap-4">
				<button class="Seoul border border-gray-300 rounded-lg py-2 px-4 text-center">서울</button>
				<button class="Busan border border-gray-300 rounded-lg py-2 px-4 text-center">부산</button>
				<button class="Daegu border border-gray-300 rounded-lg py-2 px-4 text-center">대구</button>
				<button class="Incheon border border-gray-300 rounded-lg py-2 px-4 text-center">인천</button>
				<button class="Gwangju border border-gray-300 rounded-lg py-2 px-4 text-center">광주</button>
				<button class="Daejeon border border-gray-300 rounded-lg py-2 px-4 text-center">대전</button>
				<button class="Ulsan border border-gray-300 rounded-lg py-2 px-4 text-center">울산</button>
				<button class="Sejong border border-gray-300 rounded-lg py-2 px-4 text-center">세종</button>
				<button class="Gyeonggi border border-gray-300 rounded-lg py-2 px-4 text-center">경기</button>
				<button class="Gangwon border border-gray-300 rounded-lg py-2 px-4 text-center">강원</button>
				<button class="Chungbuk border border-gray-300 rounded-lg py-2 px-4 text-center">충북</button>
				<button class="Chungnam border border-gray-300 rounded-lg py-2 px-4 text-center">충남</button>
				<button class="Jeonbuk border border-gray-300 rounded-lg py-2 px-4 text-center">전북</button>
				<button class="Jeonnam border border-gray-300 rounded-lg py-2 px-4 text-center">전남</button>
				<button class="Gyeongbuk border border-gray-300 rounded-lg py-2 px-4 text-center">경북</button>
				<button class="Gyeongnam border border-gray-300 rounded-lg py-2 px-4 text-center">경남</button>
				<button class="Jeju border border-gray-300 rounded-lg py-2 px-4 text-center">제주</button>
			</div>
			<div class="flex justify-end mt-6">
				<button class="bg-blue-500 text-white py-2 px-6 rounded-lg hover:bg-blue-600 transition duration-300">선택</button>
			</div>
		</div>

		<!-- 게시글 총 개수, 최신수, 추천수 -->
		<div class="flex justify-between items-center mb-4">
			<span class="font-semibold text-black">총 개</span>
			<div class="flex space-x-4">
				<span class="font-semibold text-black">최신수</span>
				<span class="font-semibold text-black">추천수</span>
			</div>
		</div>

		<!-- 게시글 목록 테이블 -->
		<table class="table-auto w-full border-collapse mb-8 shadow-lg">
			<thead>
				<tr class="border-b-2 border-black bg-white">
					<th class="p-4 text-center">제목</th>
					<th class="p-4 text-center">지역</th>
					<th class="p-4 text-center">작성자</th>
					<th class="p-4 text-center">작성날짜</th>
					<th class="p-4 text-center">조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="article" items="${articles}">
					<tr class="list-body">
						<td class="p-4 text-center">
							<a class="hover:underline" href="detail?id=${article.id}">${article.title}
								<c:if test="${article.extra__repliesCount > 0 }">
									<span style="color: red;">[${article.extra__repliesCount }]</span>
								</c:if>
							</a>
						</td>
						<td class="p-4 text-center">${article.region}</td>
						<td class="p-4 text-center">${article.extra__writer}</td>
						<td class="p-4 text-center">${article.regDate.substring(0,10)}</td>
						<td class="p-4 text-center">${article.goodReactionPoint}</td>
					</tr>
				</c:forEach>

				<c:if test="${empty articles}">
					<tr class="bg-white p-4 border-t border-gray-200">
						<td colspan="5" class="text-center text-gray-500">게시글이 없습니다</td>
					</tr>
				</c:if>
			</tbody>
		</table>

		<!-- 동적 페이징 -->
		<div class="pagination flex justify-center mt-3">
			<c:set var="paginationLen" value="3" />
			<c:set var="startPage" value="${page - paginationLen >= 1 ? page - paginationLen : 1}" />
			<c:set var="endPage" value="${page + paginationLen <= pagesCount ? page + paginationLen : pagesCount}" />

			<c:set var="baseUri" value="?boardId=${boardId }" />
			<c:set var="baseUri" value="${baseUri }&searchKeywordTypeCode=${searchKeywordTypeCode}" />
			<c:set var="baseUri" value="${baseUri }&searchKeyword=${searchKeyword}" />

			<c:if test="${startPage > 1 }">
				<a class="btn btn-sm" href="${ baseUri}&page=1">1</a>
			</c:if>
			<c:if test="${startPage > 2 }">
				<button class="btn btn-sm btn-disabled">...</button>
			</c:if>

			<c:forEach begin="${startPage }" end="${endPage }" var="i">
				<a class="btn btn-sm ${param.page == i ? 'btn-active' : '' }" href="${ baseUri}&page=${i }">${i }</a>
			</c:forEach>

			<c:if test="${endPage < pagesCount - 1 }">
				<button class="btn btn-sm btn-disabled">...</button>
			</c:if>
			<c:if test="${endPage < pagesCount }">
				<a class="btn btn-sm" href="${ baseUri}&page=${pagesCount }">${pagesCount }</a>
			</c:if>
		</div>
	</div>
	<%@ include file="../common/foot.jspf"%>