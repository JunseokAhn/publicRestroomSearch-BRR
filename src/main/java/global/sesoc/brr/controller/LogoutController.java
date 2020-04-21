package global.sesoc.brr.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import global.sesoc.brr.controller.LogoutController;

@Controller
@RequestMapping("member")
public class LogoutController {

private static final Logger logger = LoggerFactory.getLogger(LogoutController.class);
	
	
	@GetMapping("logout")
	public String logOut (HttpSession httpsession) {
		logger.info("로그아웃 페이지로 이동하였습니다.");
		String clientId = "z_lyTyQUbIC8kv8VfFwH";
		String clientSecret = "EdlvjsCOLs";
		String accessToken = (String)httpsession.getAttribute("access_token");
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=delete&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&access_token=" + accessToken;
		apiURL += "&service_provider=NAVER";
		
		
		RestTemplate restTemplate = new RestTemplate();
		String result = restTemplate.getForObject(apiURL, String.class);
		System.out.println(result);
		
		httpsession.invalidate();
		
		return "member/logoutForm";
	}
	
	
}
