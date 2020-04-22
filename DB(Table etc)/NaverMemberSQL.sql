--naver Member SQL문
CREATE table naverMember 
(id     VARCHAR2(50) PRIMARY KEY, --ID
email   VARCHAR2(50) not null, -- email
nickname VARCHAR2(50), --별명
gender  VARCHAR2(10) not NULL, -- 성별
birthday VARCHAR2(10) not null, -- 생일
age VARCHAR2(10) not NULL, -- 나이
profile_image VARCHAR2(1000) -- 프로필 이미지
);

commit;