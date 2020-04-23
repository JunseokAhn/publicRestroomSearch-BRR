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

	public ArrayList<ReviewVO> reviewList(String toiletNm) {
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		ArrayList<ReviewVO> list = mapper.reviewList(toiletNm);
		return list;
	}

	public int reviewCount(String toiletNm) {
		// TODO Auto-generated method stub
		int reviewCount;
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		if (toiletNm.equals("")) {
			reviewCount = mapper.reviewCount(toiletNm);
		} else {
			reviewCount = mapper.reviewCount2(toiletNm);
		}
		System.out.println("검색된 리뷰의 수: " + reviewCount);
		return reviewCount;
	}
	
	public ArrayList<ReviewVO> reviewMain(String toiletNm, int startRecord) {
		// TODO Auto-generated method stub
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		RowBounds RB = new RowBounds(startRecord, 7);
		ArrayList<ReviewVO> list;
		System.out.println("이거 : " + toiletNm);
		if (toiletNm.equals("")) {
			list = mapper.reviewMain(RB, toiletNm);
		} else {
			list = mapper.reviewMain2(RB, toiletNm);
		}
		return list;
	}
}
