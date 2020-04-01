package global.sesoc.brr.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import global.sesoc.brr.mapper.SnsBoardMapper;

import global.sesoc.brr.vo.SnsBoardVO;

@Repository
public class SnsBoardDAO {
	
	@Autowired
	private SqlSession session;

	//sns게시판 글삽입
	public void insertSNS(SnsBoardVO snsBoard) {
		SnsBoardMapper mapper = session.getMapper(SnsBoardMapper.class);
		mapper.insertSNS(snsBoard);
	}
	
	//sns게시판 글목록
	public ArrayList<SnsBoardVO> listSNS() {
		SnsBoardMapper mapper = session.getMapper(SnsBoardMapper.class);
		ArrayList<SnsBoardVO> listSNS = mapper.listSNS();
		return listSNS;
	}
	
	//sns게시판 상세글
	public SnsBoardVO readSNS(String snsBoardnum) {
		SnsBoardMapper mapper = session.getMapper(SnsBoardMapper.class);
		SnsBoardVO readSNS = mapper.readSNS(snsBoardnum);
		return readSNS;
	}
	
	//sns게시판 삭제
	public void deleteSNS(SnsBoardVO snsBoard) {
		SnsBoardMapper mapper = session.getMapper(SnsBoardMapper.class);
		mapper.deleteSNS(snsBoard);
	}
	
	//sns게시판 수정
	public void updateSNS(SnsBoardVO snsBoard) {
		SnsBoardMapper mapper = session.getMapper(SnsBoardMapper.class);
		mapper.updateSNS(snsBoard);
	}
	
}
