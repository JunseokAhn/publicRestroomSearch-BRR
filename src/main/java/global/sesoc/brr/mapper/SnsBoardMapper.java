package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.SnsBoardVO;

public interface SnsBoardMapper {
	
	//sns게시판 글삽입
	public void insertSNS(SnsBoardVO snsBoard);
	//sns게시판 글목록
	public ArrayList<SnsBoardVO> listSNS();
	//sns게시판 상세글
	public SnsBoardVO readSNS(String snsBoardnum);
	//sns게시판 삭제
	public void deleteSNS(SnsBoardVO snsBoard);
	//sns게시판 수정
	public void updateSNS(SnsBoardVO snsBoard);
	
}
