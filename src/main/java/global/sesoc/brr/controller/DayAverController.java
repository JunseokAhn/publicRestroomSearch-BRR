package global.sesoc.brr.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.brr.dao.DayAverDAO;
import global.sesoc.brr.vo.DayAverVO;

@Controller
@RequestMapping("dayaver")
public class DayAverController {

	@Autowired
	private DayAverDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(DayAverController.class);
	
	//화장실 길찾기를 실행 할 때에 저장
	@GetMapping("/searchedToilet") //produces = "applications/json;charset=UTF-8")
	@ResponseBody
	public String insertAver(String id, DayAverVO aver, HttpSession httpsession) {
		
		System.out.println("경로를 통해 들어왔습니다.");
		System.out.println(id);
		System.out.println((String)httpsession.getAttribute("sessionId"));
		
//		if(id.equals((String)httpsession.getAttribute("sessionId"))) {
//			System.out.println("성공하였습니다.");
//			dao.insertAver(aver);
//		} else {
//			System.out.println("객체가 전달 되지 않았습니다.");
//			return "";
//		}
		System.out.println("그냥 때려박기");
		dao.insertAver(aver);
		return "";
	}
	
	@GetMapping("allUser")
	@ResponseBody
	public String alluser(Double lat, Double lng, HttpSession httpsession) {
		logger.info("일일 화장실 사용자 통계 입니다.");
		
		int result = dao.listAll(lat, lng);
		
		System.out.println("현재 일일 화장실 통계자 수 : " + result);
		
		httpsession.setAttribute("result", result);
		
		
		return "";
	}
	
	
	
	
}
