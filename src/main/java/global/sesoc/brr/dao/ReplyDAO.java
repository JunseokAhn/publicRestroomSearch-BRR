package global.sesoc.brr.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.ReplyMapper;
import global.sesoc.brr.vo.ReplyVO;

@Repository
public class ReplyDAO {
	
	@Autowired
	private SqlSession session;
	
		//리플삽입 
	public void insertReply(ReplyVO reply) {
		ReplyMapper mapper = session.getMapper(ReplyMapper.class);
		mapper.insertReply(reply);
	}
		
	//리플목록
	public ArrayList<ReplyVO> listReply(String boardnum) {
		ReplyMapper mapper = session.getMapper(ReplyMapper.class);
		ArrayList<ReplyVO> listReply = mapper.listReply(boardnum);
		return listReply;
	}
	
	//리플삭제
	public int deleteReply(ReplyVO reply) {
		ReplyMapper mapper = session.getMapper(ReplyMapper.class);
		int cnt = mapper.deleteReply(reply);
		return cnt;
	}
	
	//리플수정
	public int updateReply(ReplyVO reply) {
		ReplyMapper mapper = session.getMapper(ReplyMapper.class);
		int cnt = mapper.updateReply(reply);
		return cnt;
	}


}
