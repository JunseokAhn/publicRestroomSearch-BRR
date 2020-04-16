package global.sesoc.brr.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.NaverLoginMapper;
import global.sesoc.brr.vo.NaverVO;

@Repository
public class NaverLoginDAO {

	@Autowired
	private SqlSession session;
	
	//네이버에서 가지고 온 값들을 서버에 저장시킴
	public int insertNaver (NaverVO naver) {
		NaverLoginMapper mapper = session.getMapper(NaverLoginMapper.class);
			int result = 0;
		try {
			result = mapper.insertNaver(naver);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int getNaverMember (String id) {
		NaverLoginMapper mapper = session.getMapper(NaverLoginMapper.class);
		int result = 0;
		
		try {
			result = mapper.getNaverMember(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int deleteNaver (String id) {
		NaverLoginMapper mapper = session.getMapper(NaverLoginMapper.class);
		int result = 0;
		
		try {
			result = mapper.deleteNaver(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
}
