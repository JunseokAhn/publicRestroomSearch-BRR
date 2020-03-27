package global.sesoc.brr.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.brr.dao.ReplyDAO;
import global.sesoc.brr.vo.ReplyVO;


@Controller
@RequestMapping(value = "reply")
public class ReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);

	@Autowired
	private ReplyDAO dao;
	
	//댓글작성
	@ResponseBody //ResponsBody를 사용하여 JSON형태로 응답함	
	@RequestMapping(value = "insertReply", method = RequestMethod.POST)
	public void insertReply(ReplyVO reply, HttpSession session) {
		//String id = (String)session.getAttribute("loginId");
		String id = "haha";
		reply.setId(id);
		logger.info("전달된 객체1: {}", reply);
		dao.insertReply(reply);
	}
	
	//댓글목록
	@ResponseBody
	@GetMapping(value = "listReply")
	public ArrayList<ReplyVO> listReply() {
		ArrayList<ReplyVO> listReply = dao.listReply();
		return listReply;
	}
	
	//댓글삭제
	@ResponseBody
	@RequestMapping(value = "deleteReply", method = RequestMethod.POST)
	public String deleteReply(ReplyVO reply, HttpSession session) {
		//String id = (String)session.getAttribute("loginId");
		String id = "haha";
		reply.setId(id);
		logger.info("전달된 객체2: {}", reply);
		int cnt = dao.deleteReply(reply);
		//dao 수정해서 아래 문구가 뜨게 바꾸기! //위에 void도 String으로 바꾸기 한글로 jsp에 보내면 깨짐 영어로하기!		
		if (cnt == 1) {
			return "Success";
		} else {
			return "Fail";
		}
	}
	
	//댓글수정
	@ResponseBody
	@RequestMapping(value = "updateReply", method = RequestMethod.POST)
	public String updateReply(ReplyVO reply, HttpSession session) {
		//String id = (String)session.getAttribute("loginId");
		String id = "haha";
		reply.setId(id);
		logger.info("전달된 객체3: {}", reply);
		int cnt = dao.updateReply(reply);
		//dao 수정해서 아래 문구가 뜨게 바꾸기! //위에 void도 String으로 바꾸기 한글로 jsp에 보내면 깨짐 영어로하기!
		if (cnt == 1) {
			return "Success";
		} else {
			return "Fail";
		}		
	}

	
	
}
