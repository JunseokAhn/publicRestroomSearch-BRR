package global.sesoc.brr.mapper;

import global.sesoc.brr.vo.NaverVO;

public interface NaverLoginMapper {

	
	//네이버 회원 정보 JSON객체를 DB에 저장
	public int insertNaver (NaverVO naver);
	
}
