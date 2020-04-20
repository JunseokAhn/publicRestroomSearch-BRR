CREATE TABLE brr_review(
    toilet_title varchar2(100),
    sessionId varchar2(100),
    nickname varchar2(100),
    picktureUrl varchar2(1000),
    profile_image varchar2(1000),
    review varchar2(1000),
    star number,
    clean number,
    inpudate date default sysdate
);