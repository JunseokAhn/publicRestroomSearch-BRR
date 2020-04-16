package global.sesoc.brr.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.GoogleLoginMapper;

import global.sesoc.brr.vo.GoogleLoginVO;

@Repository
public class GoogleLoginDAO {

	@Autowired
	private SqlSession session;
	
	
	public int insertGoogle (GoogleLoginVO google) {
		int result = -1;
		try {
			GoogleLoginMapper mapper = session.getMapper(GoogleLoginMapper.class);
			result = mapper.insertGoogle(google);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int getGoogle (String id) {
		int result = -1;
		try {
			GoogleLoginMapper mapper = session.getMapper(GoogleLoginMapper.class);
			result = mapper.getGoogle(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int deleteGoogle (String id) {
		int result = -1;
		try {
			GoogleLoginMapper mapper = session.getMapper(GoogleLoginMapper.class);
			result = mapper.deleteGoogle(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
