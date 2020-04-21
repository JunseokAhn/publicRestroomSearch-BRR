package global.sesoc.brr.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.DiaryMapper;
import global.sesoc.brr.vo.DateData;
import global.sesoc.brr.vo.resVO;

@Repository
public class DiaryDAO {
	@Autowired
	private SqlSession session;

	public int insert(resVO resVO) {
		DiaryMapper mapper = session.getMapper(DiaryMapper.class);
        
		int result = 0;
		
		try {
			result = mapper.insert(resVO);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<resVO> list(DateData dateData){
		DiaryMapper mapper = session.getMapper(DiaryMapper.class);
		ArrayList<resVO> list=mapper.list(dateData);
		return list;
	}

	

}
