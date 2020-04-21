CREATE TABLE brr_review(
    toilet_title varchar2(100),
    sessionId varchar2(100),
    nickname varchar2(100),
    sessionNickname varchar2(1000),
    Profile varchar2(1000),
    review varchar2(1000),
    star number,
    clean number,
    inputdate date default sysdate
);