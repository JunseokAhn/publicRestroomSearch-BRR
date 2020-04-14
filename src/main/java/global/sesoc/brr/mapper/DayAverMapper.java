package global.sesoc.brr.mapper;

import global.sesoc.brr.vo.DayAverVO;

public interface DayAverMapper {
	
	//길을 찾았을 때 해당 길찾기 내용 서버 저장
	public int insertAver (DayAverVO aver);
	
	
}
