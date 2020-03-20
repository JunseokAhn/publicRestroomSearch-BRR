package global.sesoc.brr.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.BoardMapper;
import global.sesoc.brr.vo.BoardVO;

@Repository
public class BoardDAO {

	@Autowired
	private SqlSession session;
	
	//게시판 글삽입
	public void insertBoard(BoardVO board) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		mapper.insertBoard(board);
	}
	//게시판 글목록
	public ArrayList<BoardVO> listBoard() {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		ArrayList<BoardVO> listBoard = mapper.listBoard();
		return listBoard;
	}
	//게시판 상세글
	public BoardVO readBoard(String boardnum) {
		BoardMapper mapper = session.getMapper(BoardMapper.class);
		BoardVO readBoard = mapper.readBoard(boardnum);
		return readBoard;
	}

	
	
}
