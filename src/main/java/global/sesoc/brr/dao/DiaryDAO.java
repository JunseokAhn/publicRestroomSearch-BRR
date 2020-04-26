package global.sesoc.brr.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.DiaryMapper;
import global.sesoc.brr.vo.DateData;
import global.sesoc.brr.vo.TestDataVO;
import global.sesoc.brr.vo.resVO;

@Repository
public class DiaryDAO {
	@Autowired
	private SqlSession session;

	public boolean insert(resVO resVO) {
		DiaryMapper mapper = session.getMapper(DiaryMapper.class);
        
		int result = 0;
		
		try {
			result = mapper.insert(resVO);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		if(result>0) return true;
		return false;
	}

	public ArrayList<TestDataVO> GetTestResult(HashMap<String,Object> input)
	{
		ArrayList<TestDataVO> temp = null;
		try
		{
			DiaryMapper mapper = session.getMapper(DiaryMapper.class);
			temp = mapper.GetTestResult(input);			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}	
		
		return temp;
	}

	

}
