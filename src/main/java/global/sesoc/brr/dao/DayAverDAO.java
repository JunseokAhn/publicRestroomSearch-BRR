package global.sesoc.brr.dao;


import java.util.ArrayList;
import java.util.Map;

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
	
	//7일동안의 해당 화장실의 총 이용횟수
	public int average (Double lat, Double lng) {
		int result = -1;
		
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			result = mapper.average(lat, lng);	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//최근 2일 동안의 해당 화장실의 총 이용횟수
	public Double average2 (Double lat, Double lng) {
		Double result = 0.0;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			result = mapper.average2(lat, lng);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//예전 2일 동안의 해당 화장실의 총 이용횟수
	public Double average3 (Double lat, Double lng) {
		Double result = 0.0;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			result = mapper.average3(lat, lng);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//최근 이용했던 화장실 
	public ArrayList<DayAverVO> Recent (String id) {
		ArrayList<DayAverVO> list = null;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			list = mapper.Recent(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//가장 선호하는 화장실
	public ArrayList<DayAverVO> Prefer (String id) {
		ArrayList<DayAverVO> list = null;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			list = mapper.Prefer(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//선호하는 화장실 방문 횟수
	public ArrayList<DayAverVO> Prefer2 (String id) {
		ArrayList<DayAverVO> list = null;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			list = mapper.Prefer2(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
