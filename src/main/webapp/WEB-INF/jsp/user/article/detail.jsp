<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>

<hr />

<!-- 변수 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}');
	
	console.log(params);
	console.log(params.id);
	console.log(params.memberId);

	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
</script>

<!-- 조회수 -->
<script>
	function ArticleDetail__doIncreaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyOnView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);

		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			console.log(data);
			console.log(data.data1);
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json')
	}

	$(function() {
		setTimeout(ArticleDetail__doIncreaseHitCount, 2000);
	})
</script>

<!-- 좋아요 -->
<script>
	function checkRP() {
		if (isAlreadyAddGoodRp) {
			$('#likeButton').toggleClass('btn-outline');
		}
	}

	function doGoodReaction(articleId) {
		if (isNaN(params.memberId)) {
		    if (confirm('로그인 창을 여시겠습니까?')) {
		        // 로그인 팝업을 열기 위한 클래스 제거
		        document.querySelector('.login-popup').classList.remove('hidden');
		        document.querySelector('.popup-bg').classList.remove('hidden');
		    }
		    return; 
		}


		$.ajax({
			url: '/usr/reactionPoint/doGoodReaction',
			type: 'POST',
			data: { relTypeCode: 'article', relId: articleId },
			dataType: 'json',
			success: function(data) {
				console.log(data);
				if (data.resultCode.startsWith('S-')) {
					$('#likeButton').toggleClass('btn-outline');
					$('#likeCount').text(data.data1);
					$('.likeCount').text(data.data1);
				} else {
					alert(data.msg);
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert('좋아요 오류 발생: ' + textStatus);
			}
		});
	}

	

	$(function() {
		checkRP();
	});
</script>

<section class="mt-24 text-xl px-4">
	<div class="mx-auto">
		<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
			<tbody>
				<tr>
					<th style="text-align: center;">ID</th>
					<td style="text-align: center;">${article.id}</td>
				</tr>
				<tr>
					<th style="text-align: center;">지역</th>
					<td style="text-align: center;">${article.region}</td>
				</tr>
				<tr>
					<th style="text-align: center;">작성날짜</th>
					<td style="text-align: center;">${article.updateDate}</td>
				</tr>
				<tr>
					<th style="text-align: center;">작성자</th>
					<td style="text-align: center;">${article.extra__writer}</td>
				</tr>
				<tr>
					<th class="reaction" style="text-align: center;">Like</th>
					<td id="likeCount" style="text-align: center;">${article.goodReactionPoint}</td>
				</tr>
				<tr>
					<th style="text-align: center;">LIKE</th>
					<td style="text-align: center;">
						<button id="likeButton" class="btn btn-outline btn-success" onclick="doGoodReaction(${param.id})">
							👍 LIKE
							<span class="likeCount">${article.goodReactionPoint}</span>
						</button>
					</td>
				</tr>
				<tr>
					<th style="text-align: center;">Views</th>
					<td style="text-align: center;">
						<span class="article-detail__hit-count">${article.hitCount}</span>
					</td>
				</tr>
				<tr>
					<th style="text-align: center;">Title</th>
					<td style="text-align: center;">${article.title}</td>
				</tr>
				<tr>
					<th style="text-align: center;">Body</th>
					<td>
						<div class="toast-ui-viewer">
							<script type="text/x-template">${article.body}</script>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btns">
			<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
			<c:if test="${article.userCanModify}">
				<a class="btn" href="../article/modify?id=${article.id}">수정</a>
			</c:if>
			<c:if test="${article.userCanDelete}">
				<a class="btn" href="../article/doDelete?id=${article.id}">삭제</a>
			</c:if>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>
