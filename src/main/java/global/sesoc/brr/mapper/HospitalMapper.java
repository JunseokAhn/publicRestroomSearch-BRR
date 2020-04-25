package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.HospitalVO;

public interface HospitalMapper 
{
	int insertHospitalInfo(HospitalVO input);
	int countHospitalInfo();
	int deleteAllHospitalInfo();
	
	ArrayList<HospitalVO> GetNearHospitalList(HospitalVO input);
}
