CREATE TABLE brr_review(
    toiletNm varchar2(100),
    sessionId varchar2(100),
    sessionNickname varchar2(1000),
    Profile varchar2(1000),
    review varchar2(1000),
    star number,
    clean number,
    inputdate date default sysdate
);