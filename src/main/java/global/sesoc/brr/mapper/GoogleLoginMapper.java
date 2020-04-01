package global.sesoc.brr.mapper;

import global.sesoc.brr.vo.GoogleLoginVO;

public interface GoogleLoginMapper {

	public int insertGoogle (GoogleLoginVO google);
	
	public int getGoogle(String id);
	
	
}
