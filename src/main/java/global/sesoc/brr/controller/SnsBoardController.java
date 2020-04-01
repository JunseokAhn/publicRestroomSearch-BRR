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
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.brr.dao.BoardDAO;
import global.sesoc.brr.dao.SnsBoardDAO;
import global.sesoc.brr.util.FileService;
import global.sesoc.brr.util.PageNavigator;
import global.sesoc.brr.vo.BoardVO;
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
		//String id = (String)session.getAttribute("loginId");
		String id = "haha";
		snsBoard.setId(id);
		
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
	
//****************여기부터는 내일 하기!!!!
//	//상세글 삭제
//	@GetMapping(value = "deleteBoard")
//	public String delete(HttpSession session, String boardnum) {
//		//String id = (String)session.getAttribute("loginId");
//		String id = "haha";
//		
//		BoardVO board = new BoardVO();
//		board.setBoardnum(boardnum);
//		board.setId(id);
//				
//		dao.deleteBoard(board);
//				
//		//* 주의: redirect를 해야 삭제한후 목록이 나옴
//		return "redirect:/board/listBoard"; 
//	}
//
//	//상세글 수정
//	@GetMapping(value = "updateBoard")
//	public String update(String boardnum, Model model) {
//		BoardVO board = dao.readBoard(boardnum);
//		model.addAttribute("board", board);
//		
//		return "board/updateForm";
//	}
//	//받는값 확인하기!!!
//	//set  title = ?  contents = ? where  boardnum = ?  and id = ?
//	//메모수정2
//	@RequestMapping(value = "updateBoard", method = RequestMethod.POST)
//	public String update(HttpSession session, BoardVO board) {
//		//String id = (String)session.getAttribute("loginId");
//		String id = "haha";
//		BoardVO exboard = dao.readBoard(board.getBoardnum());
//		if (exboard == null || !exboard.getId().equals(id)) {
//			return "redirect:/board/listBoard";
//		}
//		board.setId(id);
//		dao.updateBoard(board);
//				
//		return "redirect:/board/listBoard";
//	}
	
	
}
