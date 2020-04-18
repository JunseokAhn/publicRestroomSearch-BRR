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
		//VO객체 => aver.setId().equals((String)httpsession.getAttribute("sessionId"))
		if(id.equals((String)httpsession.getAttribute("sessionId"))) {
			
		//ajax통신으로 받아올 자료들 => 경도, 위도, 화장실 이름, 아이디.
			System.out.println("성공하였습니다.");
			dao.insertAver(aver);
			
		} else {
		
			System.out.println("객체가 전달 되지 않았습니다.");
			return "";
		}
		return "";
	}
	
//	@GetMapping("allUser")
//	public String alluser(HttpSession httpsession)
}
