###(INIT 시작)
# DB 세팅
DROP DATABASE IF EXISTS `project_tripset`;
CREATE DATABASE `project_tripset`;
USE `project_tripset`;

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


##회원 테스트 데이터 생성
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
('2023-01-01 12:00:00', '2023-01-01 12:00:00', 'user1', 'password1', 3, '김민준', '민준', '010-1234-5678', 'user1@example.com', 0, NULL),
('2023-01-03 18:00:00', '2023-01-03 18:00:00', 'user2', 'password2', 3, '이서윤', '서윤', '010-2233-4455', 'user2@example.com', 0, NULL),
('2023-01-04 20:00:00', '2023-01-04 20:00:00', 'user3', 'password3', 3, '박지호', '지호', '010-3344-5566', 'user3@example.com', 1, '2023-01-05 14:00:00'),
('2023-01-05 10:00:00', '2023-01-05 10:00:00', 'user4', 'password4', 3, '정하린', '하린', '010-4455-6677', 'user4@example.com', 0, NULL);


#여행일정관리 테이블 생성
CREATE TABLE `TravelPlans` (
	`id` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`memberId` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`loginId` VARCHAR(255) NOT NULL	COMMENT '로그인아이디',
	`startDate` DATE NOT NULL COMMENT '여행시작날짜(사용자 설정)',
	`endDate` DATE NOT NULL	COMMENT '여행종료날짜(사용자 설정)',
	`regDate` DATETIME NOT NULL,
	`updateDate` DATETIME NOT NULL,
	`regionId` INT NOT NULL,
	`regionName` CHAR(20) NULL,
	`status` INT NULL DEFAULT 2 COMMENT '0=종료, 1=현재, 2=예정',
	`delStatus` TINYINT(1), UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부(0 = 삭제 안함, 1 = 삭제됨)',
	`delDate` DATETIME NULL	COMMENT '삭제날짜'
);

#일정상세항목관리 테이블 생성
CREATE TABLE `scheduleDetailsArticle` (
	`id` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`planId` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT	NOT NULL,
	`regionId` INT FOREIGN KEY NOT NULL,
	`location_address` CHAR	NOT NULL,
	`description` TEXT NOT NULL,
	`distance` INT NOT NULL	COMMENT '장소거리',
	`estimated_time` VARCHAR NOT NULL COMMENT '예상소요시간',
	`reservation_info` TEXT	NULL COMMENT '비행기, 숙박 등 예약정보(고민)',
	`regDate` DATETIME NOT NULL,
	`updateDate` DATETIME NOT NULL,
	`checklistId` INT FOREIGN KEY NOT NULL COMMENT '체크리스트 table ???????'
);


#체크리스트 테이블 생성
CREATE TABLE `checkList` (
	`id` UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	`memberId` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`planId` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`checklistItems` CHAR(100) NOT NULL,
	`isChecked` BOOLEAN NULL COMMENT '체크여부(0: 미체크, 1: 체크됨)'
);

#여행지추천 테이블 생성
CREATE TABLE `recommendedDestination` (
	`id` UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	`travelRecommendChecklistId` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`recommendationRegion`	CHAR(100) NOT NULL,
	`recommendationRegionId` INT NOT NULL,
	`regionInfo` TEXT NOT NULL COMMENT '지역에 관한 정보',
	`regionImageUrl` CHAR NOT NULL COMMENT '지역 이미지 png'
);

#여행추천체크리스트 테이블 생성
CREATE TABLE `travelRecommendChecklist` (
	`id` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`memberId` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT	NOT NULL,
	`TravelItemNumber` INT	NOT NULL COMMENT '항목별 번호',
	`isChecked` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'true = 체크, false= 미체크',
	`companion` INT	NOT NULL COMMENT '1 = 혼자, 2 = 연인, 3 = 친구, 4 = 가족',
	`recommendationRegionId`INT FOREIGN KEY	NOT NULL COMMENT '추천지역id',
	`travelPeriod`	INT NOT NULL COMMENT '1 = 당일치기,  2 = 1박 2일, 3 = 2박 3일, 4 = 3박 4일',
	`travelSchedule` INT NOT NULL COMMENT '1 = 1시간, 2 = 2시간, 3 = 널널',
	`travelStyle` CHAR NOT NULL
);

#날씨 테이블 생성
CREATE TABLE `weather` (
	`id` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`regDate` DATETIME NOT NULL,
	`updateDate` DATETIME NOT NULL,
	`date` DATE NOT NULL COMMENT '현재날짜',
	`temp`	INT NULL COMMENT '현재온도',
	`feels_like` INT NOT NULL COMMENT '체감온도',
	`nowWeatherId` INT NOT NULL COMMENT '현재날씨id',
	`nowWeather` CHAR NOT NULL COMMENT '현재날씨',
	`regionId` INT FOREIGN KEY	NOT NULL
);
#스타일링정보 테이블 생성
CREATE TABLE `stylingInfo` (
	`id` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`weatherId` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`stylingChecklistid` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`regDate` DATETIME NOT NULL,
	`updateDate` DATETIME NOT NULL,
	`productName` CHAR(100)	NOT NULL COMMENT '상품이름',
	`brand`	CHAR(50) NOT NULL COMMENT '상품브랜드',
	`clothesImageUrl` CHAR	NOT NULL COMMENT '이미지url',
	`regionId` INT foreginkey NOT NULL,
	`clothesKind` CHAR NOT NULL COMMENT '상의, 하의, 신발, 모자, 악세사리',
	`styleDescription` TEXT	NOT NULL COMMENT '스타일 설명'
);

