package global.sesoc.brr.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.DayAverMapper;
import global.sesoc.brr.vo.DayAverVO;

@Repository
public class DayAverDAO {

	
	@Autowired
	
	private SqlSession session;
	
	public int insertAver (DayAverVO aver) {
		int result = -1;
		try {
			DayAverMapper mapper = session.getMapper(DayAverMapper.class);
			result = mapper.insertAver(aver);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	
}
