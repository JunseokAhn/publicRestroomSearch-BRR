package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.LocationVO;
import global.sesoc.brr.vo.NearbyToiletVO;
import global.sesoc.brr.vo.ReviewVO;

public interface ReviewMapper {

	ArrayList<NearbyToiletVO> getNearbyToilet(LocationVO lo);

	int reviewWrite(ReviewVO vO);

	ArrayList<ReviewVO> reviewList(String toilet_title);

}
