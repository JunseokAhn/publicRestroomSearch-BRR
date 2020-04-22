
create table diary_result(
resNum number PRIMARY key,
status VARCHAR2(10),
inputdate date default sysdate,
resvalue varchar2(10)

)

create sequence diary_result_seq;