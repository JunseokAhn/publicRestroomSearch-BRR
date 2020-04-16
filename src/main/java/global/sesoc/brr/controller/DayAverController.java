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
@RequestMapping("/dayaver")
public class DayAverController {

	@Autowired
	private DayAverDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(DayAverController.class);
	
	//dayaver/searchedToilet?toiletTitle&id
	//화장실 길찾기를 실행 할 때에 저장
	@GetMapping(value = "/searchedToilet", produces = "applications/json;charset=UTF-8")
	@ResponseBody
	public String insertAver(String id, String toiletTitle, DayAverVO aver, HttpSession httpsession) {
		
		//jsp 쪽으로 넘어 갈 때 boolean 타입으로 들어감
		// 목요일 회의를 통해 값들을 어떻게 가지고 오느냐에 따라 달라지기 때문에 기본적인 틀만 가지고 만듬
		//VO객체 => aver.setId().equals((String)httpsession.getAttribute("sessionId"))
		if(id.equals((String)httpsession.getAttribute("sessionId"))) {
			
			dao.insertAver(aver);
			System.out.println("성공하였습니다.");
		} else {
		
			System.out.println("객체가 전달 되지 않았습니다.");
			return "false";
		}
		return "true";
	}
	
	
	
}
