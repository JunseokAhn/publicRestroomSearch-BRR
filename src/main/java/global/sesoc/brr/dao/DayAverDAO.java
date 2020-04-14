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
	public ArrayList<DayAverVO> listAll() {
		ArrayList<DayAverVO> list = null;
		
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			list = mapper.listAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/*
	 * 해당 화장실의 이용 현황을 가지고 옴
	 * */
	public ArrayList<DayAverVO> getAver (String toiletnm) {
		ArrayList<DayAverVO> list = null;
		
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			list = mapper.getAver(toiletnm);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
}
