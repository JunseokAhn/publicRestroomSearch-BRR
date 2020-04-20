--회원 정보 테이블
create table brr_member(
    id                  varchar2(50)        primary key --회원ID
    ,email              varchar2(100)       not null    --작성자email    
    ,nickname           varchar2(50)                    --별명
    ,gender             varchar2(10)        not null    --성별    
    ,birthday           varchar2(10)        not null    --생일
    ,age                varchar2(10)        not null    --나이
    ,profile_image      varchar2(1000)                  --프로필이미지
);

--게시판 본문 글 테이블
create table brr_board(
    boardnum        number              primary key         --글번호
    ,id             varchar2(50)        not null            --작성자ID
    ,email          varchar2(100)       not null            --작성자email    
    ,title          varchar2(200)       not null            --제목
    ,contents       varchar2(2000)      not null            --내용
    ,inputdate      date                default sysdate     --작성일
    ,originalfile   varchar2(200)                           --첨부파일 원래이름 // 별점 rate / number
    ,savedfile      varchar2(100)                           --첨부파일 저장된 이름 // 청결도 cleanness / number
);

--게시판 글 번호에 사용할 시퀀스
create sequence brr_board_seq;
commit;

--댓글 테이블
create table brr_reply (
	replynum		number		            primary key	        --댓글번호
	,boardnum	    number 		            not null		    --본문 글번호
	,id		        varchar2(50) 	        not null		    --작성자 ID
    ,email          varchar2(100)           not null            --작성자email
	,comments		varchar2(500) 	        not null		    --내용
	,inputdate		date 		            default sysdate	    --작성일
	,constraint replyBoard_fk foreign key(boardnum)
        references brr_board(boardnum) on delete cascade
);

--댓글 번호용 시퀀스
create sequence brr_reply_seq;
commit;


--정현씨 SQL문 참고
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