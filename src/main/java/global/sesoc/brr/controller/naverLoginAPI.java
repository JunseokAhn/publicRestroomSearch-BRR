package global.sesoc.brr.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import global.sesoc.brr.dao.NaverLoginDAO;
import global.sesoc.brr.vo.NaverVO;


@Controller
public class naverLoginAPI {

	
	@Autowired
	private NaverLoginDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(naverLoginAPI.class);
	
	@GetMapping("naverlogin")
	public String naverlogin() {
		
		//token값은 1시간마다 (3600ms) 새로 갱신 된다
		logger.info("로그인으로 이동하였습니다.");
		return "naverlogin";
	}
	
	@GetMapping("/callback")
	public String callback (HttpSession httpsession) {
		logger.info("콜백 하였습니다.");
//		logger.debug(vo.toString());
		

		return "callback";
	}
	
	@GetMapping("viewForm")
	@ResponseBody
	public String viewForm (String access_token)throws Exception {
		System.out.println(access_token);
        String token = access_token;// 네이버 로그인 접근 토큰; 여기에 복사한 토큰값을 넣어줍니다.
        String header = "Bearer " + token; // Bearer 다음에 공백 추가
        String result = null;
        
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
            result = response.toString();
            System.out.println(response.toString());
            JsonParser js = new JsonParser();
            JsonElement elment = js.parse(result);
            
            String id = elment.getAsJsonObject().get("id").toString();
            System.out.println(id);
            
//            JsonElement element = parser.parse(result);
//            
//            
//            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
//            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
//            
//            String idnum = element.getAsJsonObject().get("id").toString();
//            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
//            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            
            
            
            NaverVO naver = new NaverVO();
            
            naver.setId(result);
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        
        
        
        
	return result;
	}
	
	
}
