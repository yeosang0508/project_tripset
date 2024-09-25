<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../common/head.jspf"%>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>

<style>
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
}

#main-content {
    display: flex;
    justify-content: center;
    align-items: center;
    height: calc(100vh - 60px);
}

#container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 80vh;
    width: 90vw;
    box-sizing: border-box;
    background-color: #ffffff;
    box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
    border-radius: 15px;
    overflow: hidden;
}

#map-container {
    flex: 2;
    display: flex;
    justify-content: center;
    align-items: center;
}

#staticMap {
    width: 600px;
    height: 400px;
}

#sidebar {
    flex: 1;
    background-color: #f9f9f9;
    padding: 20px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 100%;
    border-left: 1px solid #ddd;
}

.date-picker-container {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px; /* 좌우 아이콘 간격 조절 */
    margin-bottom: 20px; /* 하단 여백 */
    width: 100%; /* 전체 넓이 차지 */
}

.date-picker {
    background-color: #ffffff;
    border-radius: 5px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    height: 40px;
    width: 200px; /* 입력창 넓이 조정 */
    display: flex;
    align-items: center;
    justify-content: center;
}

.date-picker input {
    width: 100%;
    height: 100%;
    padding: 0;
    border: none;
    border-radius: 5px;
    font-size: 14px;
    outline: none;
    text-align: center;
    background-color: inherit;
}

#travelPlanInfo {
    text-align: center; /* 텍스트 중앙 정렬 */
    margin-top: 20px; /* 상단 여백 */
}

#travelPlanInfo h3 {
    margin-bottom: 10px; /* 제목 하단 여백 */
}

#travelPlanInfo p {
    margin: 5px 0; /* 각 문단 간격 */
    font-size: 14px;
}
</style>

<body>
    <div id="main-content">
        <div id="container">
            <div id="map-container">
                <div id="staticMap"></div>
            </div>
            <div id="sidebar">
                <div class="date-picker-container">
                    <svg id="prevDay" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0"/>
                    </svg>
                    <div class="date-picker">
                        <div id="daterange">${travelPlan.startDate} - ${travelPlan.endDate}</div>
                    </div>
                    <svg id="nextDay" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708"/>
                    </svg>
                </div>
                <div id="travelPlanInfo">
                    <h3>여행 계획 상세 정보</h3>
                    <p><strong>여행지:</strong> 서울</p>
                    <p><strong>시작 날짜:</strong> 2024-10-01</p>
                    <p><strong>종료 날짜:</strong> 2024-10-10</p>
                    <p><strong>참여 인원:</strong> 3명</p>
                </div>
            </div>
        </div>
    </div>
    <script>
    var marker = {
        position: new kakao.maps.LatLng(33.450701, 126.570667), 
        text: '서울 여행'
    };

    var staticMapContainer  = document.getElementById('staticMap'),
        staticMapOption = { 
            center: new kakao.maps.LatLng(37.5665, 126.9780),
            level: 3,
            marker: marker
        };

    var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
    </script>
</body>
