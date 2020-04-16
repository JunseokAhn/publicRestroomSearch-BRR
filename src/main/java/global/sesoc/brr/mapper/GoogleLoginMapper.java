package global.sesoc.brr.mapper;

import global.sesoc.brr.vo.GoogleLoginVO;

public interface GoogleLoginMapper {

	//구글 회원정보 서버에 입력
	public int insertGoogle (GoogleLoginVO google);
	//구글 회원정보 session에 입력
	public int getGoogle(String id);
	//구글 회원 탈퇴
	public int deleteGoogle (String id);
}
