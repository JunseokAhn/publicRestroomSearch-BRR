package global.sesoc.brr.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import global.sesoc.brr.vo.DateData;
import global.sesoc.brr.vo.TestDataVO;
import global.sesoc.brr.vo.resVO;

public interface DiaryMapper {

	int insert(resVO resVO);

	ArrayList<TestDataVO> GetTestResult(HashMap<String,Object> input);
	
	int countTest();

}