#스타일링체크리스트 테이블 생성
CREATE TABLE `stylingChecklist` (
	`id` INT primarykey UNSIGNED AUTO_INCREMENT NOT NULL,
	`memberId` INT PRIMARY KEY UNSIGNED AUTO_INCREMENT NOT NULL,
	`StylingItemNumber` INT NOT NULL COMMENT '항목별 번호',
	`isChecked` BOOLEAN NOT NULL DEFAULT FALSE COMMENT 'true = 체크, false = 미체크',
	`gender` INT NOT NULL COMMENT '1 = 남자, 2 = 여자',
	`age` INT NOT NULL COMMENT '1 = 10대, 2 = 20대, 3 = 30대 , 4 = 40대',
	`clothesStyle` CHAR NOT NULL,
	`activity` CHAR NOT NULL,
	`stylingId` INT foreginkey NOT NULL,
	`regionId` INT foreginkey NOT NULL
);

ALTER TABLE `TravelPlans` ADD CONSTRAINT `PK_TRAVELPLANS` PRIMARY KEY (
	`id`
);

ALTER TABLE `scheduleDetailsArticle` ADD CONSTRAINT `PK_SCHEDULEDETAILSARTICLE` PRIMARY KEY (
	`id`
);

ALTER TABLE `member` ADD CONSTRAINT `PK_MEMBER` PRIMARY KEY (
	`id`
);

ALTER TABLE `checkList` ADD CONSTRAINT `PK_CHECKLIST` PRIMARY KEY (
	`id`
);

ALTER TABLE `recommendedDestination` ADD CONSTRAINT `PK_RECOMMENDEDDESTINATION` PRIMARY KEY (
	`id`
);

ALTER TABLE `travelRecommendChecklist` ADD CONSTRAINT `PK_TRAVELRECOMMENDCHECKLIST` PRIMARY KEY (
	`id`
);

ALTER TABLE `weather` ADD CONSTRAINT `PK_WEATHER` PRIMARY KEY (
	`id`
);

ALTER TABLE `stylingInfo` ADD CONSTRAINT `PK_STYLINGINFO` PRIMARY KEY (
	`id`
);

ALTER TABLE `stylingChecklist` ADD CONSTRAINT `PK_STYLINGCHECKLIST` PRIMARY KEY (
	`id`
);

ALTER TABLE `TravelPlans` ADD CONSTRAINT `FK_member_TO_TravelPlans_1` FOREIGN KEY (
	`memberId`
)
REFERENCES `member` (
	`id`
);

ALTER TABLE `scheduleDetailsArticle` ADD CONSTRAINT `FK_TravelPlans_TO_scheduleDetailsArticle_1` FOREIGN KEY (
	`planId`
)
REFERENCES `TravelPlans` (
	`id`
);

ALTER TABLE `checkList` ADD CONSTRAINT `FK_member_TO_checkList_1` FOREIGN KEY (
	`memberId`
)
REFERENCES `member` (
	`id`
);

ALTER TABLE `checkList` ADD CONSTRAINT `FK_TravelPlans_TO_checkList_1` FOREIGN KEY (
	`planId`
)
REFERENCES `TravelPlans` (
	`id`
);

ALTER TABLE `recommendedDestination` ADD CONSTRAINT `FK_travelRecommendChecklist_TO_recommendedDestination_1` FOREIGN KEY (
	`travelRecommendChecklistId`
)
REFERENCES `travelRecommendChecklist` (
	`id`
);

ALTER TABLE `travelRecommendChecklist` ADD CONSTRAINT `FK_member_TO_travelRecommendChecklist_1` FOREIGN KEY (
	`memberId`
)
REFERENCES `member` (
	`id`
);

ALTER TABLE `stylingInfo` ADD CONSTRAINT `FK_weather_TO_stylingInfo_1` FOREIGN KEY (
	`weatherId`
)
REFERENCES `weather` (
	`id`
);

ALTER TABLE `stylingInfo` ADD CONSTRAINT `FK_stylingChecklist_TO_stylingInfo_1` FOREIGN KEY (
	`stylingChecklistid`
)
REFERENCES `stylingChecklist` (
	`id`
);

ALTER TABLE `stylingChecklist` ADD CONSTRAINT `FK_member_TO_stylingChecklist_1` FOREIGN KEY (
	`memberId`
)
REFERENCES `member` (
	`id`
);


##(INIT 끝)
###########################################
SELECT * FROM `member`;

SELECT * 
FROM `member`
WHERE loginId = 'user1'
