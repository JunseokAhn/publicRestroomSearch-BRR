-- 디스턴스 함수 사용예제
select * from (
select toiletNm, toiletType, lat, lng
    , trunc(DISTANCE_WGS84(34.969373,127.578384, lat, lng),3)*1000 as DISTANCE
from brr_toilet
where (lat between 34.969373-0.019 and 34.969373+0.019)
    and (lng between 127.578384-0.022 and 127.578384+0.022)
order by DISTANCE) TMP where rownum < (select count(*)from brr_toilet);




-- radians = degrees / (180 / pi)
-- RETURN nDegrees / (180 / ACOS(-1));  -- but 180/pi is a constant, so...
CREATE OR REPLACE FUNCTION RADIANS(nDegrees IN NUMBER) RETURN NUMBER DETERMINISTIC IS
BEGIN  
  RETURN nDegrees / 57.29577951308232087679815481410517033235;
END RADIANS;


CREATE OR REPLACE FUNCTION DISTANCE_WGS84( H_LAT in number, H_LNG in number, T_LAT in number, T_LNG in number)
RETURN NUMBER DETERMINISTIC
IS
BEGIN
  RETURN ( 6371.0 * acos( 
          cos( radians( H_LAT ) )*cos( radians( T_LAT /* 위도 */ ) )
          *cos( radians( T_LNG /* 경도 */ )-radians( H_LNG ) )
          +
          sin( radians( H_LAT ) )*sin( radians( T_LAT /* 위도 */ ) )       
         ));
end DISTANCE_WGS84;




