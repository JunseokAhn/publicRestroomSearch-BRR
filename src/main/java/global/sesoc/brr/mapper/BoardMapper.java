package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.BoardVO;

public interface BoardMapper {
	
	//게시판 글삽입
	public void insertBoard(BoardVO board);
	//게시판 글목록
	public ArrayList<BoardVO> listBoard();
	//게시판 상세글
	public BoardVO readBoard(String boardnum);
	//글삭제
	public void deleteBoard(BoardVO board);
	//글수정
	public void updateBoard(BoardVO board);
	
}
