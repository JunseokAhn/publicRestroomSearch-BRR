package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.ReplyVO;

public interface ReplyMapper {
	
	//리플삽입 
	public void insertReply(ReplyVO reply);
		
	//리플목록
	public ArrayList<ReplyVO> listReply();
	
	//리플삭제
	public int deleteReply(ReplyVO reply);
	
	//리플수정
	public int updateReply(ReplyVO reply);

}
