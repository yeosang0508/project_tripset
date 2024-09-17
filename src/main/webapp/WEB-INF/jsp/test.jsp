<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Flask Response</title>
</head>
<body>

<h2>Response from Flask Server</h2>

<!-- Flask 서버에서 가져온 응답 출력 -->
<p>Response: ${test1}</p>

<!-- 실패 여부에 따라 다른 메시지 출력 -->
<c:if test="${fail}">
    <p style="color:red;">Failed to get response from Flask server.</p>
</c:if>

</body>
</html>