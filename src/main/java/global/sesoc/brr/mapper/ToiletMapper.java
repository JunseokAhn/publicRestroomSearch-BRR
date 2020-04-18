package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.LocationVO;
import global.sesoc.brr.vo.NearbyToiletVO;
import global.sesoc.brr.vo.ToiletVO;

public interface ToiletMapper {
	
	//화장실 정보 삽입
	int insertToiletInfo(ToiletVO input);
	//테이블 크기 확인
	int countToiletInfo();
	//테이플 속성 전체 삭제
	int deleteAllToiletInfo();	
	
	ArrayList<NearbyToiletVO> GetToiletInfoByDistance(LocationVO input);
}
