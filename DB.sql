###(INIT 시작)
# DB 세팅
DROP DATABASE IF EXISTS `project_tripset`;
CREATE DATABASE `project_tripset`;
USE `project_tripset`;

# 게시글 테이블 생성
CREATE TABLE article(
      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      regDate DATETIME NOT NULL,
      updateDate DATETIME NOT NULL,
      title CHAR(100) NOT NULL,
      `body` TEXT NOT NULL,
      `region` CHAR(20) NOT NULL,
      memberId INT(10) UNSIGNED NOT NULL,
      hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0,
      goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0
);

## 게시글 테스트 데이터 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1',
region = '대전',
memberId = 2;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
region = '제주',
memberId = 2;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3',
region = '서울',
memberId = 3;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목4',
`body` = '내용4',
region = '포천',
memberId = 3;

#회원 테이블 생성
CREATE TABLE `member` (
	`id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	`regDate` DATETIME NOT NULL,
	`updateDate` DATETIME NOT NULL,
	`loginId` CHAR(30) NOT NULL,
	`loginPw` CHAR(100) NOT NULL,
	`authLevel` SMALLINT UNSIGNED NOT NULL DEFAULT 3 COMMENT '권한 레벨 (3=일반, 7=관리자)',
	`name` CHAR(20) NOT NULL,
	`nickname` CHAR(20) NOT NULL,
	`cellphoneNum` CHAR(20) NOT NULL,
	`email` CHAR(50) NOT NULL,
	`delStatus` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
	`delDate` DATETIME NULL COMMENT '탈퇴 날짜'
);

##회원 테이블 테스트 데이터 생성
##(관리자)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`authLevel` = 7,
`name` = '관리자',
nickname = '관리자',
cellphoneNum = '01012341234',
email = 'abc@gmail.com';

#(일반)
INSERT INTO `member` (
    `regDate`, `updateDate`, `loginId`, `loginPw`, `authLevel`, 
    `name`, `nickname`, `cellphoneNum`, `email`, `delStatus`, `delDate`
) VALUES
('2023-01-01 12:00:00', '2023-01-01 12:00:00', 'user123', 'password1', 3, '김민준', '민준', '010-1234-5678', 'user1@example.com', 0, NULL),
('2023-01-03 18:00:00', '2023-01-03 18:00:00', 'user234', 'password2', 3, '이서윤', '서윤', '010-2233-4455', 'user2@example.com', 0, NULL),
('2023-01-04 20:00:00', '2023-01-04 20:00:00', 'user345', 'password3', 3, '박지호', '지호', '010-3344-5566', 'user3@example.com', 1, '2023-01-05 14:00:00'),
('2023-01-05 10:00:00', '2023-01-05 10:00:00', 'user456', 'password4', 3, '정하린', '하린', '010-4455-6677', 'user4@example.com', 0, NULL);

#여행일정관리 테이블 생성
CREATE TABLE `travelPlans` (
	 `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	`memberId` INT UNSIGNED NOT NULL,
	`loginId` VARCHAR(255) NOT NULL	COMMENT '로그인아이디',
	`startDate` DATE NOT NULL COMMENT '여행시작날짜(사용자 설정)',
	`endDate` DATE NOT NULL	COMMENT '여행종료날짜(사용자 설정)',
	`regDate` DATETIME NOT NULL,
	`updateDate` DATETIME NOT NULL,
	`region` CHAR(20) NOT NULL,
	`status` INT NULL DEFAULT 2 COMMENT '0=종료, 1=현재, 2=예정',
	`delStatus` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부(0 = 삭제 안함, 1 = 삭제됨)',
	`delDate` DATETIME NULL	COMMENT '삭제날짜'
);

#여행일정 목적지 테이블 생성
CREATE TABLE `travelPlanPlaces`(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `travelPlanId` INT UNSIGNED,
    `placeName` VARCHAR(255),
    `regDate` DATETIME
);

