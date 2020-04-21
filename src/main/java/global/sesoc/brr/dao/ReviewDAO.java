package global.sesoc.brr.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.ReviewMapper;
import global.sesoc.brr.vo.ReviewVO;

@Repository
public class ReviewDAO {

	@Autowired
	SqlSession session;
	
	int intres;
	String stres;
	boolean res;
	
	public boolean reviewWrite(ReviewVO VO) {
		// TODO Auto-generated method stub
		
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		intres = mapper.reviewWrite(VO);
		return intres>0;
	}

	public ArrayList<ReviewVO> reviewList(String toilet_title) {
		// TODO Auto-generated method stub
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		ArrayList<ReviewVO> list = mapper.reviewList(toilet_title);
		return list;
	}
}
