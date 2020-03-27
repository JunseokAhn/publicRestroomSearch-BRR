package global.sesoc.brr.mapper;

import global.sesoc.brr.vo.ToiletVO;

public interface ToiletMapper {
	
	//화장실 정보 삽입
	int insertToiletInfo(ToiletVO input);
	//테이블 크기 확인
	int countToiletInfo();
}