# 여행일정관리 테이블 테스트 데이터 생성
INSERT INTO travelPlans (memberId, loginId, startDate, endDate, regDate, updateDate, region, STATUS, delStatus)
VALUES 
(2, 'user123', '2024-10-01', '2024-10-10', NOW(), NOW(), '서울', 2, 0),
(3, 'user234', '2024-11-01', '2024-11-15', NOW(), NOW(), '부산', 2, 0),
(4, 'user345', '2024-12-01', '2024-12-20', NOW(), NOW(), '제주', 2, 0),
(5, 'user456', '2024-12-21', '2024-12-30', NOW(), NOW(), '대구', 2, 0),
(2, 'user567', '2025-01-05', '2025-01-15', NOW(), NOW(), '인천', 2, 0),
(3, 'user678', '2025-02-10', '2025-02-20', NOW(), NOW(), '강릉', 2, 0),
(4, 'user789', '2025-03-15', '2025-03-25', NOW(), NOW(), '여수', 2, 0),
(5, 'user890', '2025-04-20', '2025-04-30', NOW(), NOW(), '전주', 2, 0),
(2, 'user901', '2025-05-05', '2025-05-15', NOW(), NOW(), '포항', 2, 0),
(3, 'user012', '2025-06-10', '2025-06-20', NOW(), NOW(), '울산', 2, 0);

# 여행일정 목적지 테이블 테스트 데이터 생성
INSERT INTO travelPlanPlaces (id, travelPlanId, placeName, regDate)
VALUES 
## 서울 관련 장소 (travelPlanId: 1)
(1, 1, '경복궁', NOW()),
(2, 1, '남산타워', NOW()),
(3, 1, '명동거리', NOW()),
(4, 1, '서울숲', NOW()),
(5, 1, '롯데월드타워', NOW()),
(6, 1, '동대문디자인플라자', NOW()),
(7, 1, '북촌한옥마을', NOW()),
(8, 1, '광화문', NOW()),
(9, 1, '청계천', NOW()),
(10, 1, '국립중앙박물관', NOW()),

## 부산 관련 장소 (travelPlanId: 2)
(11, 2, '해운대해수욕장', NOW()),
(12, 2, '광안대교', NOW()),
(13, 2, '자갈치시장', NOW()),
(14, 2, '태종대', NOW()),
(15, 2, '부산타워', NOW()),
(16, 2, '감천문화마을', NOW()),
(17, 2, '동백섬', NOW()),
(18, 2, '부산시립미술관', NOW()),
(19, 2, '송정해수욕장', NOW()),
(20, 2, '범어사', NOW()),

## 제주 관련 장소 (travelPlanId: 3)
(21, 3, '한라산', NOW()),
(22, 3, '성산일출봉', NOW()),
(23, 3, '협재해수욕장', NOW()),
(24, 3, '만장굴', NOW()),
(25, 3, '섭지코지', NOW()),
(26, 3, '우도', NOW()),
(27, 3, '주상절리대', NOW()),
(28, 3, '천지연폭포', NOW()),
(29, 3, '용두암', NOW()),
(30, 3, '에코랜드', NOW()),

## 대구 관련 장소 (travelPlanId: 4)
(31, 4, '동성로', NOW()),
(32, 4, '팔공산 케이블카', NOW()),
(33, 4, '이월드', NOW()),
(34, 4, '수성못', NOW()),
(35, 4, '서문시장', NOW()),
(36, 4, '국립대구박물관', NOW()),
(37, 4, '달성공원', NOW()),
(38, 4, '대구타워', NOW()),
(39, 4, '김광석 다시그리기길', NOW()),
(40, 4, '앞산공원', NOW()),

## 인천 관련 장소 (travelPlanId: 5)
(41, 5, '월미도', NOW()),
(42, 5, '차이나타운', NOW()),
(43, 5, '송도 센트럴파크', NOW()),
(44, 5, '인천대교', NOW()),
(45, 5, '인천상륙작전기념관', NOW()),
(46, 5, '소래포구', NOW()),
(47, 5, '영종도', NOW()),
(48, 5, '인천 국제공항', NOW()),
(49, 5, '강화도', NOW()),
(50, 5, '무의도', NOW()),

## 강릉 관련 장소 (travelPlanId: 6)
(51, 6, '경포대', NOW()),
(52, 6, '안목해변', NOW()),
(53, 6, '오죽헌', NOW()),
(54, 6, '정동진', NOW()),
(55, 6, '초당두부마을', NOW()),
(56, 6, '주문진', NOW()),
(57, 6, '솔향수목원', NOW()),
(58, 6, '선교장', NOW()),
(59, 6, '경포호', NOW()),
(60, 6, '대관령 양떼목장', NOW()),

##여수 관련 장소 (travelPlanId: 7)
(61, 7, '여수 엑스포공원', NOW()),
(62, 7, '오동도', NOW()),
(63, 7, '돌산대교', NOW()),
(64, 7, '여수해양공원', NOW()),
(65, 7, '해상케이블카', NOW()),
(66, 7, '거문도', NOW()),
(67, 7, '백야도', NOW()),
(68, 7, '여수수산시장', NOW()),
(69, 7, '향일암', NOW()),
(70, 7, '구봉산', NOW()),

