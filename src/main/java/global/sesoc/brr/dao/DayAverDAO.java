package global.sesoc.brr.dao;

import java.util.ArrayList;

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
	public int listAll(Double lat, Double lng) {
		
		int result = -1;
		
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
	
	public int getAver (Double lat, Double lng) {
		int result = 0;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			result = mapper.getAver(lat, lng);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
