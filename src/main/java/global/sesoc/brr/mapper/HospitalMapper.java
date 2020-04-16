package global.sesoc.brr.mapper;

import global.sesoc.brr.vo.HospitalVO;

public interface HospitalMapper 
{
	int insertHospitalInfo(HospitalVO input);
	int countHospitalInfo();
	int deleteAllHospitalInfo();
}
