package global.sesoc.brr.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import global.sesoc.brr.dao.GoogleLoginDAO;
import global.sesoc.brr.dao.NaverLoginDAO;
import global.sesoc.brr.vo.GoogleLoginVO;

@Controller
public class delMemController {

	
	private static final Logger logger = LoggerFactory.getLogger(delMemController.class);
	
	@Autowired
	private NaverLoginDAO naverdao;
	@Autowired
	private GoogleLoginDAO googledao;
	
	@GetMapping("deleteGoogle")
	public String deleteGoogle () {
		logger.info("구글 회원 탈퇴로 이동");
		
		return "deleteGoogle";
	}
	
	@GetMapping("deleteNaver")
	public String deleteNaver () {
		logger.info("네이버 회원 탈퇴로 이동");
		return "deleteNaver";
	}
	
	@GetMapping("delNaver")
	public String delNaver (HttpSession httpsession) {
		String clientId = "z_lyTyQUbIC8kv8VfFwH";
		String clientSecret = "EdlvjsCOLs";
		String accessToken = (String)httpsession.getAttribute("access_token");
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=delete&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&access_token=" + accessToken;
		apiURL += "&service_provider=NAVER";
		
		naverdao.deleteNaver((String)httpsession.getAttribute("sessionId"));
		httpsession.removeAttribute("sessionId");
		
		RestTemplate restTemplate = new RestTemplate();
		String result = restTemplate.getForObject(apiURL, String.class);
		System.out.println(result);
		
		
		return "";
	}
	
//	@GetMapping("delGoogle")
//	public String delGoogle (HttpSession httpsession) {
//		
//	}
	
}
