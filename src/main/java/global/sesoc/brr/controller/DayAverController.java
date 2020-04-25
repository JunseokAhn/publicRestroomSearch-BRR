package global.sesoc.brr.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
		
		if(id == null || id == "") {
			System.out.println("비회원이 경로 조회");
			
			System.out.println(aver.toString());
			
			dao.insertAver(aver);
			
		} else {
			System.out.println("회원이 경로 조회");
			System.out.println(aver.toString());
			
			dao.insertAver(aver);
		}
		
		return "";
	}
	
	//해당 아이디의 기록 삭제 입니다.
	@GetMapping("/deleteRecord")
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
	
	@PostMapping("/average")
	@ResponseBody
	public DayAverVO average (Double lat, Double lng, HttpSession httpsession) {
		logger.info("7일 동안 총 이용횟수, 변화량 계산");
		
		DayAverVO aver = new DayAverVO();
		
		int result = dao.average(lat, lng); // 7일 총 횟수
		Double recent2 = dao.average2(lat, lng); // 최근 2일 이용 횟수
		Double recent3 = dao.average3(lat, lng); //전의 2일 이용 횟수
		
//		if(result == 0 || recent3 == 0) {
			System.out.println("7일 총 이용자수 : " + result);
			System.out.println("최근 2일 이용자 수 평균 : " + recent2);
			System.out.println("5일 이용자 수 평균: " + recent3);
			
			httpsession.setAttribute("user7Days", result);
			httpsession.setAttribute("user2Days", recent2);
			httpsession.setAttribute("user4Days", recent3);
			
			
			//recent2 => 2일 평균 이용자 수
			//recent3 => 5일 평균 이용자 수
			Double UserDiffer = (recent2 - recent3) * 2;
			
			if(Double.isInfinite(UserDiffer) || Double.isNaN(UserDiffer)) {
				System.out.println("UserDiffer를 999로 처리.");
				UserDiffer = 999.0;
			}
			
			System.out.println("변화량 : " + UserDiffer);
			
			httpsession.setAttribute("userDiffer", UserDiffer);
			
			aver.setAverage(result); // 7일간 총 이용횟수
			aver.setDiffer(UserDiffer); // 변화량
//		} else {
//		}
		return aver;
		
	}
	
	@GetMapping("recent")
	@ResponseBody
	public DayAverVO Recent (String id, HttpSession httpsession) {
		DayAverVO aver = new DayAverVO();
		aver.setId((String)httpsession.getAttribute("sessionId"));
		System.out.println(aver.getId());
		if(aver.getId().equals((String)httpsession.getAttribute("sessionId"))) {
		dao.Recent(id);
		}else {
			System.out.println("아이디가 일치하지 않습니다.");
		}
		return aver;
	}
	
}
