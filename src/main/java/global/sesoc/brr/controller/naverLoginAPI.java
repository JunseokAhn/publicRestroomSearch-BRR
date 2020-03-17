package global.sesoc.brr.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import global.sesoc.brr.vo.NaverVO;


@Controller
public class naverLoginAPI {

	
	private static final Logger logger = LoggerFactory.getLogger(naverLoginAPI.class);
	
	@GetMapping("naverlogin")
	public String naverlogin() {
		//token값은 1시간마다 (3600ms)마다 새로 갱신 된다
		logger.info("로그인으로 이동하였습니다.");
		return "naverlogin";
	}
	
	@GetMapping("/callback")
	public String callback (NaverVO vo, HttpSession httpsession) {
		logger.info("콜백 하였습니다.");
//		logger.debug(vo.toString());
		
		return "callback";
	}
	
	@GetMapping("viewForm")
	public String viewForm (HttpServletRequest request)throws Exception {
        String token = "AAAAO17ycInNA1B7jEoy8R_DBMkqJZClOhsmupziUnSnqBp9mZFaCYrUe41AEG9zMPFvx8Hec7g6p-hL1by5ekMhOwI";// 네이버 로그인 접근 토큰; 여기에 복사한 토큰값을 넣어줍니다.
        String header = "Bearer " + token; // Bearer 다음에 공백 추가
        try {
            String apiURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", header);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
        } catch (Exception e) {
            System.out.println(e);
        }
	return "viewForm";
	}
	
	
}
