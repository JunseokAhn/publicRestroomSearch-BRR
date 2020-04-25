package global.sesoc.brr.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.HospitalMapper;
import global.sesoc.brr.vo.HospitalVO;

@Repository
public class HospitalDAO {

	@Autowired
	SqlSession session;
	
	public boolean insertHospitalInfo(HospitalVO input)
	{
		int result = 0;
		
		try
		{
			HospitalMapper mapper = session.getMapper(HospitalMapper.class);
			result = mapper.insertHospitalInfo(input);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		if(result>0)return true;
		else return false;
	}
	
	public int countHospitalInfo()
	{
		int result=0;
		
		try
		{
			HospitalMapper mapper = session.getMapper(HospitalMapper.class);
			result = mapper.countHospitalInfo();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean deleteAllHospitalInfo()
	{
		int result=0;
		
		try
		{
			HospitalMapper mapper = session.getMapper(HospitalMapper.class);
			result = mapper.deleteAllHospitalInfo();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		if(result>0) return true;
		
		return false;
	}
	
	public ArrayList<HospitalVO> GetNearHospitalList(double lat, double lng)
	{
		ArrayList<HospitalVO> temp=null;
		HospitalVO vo_temp=new HospitalVO();
		vo_temp.setLat(lat);
		vo_temp.setLng(lng);
		try
		{
			HospitalMapper mapper = session.getMapper(HospitalMapper.class);
			temp=mapper.GetNearHospitalList(vo_temp);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return temp;
	}
}
