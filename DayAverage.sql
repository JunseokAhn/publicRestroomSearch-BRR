CREATE table dayAver(
LAT     NUMBER,  -- 위도
LNG     NUMBER,  -- 경도
toiletnm   VARCHAR2(100), -- 화장실 이름
ID         VARCHAR2(100),
inputdate   date DEFAULT sysdate
);

commit;

drop table dayaver;