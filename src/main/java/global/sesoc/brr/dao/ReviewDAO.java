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

	public ArrayList<ReviewVO> reviewMain(String toiletTitle, int currentPage) {
		// TODO Auto-generated method stub
		int reviewCount;
		ArrayList<ReviewVO> list;
		ReviewMapper mapper = session.getMapper(ReviewMapper.class);
		if (toiletTitle.equals("")) {
			reviewCount = mapper.reviewCount(toiletTitle);
		} else {
			reviewCount = mapper.reviewCount2(toiletTitle);
		}
		System.out.println("검색된 리뷰의 수: " + reviewCount);
		PageNavigator PN = new PageNavigator(7, currentPage, reviewCount);
		RowBounds RB = new RowBounds(PN.getStartRecord(), 7);
		if (toiletTitle.equals("")) {
			list = mapper.reviewMain(RB, toiletTitle);
		} else {
			list = mapper.reviewMain2(RB, toiletTitle);
		}
		return list;
	}
}
