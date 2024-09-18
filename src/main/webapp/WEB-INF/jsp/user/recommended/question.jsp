<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Question</title>
</head>
<body>
    <h2>질문을 입력하세요:</h2>
    <form action="${pageContext.request.contextPath}/usr/recommended/ask" method="GET">
        <label for="question">질문:</label>
        <input type="text" id="question" name="question" required />
        <button type="submit">제출</button>
    </form>
</body>
</html>