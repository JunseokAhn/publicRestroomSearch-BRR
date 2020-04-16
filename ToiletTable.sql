create table brr_Hospital
(
    dutyName varchar2(100),-- 병원이름
    dutyTel1 varchar2(100),-- 병원전화번호
    dutyAddr varchar2(300),-- 병원주소
    dutyTimeS varchar2(20), -- 여는 시간
    dutyTimeC varchar2(20), -- 닫는 시간
    dutyTimeSatS varchar2(20), --주말 여는 시간(토)
    dutyTimeSatC varchar2(20),-- 주말 닫는 시간 
    dutyTimeSunS varchar2(20), --주말 여는 시간(일)
    dutyTimeSunC varchar2(20),-- 주말 닫는 시간 
    lat number, -- 위도
    lng number -- 경도  
);