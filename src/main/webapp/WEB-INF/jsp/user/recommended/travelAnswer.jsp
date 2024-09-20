<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<%@ include file="../common/head.jspf"%>

</head>
<body>
<h2>여행 추천 결과</h2>
<div>
    <c:choose>
        <c:when test="${empty response}">
            <p>추천 결과가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="location" items="${response}">
                <p>
                    <strong>장소 이름:</strong> ${location.name} <br>
                    <strong>주소:</strong> ${location.address} <br>
                   
                </p>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
	
	<%@ include file="../common/foot.jspf"%>