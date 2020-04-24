package global.sesoc.brr.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.condition.ProducesRequestCondition;

import global.sesoc.brr.dao.SnsReplyDAO;
import global.sesoc.brr.vo.ReplyVO;
import global.sesoc.brr.vo.SnsReplyVO;
import lombok.Value;


@Controller
@RequestMapping(value = "snsReply")
public class SnsReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(SnsReplyController.class);

	@Autowired
	private SnsReplyDAO dao;
	
	//sns댓글작성
	@ResponseBody
	@RequestMapping(value = "insertSnsReply", method = RequestMethod.POST)
	public void insertSnsReply(SnsReplyVO snsReply, HttpSession session) {
		String id = (String)session.getAttribute("sessionId");
		snsReply.setId(id);
		logger.info("전달된 객체1: {}", snsReply);
		dao.insertSnsReply(snsReply);
	}
	
	//sns댓글목록
	@ResponseBody
	@RequestMapping(value = "listSnsReply", method = RequestMethod.GET)
	public ArrayList<SnsReplyVO> listSnsReply(String snsBoardnum) {
		ArrayList<SnsReplyVO> listSnsReply = dao.listSnsReply(snsBoardnum);
		return listSnsReply;
	}
	
	//sns댓글삭제
	//한글깨짐방지(produces="text/plain;charset=UTF-8")
	@ResponseBody
	@RequestMapping(value = "deleteSnsReply", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public String deleteSnsReply(SnsReplyVO snsReply, HttpSession session) {
		String id = (String)session.getAttribute("sessionId");
		snsReply.setId(id);
		logger.info("전달된 객체2: {}", snsReply);
		int cnt = dao.deleteSnsReply(snsReply);
		
		if(cnt == 1) {
			return "삭제 성공";
		}else {
			return "삭제 실패";
		}
	}

	//sns댓글수정
	@ResponseBody
	@RequestMapping(value = "updateSnsReply", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public String updateSnsReply(SnsReplyVO snsReply, HttpSession session) {
		String id = (String)session.getAttribute("sessionId");
		snsReply.setId(id);
		logger.info("전달된 객채3: {}", snsReply);
		int cnt = dao.updateSnsReply(snsReply);
		
		if (cnt == 1) {
			return "업데이트 성공";
		}else {
			return "업데이트 실패";
		}
	}

	
}
