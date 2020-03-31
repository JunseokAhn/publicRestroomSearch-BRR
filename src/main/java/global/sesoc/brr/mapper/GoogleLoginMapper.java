package global.sesoc.brr.mapper;

import global.sesoc.brr.vo.GoogleVO;

public interface GoogleLoginMapper {

	public int insertGoogle (GoogleVO google);
	
	public int getGoogle(String id);
	
	
}
