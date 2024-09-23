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
      `region` CHAR(20) NOT NULL
);

## 게시글 테스트 데이터 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1',
region = '대전';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
region = '제주';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3',
region = '서울';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목4',
`body` = '내용4',
region = '포천';

ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

UPDATE article
SET memberId = 2
WHERE id IN (1,2);

UPDATE article
SET memberId = 3
WHERE id IN (3,4);


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
INSERT INTO `travelPlans` (`memberId`, `loginId`, `startDate`, `endDate`, `regDate`, `updateDate`, `region`, `status`, `delStatus`)
VALUES 
(1, 'user123', '2024-10-01', '2024-10-10', NOW(), NOW(), '서울', 2, 0),
(2, 'user234', '2024-11-01', '2024-11-15', NOW(), NOW(), '부산', 2, 0),
(3, 'user345', '2024-12-01', '2024-12-20', NOW(), NOW(), '제주', 2, 0),
(4, 'user456', '2024-12-21', '2024-12-30', NOW(), NOW(), '대구', 2, 0);


# 여행일정 목적지 테이블 테스트 데이터 생성
INSERT INTO `travelPlanPlaces` (`travelPlanId`, `placeName`, `regDate`)
VALUES 
(1, '경복궁', NOW()),
(1, '남산타워', NOW()),
(2, '해운대', NOW()),
(2, '광안리', NOW()),
(3, '한라산', NOW()),
(3, '섭지코지', NOW()),
(4, '동성로', NOW()),
(4, '팔공산', NOW());

# 게시판(board) 테이블 생성
CREATE TABLE board (
      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      regDate DATETIME NOT NULL,
      updateDate DATETIME NOT NULL,
      `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항) free(자유) QnA(질의응답) ...',
      `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
      delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
      delDate DATETIME COMMENT '삭제 날짜'
);

## 게시판(board) 테스트 데이터 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'NOTICE',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'FREE',
`name` = '자유';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'QnA',
`name` = '질의응답';

ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER `memberId`;

UPDATE article
SET boardId = 1
WHERE id IN (1,2);

UPDATE article
SET boardId = 2
WHERE id = 3;

UPDATE article
SET boardId = 3
WHERE id = 4;

ALTER TABLE article ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `body`;



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

# article 테이블에 reactionPoint(좋아요) 관련 컬럼 추가
ALTER TABLE article ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# update join -> 기존 게시글의 good bad RP 값을 RP 테이블에서 추출해서 article table에 채운다
UPDATE article AS A
INNER JOIN (
    SELECT RP.relTypeCode, Rp.relId,
    SUM(IF(RP.point > 0,RP.point,0)) AS goodReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode,Rp.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint


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
    `checklistId` INT NOT NULL,
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

SELECT * FROM board;


SELECT * FROM `reactionPoint`;

SELECT * FROM `travelPlanPlaces`;

###################################333

SELECT R.*, M.nickname AS extra__writer
			FROM reply AS R
			INNER JOIN `member` AS M
			ON R.memberId = M.id
			WHERE relTypeCode = 'article'
			AND relId = 2
			ORDER BY R.id ASC;

SELECT IFNULL(SUM(RP.point),0)
FROM reactionPoint AS RP
WHERE RP.relTypeCode = 'article'
AND RP.relId = 3
AND RP.memberId = 2


## 게시글 테스트 데이터 대량 생성
INSERT INTO article (
    regDate, updateDate, memberId, boardId, title, `body`, region
)
SELECT 
    NOW(), 
    NOW(), 
    FLOOR(RAND() * 4) + 1,
    FLOOR(RAND() * 3) + 1, 
    CONCAT('제목__', ROUND(RAND() * 100000)),
    CONCAT('내용__', ROUND(RAND() * 100000)),
    ELT(FLOOR(1 + (RAND() * 17)), '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '경북', '경남', '전북', '전남', '제주') -- 무작위 지역 선택
FROM 
    article 
LIMIT 1000; 