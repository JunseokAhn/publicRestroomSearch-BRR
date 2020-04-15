package global.sesoc.brr.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.ToiletMapper;
import global.sesoc.brr.vo.ToiletVO;

@Repository
public class ToiletDAO 
{
	@Autowired
	SqlSession session;	
	
	public boolean insertToiletInfo(ToiletVO input)
	{
		int result = 0;
		
		try
		{
			ToiletMapper mapper = session.getMapper(ToiletMapper.class);
			result = mapper.insertToiletInfo(input);			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		if(result>0) return true;
		return false;
	}
	
	public int countToiletInfo()
	{
		int size=0;
		try
		{			
			ToiletMapper mapper = session.getMapper(ToiletMapper.class);
			size = mapper.countToiletInfo();			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return size;		
	}
	
	public boolean deleteAllToiletInfo()
	{
		int result = 0;		
		try
		{
			ToiletMapper mapper = session.getMapper(ToiletMapper.class);
			result = mapper.deleteAllToiletInfo();			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		if(result>0) return true;
		return false;
	}
}
