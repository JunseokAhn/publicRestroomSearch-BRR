package global.sesoc.brr.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.brr.dao.ReviewDAO;
import global.sesoc.brr.vo.ReviewVO;

@Controller
@RequestMapping(value = "review")
public class ReviewController {

	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	@Autowired
	ReviewDAO dao = new ReviewDAO();

	int intres;
	String stres;
	boolean res;

	// 리뷰리스트 > 전체목록
	@GetMapping(value = "reviewMain")
	public String list(String title) {
		// title로 리뷰검색
		return "review/reviewMain";
	}

	// 리뷰라이트
	@ResponseBody
	@PostMapping(value = "reviewWrite")
	public String write(ReviewVO VO) {
		logger.debug("리뷰write : " + VO.toString());
		res = dao.reviewWrite(VO);

		return "야, 넣을게";
	}
}
