package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.LocationVO;
import global.sesoc.brr.vo.NearbyToiletVO;
import global.sesoc.brr.vo.ToiletVO;

public interface GoogleMapsMapper {

	ArrayList<NearbyToiletVO> getNearbyToilet(LocationVO lo);

	NearbyToiletVO searchRating(LocationVO lo);

}
