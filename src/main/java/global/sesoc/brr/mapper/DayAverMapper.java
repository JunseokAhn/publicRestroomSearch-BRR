package global.sesoc.brr.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import global.sesoc.brr.vo.DayAverVO;

public interface DayAverMapper {
	
	//길을 찾았을 때 해당 길찾기 내용 서버 저장
	public int insertAver (DayAverVO aver);
	
	//하루 이용한 사람들의 정보들을 서버에서 가지고 옴
	public Double listAll (@Param("lat")Double lat, @Param("lng")Double lng);
	
	//해당 회원의 검색 기록 삭제
	public int deleteRecord (String id);
	
	//7일 모든 이용자 수 데이터
	public int average (@Param("lat")Double lat, @Param("lng")Double lng);
	
	//변화량(최근 2일 데이터)
	public Double average2 (@Param("lat")Double lat, @Param("lng")Double lng);
	
	//변화량(예전 2일 데이터)
	public Double average3 (@Param("lat")Double lat, @Param("lng")Double lng);
	
	//최근 화장실 목록 3개
	public ArrayList<DayAverVO> Recent (String id);
	
	//선호하는 화장실 목록 
	public ArrayList<DayAverVO> Prefer (String id);
}
