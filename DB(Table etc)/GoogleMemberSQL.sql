CREATE table googlemember 
(id     VARCHAR2(100) PRIMARY key,
email   VARCHAR2(50) not null,
name    VARCHAR2(50) not null,
picture     VARCHAR2(1000),
gender  VARCHAR2(10),
age     VARCHAR2(10)
);

commit;