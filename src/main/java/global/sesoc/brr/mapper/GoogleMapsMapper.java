package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.LocationVO;
import global.sesoc.brr.vo.NearbyToiletVO;

public interface GoogleMapsMapper {

	ArrayList<NearbyToiletVO> getNearbyToilet(LocationVO lo);

}
