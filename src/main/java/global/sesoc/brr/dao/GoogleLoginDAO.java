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
		GoogleLoginMapper mapper = session.getMapper(GoogleLoginMapper.class);
		int result = 0;
		result = mapper.insertGoogle(google);
		return result;
	}
	
	public int getGoogle (String id) {
		GoogleLoginMapper mapper = session.getMapper(GoogleLoginMapper.class);
		int result = 0;
		result = mapper.getGoogle(id);
		return result;
	}
	
	public int deleteGoogle (String id) {
		GoogleLoginMapper mapper = session.getMapper(GoogleLoginMapper.class);
		int result = 0;
		result = mapper.deleteGoogle(id);
		return result;
	}
	
}
