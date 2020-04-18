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
import global.sesoc.brr.util.FileService;
import global.sesoc.brr.util.PageNavigator;
import global.sesoc.brr.vo.BoardVO;


@Controller
@RequestMapping(value = "review") // review로 바꾸기
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private BoardDAO dao;
	
//	@GetMapping(value = "boardMain")
//	public String boardMain() {
//		return "board/boardMain";
//	}
	
	//게시판 글쓰기폼 이동
	@GetMapping(value = "write")
	public String writeForm() {
		return "board/writeForm";
	}

	//게시글저장
	@RequestMapping (value="write", method = RequestMethod.POST)
	public String write(
			HttpSession session
			, Model model
			, BoardVO board 
			, MultipartFile upload) {
		
		//세션에서 로그인한 사용자의 아이디를 읽어서 Board객체의 작성자 정보에 세팅
		String id = (String)session.getAttribute("sessionId");
		board.setId(id);
		
		//첨부파일이 있는 경우 지정된 경로에 저장하고, 원본 파일명과 저장된 파일명을 Board객체에 세팅
//		if (!upload.isEmpty()) {
//			String savedfile = FileService.saveFile(upload, uploadPath);
//			board.setOriginalfile(upload.getOriginalFilename());
//			board.setSavedfile(savedfile);
//		}
		
		dao.insertBoard(board);
		return "redirect:/review/listBoard";
	}
	
	//전체 게시판 글목록
	@GetMapping(value = "listBoard")
	public String listBoard(Model model) {
		ArrayList<BoardVO> listBoard = dao.listBoard();
		model.addAttribute("list", listBoard);
		return "board/listBoard";
	}
	
	//상세 게시글 읽기
	@GetMapping(value = "readBoard")
	public String readBoard(String boardnum, Model model) {
		BoardVO board = dao.readBoard(boardnum);
		model.addAttribute("board", board);

		return "board/readBoard";
	}

	//상세글 삭제
	@GetMapping(value = "deleteBoard")
	public String delete(HttpSession session, String boardnum) {
		String id = (String)session.getAttribute("sessionId");
		
		BoardVO board = new BoardVO();
		board.setBoardnum(boardnum);
		board.setId(id);
				
		dao.deleteBoard(board);
				
		//* 주의: redirect를 해야 삭제한후 목록이 나옴
		return "redirect:/review/listBoard"; 
	}

	//상세글 수정
	@GetMapping(value = "updateBoard")
	public String update(String boardnum, Model model) {
		BoardVO board = dao.readBoard(boardnum);
		model.addAttribute("board", board);
		
		return "board/updateForm";
	}
	//받는값 확인하기!!!
	//set  title = ?  contents = ? where  boardnum = ?  and id = ?
	//메모수정2
	@RequestMapping(value = "updateBoard", method = RequestMethod.POST)
	public String update(HttpSession session, BoardVO board) {
		String id = (String)session.getAttribute("sessionId");
		BoardVO exboard = dao.readBoard(board.getBoardnum());
		if (exboard == null || !exboard.getId().equals(id)) {
			return "redirect:/review/listBoard";
		}
		board.setId(id);
		dao.updateBoard(board);
				
		return "redirect:/review/listBoard";
	}
	
	
}
