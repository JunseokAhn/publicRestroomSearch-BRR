package global.sesoc.brr.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.brr.vo.LocationVO;
import global.sesoc.brr.vo.NearbyToiletVO;
import global.sesoc.brr.vo.ReviewAverVO;
import global.sesoc.brr.vo.ReviewVO;

public interface ReviewMapper {

	ArrayList<NearbyToiletVO> getNearbyToilet(LocationVO lo);

	int reviewWrite(ReviewVO vO);

	ArrayList<ReviewVO> reviewList(String toilet_title);

	int reviewCount(String title);

	int reviewCount2(String title);
	
	ArrayList<ReviewVO> reviewMain(RowBounds rB, String title);

	ArrayList<ReviewVO> reviewMain2(RowBounds rB, String title);
	
	ReviewAverVO reivewAver(HashMap<String, Double> map);


}
