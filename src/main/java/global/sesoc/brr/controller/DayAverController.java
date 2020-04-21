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
		
		if(id.equals((String)httpsession.getAttribute("sessionId"))) {
			System.out.println("성공하였습니다.");
			dao.insertAver(aver);
		} else {
			System.out.println("객체가 전달 되지 않았습니다.");
			return "";
		}
		return "";
	}
	//해당 화장실의 전체 이용자 수
	@GetMapping("allUser")
	@ResponseBody
	public String alluser(Double lat, Double lng, HttpSession httpsession) {
		logger.info("화장실 사용자 통계 입니다.");
		
		int result = dao.listAll(lat, lng);
		
		System.out.println("현재 일일 화장실 통계자 수 : " + result);
		
		httpsession.setAttribute("userDiffer", result);
		
		return "";
	}
	
	//해당 아이디의 기록 삭제 입니다.
	@GetMapping("deleteRecord")
	@ResponseBody
	public String deleteRecord (String id, DayAverVO aver, HttpSession httpsession) {
		logger.info("검색 기록 삭제로 이동하였습니다.");
		if(aver.getId().equals((String)httpsession.getAttribute("sessionId"))) {
			System.out.println("검색 기록이 삭제 되었습니다.");
			dao.deleteRecord(id);
		}else {
			System.out.println("검색 기록 삭제 실패했습니다. 세션Scope아이디와 현재 아이디가 일치 하는지 확인해주세요.");
			return "false";
		}
		return "true";
	}
	
	@GetMapping("average")
	@ResponseBody
	public String average (Double lat, Double lng) {
		logger.info("7일 평균 계산 컨트롤러 이동");
		dao.getAver(lat, lng);
		//userAvg => 이용자 평균
		return"";
	}
	
	
	
}
