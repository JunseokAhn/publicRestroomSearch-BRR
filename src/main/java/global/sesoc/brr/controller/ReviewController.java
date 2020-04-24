package global.sesoc.brr.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.brr.dao.ReviewDAO;
import global.sesoc.brr.util.PageNavigator;
import global.sesoc.brr.vo.ReviewAverVO;
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
	public String reviewMain(@RequestParam(defaultValue = "") String toiletNm,
			@RequestParam(defaultValue = "1") int currentPage, Model model) {
		// title로 리뷰검색
		System.out.println("검색어 : " + toiletNm);
		int reviewCount = dao.reviewCount(toiletNm);
		PageNavigator PN = new PageNavigator(7, currentPage, reviewCount);
		int startRecord = PN.getStartRecord();
		ArrayList<ReviewVO> list = dao.reviewMain(toiletNm, startRecord);
		model.addAttribute("list", list);
		model.addAttribute("search", toiletNm);
		model.addAttribute("pn", PN);
		System.out.println("리뷰게시판에 표시되는 내용");
		for (ReviewVO i : list)
			System.out.println(i);
		return "review/reviewMain";
	}

	// 리뷰라이트
	@ResponseBody
	@PostMapping(value = "reviewWrite")
	public String write(ReviewVO VO) {
		logger.debug("리뷰write : " + VO.toString());
		res = dao.reviewWrite(VO);

		return "";
	}

	// 최신리뷰 3개조회
	@ResponseBody
	@PostMapping(value = "reviewList")
	public ArrayList<ReviewVO> write(Double lng, Double lat) {
		logger.debug("리뷰list : {},{}", lng, lat);

		ArrayList<ReviewVO> list = dao.reviewList(lng, lat);
		return list;
	}

	@ResponseBody
	@PostMapping(value = "reviewAver")
	public ReviewAverVO reviewAver(Double lat, Double lng) {
		ReviewAverVO VO = dao.reviewAver(lat, lng);
		System.out.println(VO);
		return VO;
	}
}