##전주 관련 장소 (travelPlanId: 8)
(71, 8, '전주 한옥마을', NOW()),
(72, 8, '경기전', NOW()),
(73, 8, '전동성당', NOW()),
(74, 8, '남부시장', NOW()),
(75, 8, '오목대', NOW()),
(76, 8, '풍남문', NOW()),
(77, 8, '전주동물원', NOW()),
(78, 8, '덕진공원', NOW()),
(79, 8, '전주향교', NOW()),
(80, 8, '비빔밥거리', NOW()),

## 울산 관련 장소 (travelPlanId: 9)
(81, 9, '대왕암공원', NOW()),
(82, 9, '태화강 국가정원', NOW()),
(83, 9, '간절곶', NOW()),
(84, 9, '울산대교 전망대', NOW()),
(85, 9, '울산박물관', NOW()),
(86, 9, '울주대곡천암각화', NOW()),
(87, 9, '반구대', NOW()),
(88, 9, '울산 십리대숲', NOW()),
(89, 9, '정자항', NOW()),
(90, 9, '울산 대공원', NOW());



# reactionPoint 테이블 생성
CREATE TABLE reactionPoint(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `point` INT(10) NOT NULL
);

# reactionPoint 테스트 데이터 생성

# 1번 회원이 2번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 2,
`point` = 1;

# 3번 회원이 1번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`point` = 1;

# update join -> 기존 게시글의 good bad RP 값을 RP 테이블에서 추출해서 article table에 채운다
UPDATE article AS A
INNER JOIN (
    SELECT RP.relTypeCode, RP.relId,
    SUM(IF(RP.point > 0,RP.point,0)) AS goodReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint;

##(INIT 끝)
############################################################

#일정상세항목관리 테이블 생성
CREATE TABLE `scheduleDetailsArticle` (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    `planId` INT UNSIGNED NOT NULL,
    `regionId` INT NOT NULL,
    `location_address` CHAR(100) NOT NULL,
    `description` TEXT NOT NULL,
    `distance` INT NOT NULL COMMENT '장소 거리',
    `estimated_time` VARCHAR(50) NOT NULL COMMENT '예상 소요 시간',
    `reservation_info` TEXT NULL COMMENT '비행기, 숙박 등 예약 정보',
    `regDate` DATETIME NOT NULL,
    `updateDate` DATETIME NOT NULL,
    `checklistId` INT NOT NULL
);

#체크리스트 테이블 생성
CREATE TABLE `checkList` (
	 `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	`memberId` INT UNSIGNED NOT NULL,
	`planId` INT UNSIGNED NOT NULL,
	`checklistItems` CHAR(100) NOT NULL,
	`isChecked` BOOLEAN NULL COMMENT '체크여부(0: 미체크, 1: 체크됨)'
);

#스타일링체크리스트 테이블 생성
CREATE TABLE `stylingChecklist` (
	`id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
	`memberId` INT UNSIGNED NOT NULL,
	`StylingItemNumber` INT NOT NULL COMMENT '항목별 번호',
	`isChecked` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'true = 체크, false = 미체크',
	`gender` INT NOT NULL COMMENT '1 = 남자, 2 = 여자',
	`age` INT NOT NULL COMMENT '1 = 10대, 2 = 20대, 3 = 30대 , 4 = 40대',
	`clothesStyle` CHAR NOT NULL,
	`activity` CHAR NOT NULL,
	`stylingId` INT NOT NULL,
	`regionId` INT NOT NULL
);

###########################################
SELECT * FROM `member`;

SELECT * FROM `TravelPlans`;

SELECT *
FROM article
ORDER BY id DESC;

SELECT * FROM `reactionPoint`;

SELECT * FROM `travelPlanPlaces`;

###################################

SELECT IFNULL(SUM(RP.point),0)
FROM reactionPoint AS RP
WHERE RP.relTypeCode = 'article'
AND RP.relId = 3
AND RP.memberId = 2;

## 게시글 테스트 데이터 대량 생성
INSERT INTO article (
    regDate, updateDate, memberId, title, `body`, region
)
SELECT 
    NOW(), 
    NOW(), 
    FLOOR(RAND() * 4) + 1,
    CONCAT('제목__', ROUND(RAND() * 100000)),
    CONCAT('내용__', ROUND(RAND() * 100000)),
    ELT(FLOOR(1 + (RAND() * 17)), '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '경북', '경남', '전북', '전남', '제주') -- 무작위 지역 선택
FROM 
    article 
LIMIT 1000;
