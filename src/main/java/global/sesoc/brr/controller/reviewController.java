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
@RequestMapping(value = "review")
public class reviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(reviewController.class);

	@Autowired
	private BoardDAO dao;
	
	//리뷰리스트 > 전체목록
	@GetMapping(value = "reviewMain")
	public String list(String title) {
		//title로 리뷰검색
		return "review/reviewMain";
	}

	//리뷰라이트
	//@GetMapping(value = "reviewWrite")
	//public String write() {
	//	return "review/reviewList";
	//}
}
