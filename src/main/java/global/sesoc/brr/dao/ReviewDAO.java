package global.sesoc.brr.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.ReviewMapper;
import global.sesoc.brr.util.PageNavigator;
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
		return intres > 0;
	}

	public ArrayList<ReviewVO> reviewList(String toilet_title) {
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		ArrayList<ReviewVO> list = mapper.reviewList(toilet_title);
		return list;
	}

	public int reviewCount(String toiletTitle) {
		// TODO Auto-generated method stub
		int reviewCount;
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		if (toiletTitle.equals("")) {
			reviewCount = mapper.reviewCount(toiletTitle);
		} else {
			reviewCount = mapper.reviewCount2(toiletTitle);
		}
		System.out.println("검색된 리뷰의 수: " + reviewCount);
		return reviewCount;
	}
	
	public ArrayList<ReviewVO> reviewMain(String toiletTitle, int startRecord) {
		// TODO Auto-generated method stub
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		RowBounds RB = new RowBounds(startRecord, 7);
		ArrayList<ReviewVO> list;
		if (toiletTitle.equals("")) {
			list = mapper.reviewMain(RB, toiletTitle);
		} else {
			list = mapper.reviewMain2(RB, toiletTitle);
		}
		return list;
	}
}
