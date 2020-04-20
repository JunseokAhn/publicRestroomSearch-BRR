package global.sesoc.brr.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.brr.mapper.SnsReplyMapper;
import global.sesoc.brr.vo.SnsReplyVO;

@Repository//저장소(준비)
public class SnsReplyDAO {

	@Autowired //자동으로 객체를 생성해줌. Bean에 있는 SqlSession을 불러옴으로 이해 ex)CookieService cookieService = new CookieService();
	private SqlSession session;
	
	//sns리플삽입
	public void insertSnsReply(SnsReplyVO snsReply) {
		SnsReplyMapper mapper = session.getMapper(SnsReplyMapper.class);
		mapper.insertSnsReply(snsReply);
	}
	//sns리플목록
	public ArrayList<SnsReplyVO> listSnsReply(String snsBoardnum) {
		SnsReplyMapper mapper = session.getMapper(SnsReplyMapper.class);
		ArrayList<SnsReplyVO> listSnsReply = mapper.listSnsReply(snsBoardnum);
		return listSnsReply;
	}
	//sns리플삭제
	public int deleteSnsReply(SnsReplyVO snsReply) {
		SnsReplyMapper mapper = session.getMapper(SnsReplyMapper.class);
		int cnt = mapper.deleteSnsReply(snsReply);
		return cnt;
	}
	//sns리플수정
	public int updateSnsReply(SnsReplyVO snsReply) {
		SnsReplyMapper mapper = session.getMapper(SnsReplyMapper.class);
		int cnt = mapper.updateSnsReply(snsReply);
		return cnt;
	}
	
}
