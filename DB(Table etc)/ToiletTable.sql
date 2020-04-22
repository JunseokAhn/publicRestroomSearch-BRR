create table brr_toilet
(
    toiletNm varchar2(100), -- 화장실 이름
    toiletType varchar2(15), -- 화장실 타입 ( 개방 or 공중)
    lnmadr varchar2(150), -- 화장실 주소
    unisexToiletYn varchar(2), --남녀공용화장실 여부
    menToiletBowlNumber number, --남성용 대변기 수
    menUrineNumber number, -- 남성용-소변기수
    menHandicapToiletBowlNumber number, --남성용-장애인용대변기수
    menHandicapUrinalNumber number, --남성용-장애인용소변기수
    menChildrenToiletBowlNumber number, --남성용-어린이용대변기수
    menChildrenUrinalNumber number, --남성용-어린이용소변기수
    ladiesToiletBowlNumber number, --여성용-대변기수
    ladiesHandicapToiletBowlNumber number, --여성용-장애인용대변기수
    ladiesChildrenToiletBowlNumber number, --여성용-어린이용대변기수
    institutionNm varchar2(100),--관리기관명
    phoneNumber varchar2(50),--전화번호
    openTime varchar2(200), --개방시간
    lat number, --x좌표(위도)
    lng number --y좌표(경도)   
);