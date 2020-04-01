package global.sesoc.brr.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.vo.LocationVO;
import global.sesoc.brr.vo.NearbyToiletVO;

@Repository
public class GoogleMapsDAO {

	@Autowired
	private SqlSession session;

	public ArrayList<NearbyToiletVO> getToilet(LocationVO lo) {
		// TODO Auto-generated method stub
		return null;
	}
}
