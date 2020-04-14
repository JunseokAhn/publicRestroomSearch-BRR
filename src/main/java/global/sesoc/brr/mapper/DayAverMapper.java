package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.DayAverVO;

public interface DayAverMapper {
	
	//길을 찾았을 때 해당 길찾기 내용 서버 저장
	public int insertAver (DayAverVO aver);
	
	//하루 이용한 사람들의 정보들을 서버에서 가지고 옴
	public ArrayList<DayAverVO> listAll ();
	
	//해당 화장실의 평균 이용량
	public ArrayList<DayAverVO> getAver (String toiletnm);
}
