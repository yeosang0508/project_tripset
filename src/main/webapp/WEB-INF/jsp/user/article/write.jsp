<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="WRITE"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<%@ include file="../popups/loginPopup.jspf"%>
<%@ include file="../popups/signUpPopup.jspf"%>
<hr />

<script type="text/javascript">
	function ArticleWrite__submit(form) {
		form.title.value = form.title.value.trim();

		if (form.title.value.length == 0) {
			alert('제목 써');
			return;
		}

		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();

		if (markdown.length == 0) {
			alert('내용 써');
			return;
		}
		
		$('#fileInput').attr('name', 'file__article__' + ${currentId} + '__extra__Img__1');

		form.body.value = markdown;
		form.submit();
	}
</script>


<section class="mt-24 text-xl px-4">
	<div class="mx-auto">
		<form onsubmit="ArticleWrite__submit(this); return false;" action="../article/doWrite" method="POST"
			enctype="multipart/form-data">
			<input type="hidden" name="body" />
			<input type="hidden" name=">${currentId }">

			<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
				<tbody>

					<tr>
						<th>게시판</th>
						<td style="text-align: center;">
							<select name="boardId">
								<option value="" selected disabled>게시판을 선택해주세요.</option>
								<option value="1">공지사항</option>
								<option value="2">자유</option>
								<option value="3">질의응답</option>
							</select>
						</td>

					</tr>

					<tr>
						<th>제목</th>
						<td style="text-align: center;">
							<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="title" autocomplete="off"
								type="text" placeholder="제목을 입력해" />
						</td>

					</tr>
					<tr>
						<th>내용</th>
						<td style="text-align: center;">
							<div class="toast-ui-editor">
								<script type="text/x-template"></script>
							</div>
						</td>

					</tr>
					<tr>
						<th></th>
						<td style="text-align: center;">
							<button class="btn btn-primary">작성</button>
						</td>

					</tr>
				</tbody>
			</table>
		</form>
		<div class="btns">
			<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>