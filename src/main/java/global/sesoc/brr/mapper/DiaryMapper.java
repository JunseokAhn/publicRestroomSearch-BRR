package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.resVO;

public interface DiaryMapper {

	int insert(resVO res);

	ArrayList<resVO> list();

}
