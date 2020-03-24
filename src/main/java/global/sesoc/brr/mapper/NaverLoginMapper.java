package global.sesoc.brr.mapper;

import global.sesoc.brr.vo.NaverVO;

public interface NaverLoginMapper {

	
	//네이버 회원 정보 JSON객체를 DB에 저장
	public int insertNaver (NaverVO naver);
	
	//저장된 회원 정보를 Session에다가 저장시키기 위한 select문
	public int getNaverMember (String id);
}
