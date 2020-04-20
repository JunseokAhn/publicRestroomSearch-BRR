package global.sesoc.brr.mapper;

import java.util.ArrayList;

import global.sesoc.brr.vo.SnsReplyVO;

public interface SnsReplyMapper {
	
	//sns리플삽입
	public void insertSnsReply(SnsReplyVO snsReply);
	//sns리플목록
	public ArrayList<SnsReplyVO> listSnsReply(String snsBoardnum);
	//sns리플삭제
	public int deleteSnsReply(SnsReplyVO snsReply);
	//sns리플수정
	public int updateSnsReply(SnsReplyVO snsReply);
	
}
