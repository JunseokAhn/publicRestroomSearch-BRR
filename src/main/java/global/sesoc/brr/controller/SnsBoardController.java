package global.sesoc.brr.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.brr.dao.BoardDAO;
import global.sesoc.brr.dao.SnsBoardDAO;
import global.sesoc.brr.util.FileService;
import global.sesoc.brr.util.PageNavigator;
import global.sesoc.brr.vo.SnsBoardVO;


@Controller
@RequestMapping(value = "sns")
public class SnsBoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(SnsBoardController.class);

	@Autowired
	private SnsBoardDAO dao;
	
	//sns게시판 글쓰기폼으로 이동
	//@RequestMapping(value = "snsWrite", method = RequestMethod.GET)
	@GetMapping(value = "snsWrite")
	public String snsWriteForm() {
		return "board/snsWriteForm";
	}
	
	//sns게시판 글저장
	@RequestMapping(value = "snsWrite", method = RequestMethod.POST)
	public String snsWrite(HttpSession session, SnsBoardVO snsBoard) {
		logger.info("전달된 객체 글저장: {}", snsBoard);
		dao.insertSNS(snsBoard);
		return "redirect:/sns/listSNS";
	}
	
	//sns게시판 글목록(무한스크롤형태)
	@RequestMapping(value = "listSNS", method = RequestMethod.GET)
	public String listSNS(Model model) {
		ArrayList<SnsBoardVO> listSNS = dao.listSNS();
		logger.info("전달된 객체list: {}", listSNS);
		
		model.addAttribute("listSNS", listSNS);
		return "board/listSNS";
	}
	
	//sns게시판 상세글
	@GetMapping(value = "readSNS")
	public String readSNS(String snsBoardnum, Model model) {
		SnsBoardVO snsBoard = dao.readSNS(snsBoardnum);
		logger.info("전달된 객체 상세글: {}", snsBoard);
		model.addAttribute("snsBoard", snsBoard);
		return "board/readSNS";
	}
	
	//sns상세글 삭제
	@RequestMapping(value = "deleteSNS", method = RequestMethod.GET)
	public String deleteSNS(String snsBoardnum, HttpSession session) {
		String id = (String)session.getAttribute("sessionId");
		SnsBoardVO snsBoard = new SnsBoardVO();
		snsBoard.setSnsBoardnum(snsBoardnum);
		snsBoard.setId(id);
		
		dao.deleteSNS(snsBoard);
		logger.info("전달된 객체 삭제: {}", snsBoard);
		return "redirect:/sns/listSNS";
	}

	//sns상세글 수정
	@RequestMapping(value = "updateSNS", method = RequestMethod.GET)
	public String update(String snsBoardnum, Model model) {
		SnsBoardVO snsBoard = dao.readSNS(snsBoardnum);
		logger.info("전달된 객체 수정1: {}", snsBoard);
		model.addAttribute("snsBoard", snsBoard);
		
		return "board/snsUpdateForm";
	}

	//받는값 확인하기!!!
	//set  title = ?  contents = ? where  boardnum = ?  and id = ?
	//sns상세글 수정2
	@RequestMapping(value = "updateSNS", method = RequestMethod.POST)
	public String update(SnsBoardVO snsBoard, HttpSession session) {
		String id = (String)session.getAttribute("sessionId");
		SnsBoardVO exboard = dao.readSNS(snsBoard.getSnsBoardnum());
		logger.info("전달된 객체 수정2: {}", snsBoard);
		
		if (exboard == null || !exboard.getId().equals(id)) {
			return "redirect:/sns/listSNS";
		}
		snsBoard.setId(id);
		dao.updateSNS(snsBoard);
		
		return "redirect:/sns/listSNS";
	}
	
}
