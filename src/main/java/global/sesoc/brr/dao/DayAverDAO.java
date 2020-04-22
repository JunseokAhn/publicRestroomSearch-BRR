package global.sesoc.brr.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.DayAverMapper;
import global.sesoc.brr.vo.DayAverVO;

@Repository
public class DayAverDAO {

	
	@Autowired
	private SqlSession session;
	
	
	/*
	 * 길찾기 결과를 DB에 저장
	 * */
	public int insertAver (DayAverVO aver) {
		int result = -1;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			result = mapper.insertAver(aver);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/*
	 * 모든 이용자 결과를 가지고 옴
	 * */
	public Double listAll(Double lat, Double lng) {
		
		Double result = 0.0;
		
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			result = mapper.listAll(lat, lng);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/*
	 * 검색기록 삭제
	 * */
	
	public int deleteRecord (String id) {
		int result = -1;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			result = mapper.deleteRecord(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public Double average (Double lat, Double lng) {
		Double result = 0.0;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			result = mapper.average(lat, lng);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
