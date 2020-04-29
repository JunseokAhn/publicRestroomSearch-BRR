
create table diary_result(
    id varchar2(200),
    status number, -- 상태(스마일) 들고 오기  
    stress number, -- 스트레스도
    moisture number, -- 수분
    ingredient number, -- 영양분
    inputdate date default  to_date(to_char(sysdate,'yyyy/mm/dd')) -- 날짜       
);