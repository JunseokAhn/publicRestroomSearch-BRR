package global.sesoc.brr.controller;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

import global.sesoc.brr.dao.GoogleLoginDAO;
import global.sesoc.brr.vo.GoogleVO;

@Controller
public class GoogleLoginController {

	@Autowired
	private GoogleLoginDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(GoogleLoginController.class);
	
	@GetMapping("googlelogin")
	public String goGoogle () {
		
		logger.info("구글 로그인으로 이동하였습니다.");
		
		return "googlelogin";
	}
	
	//google은 반드시 throws 처리를 해주어야 한다.(GeneralSecurityException, IOException)
	@ResponseBody
	@PostMapping("callbackTestGoo")
	public String GoogleCallback(HttpServletRequest httpServletRequest, GoogleVO google, HttpSession httpsession) throws GeneralSecurityException, IOException {
		
		logger.info("콜백 페이지로 이동하였습니다.");
		
		//신호 객체(?)
		NetHttpTransport transport = new NetHttpTransport();
		//JSON객체를 받아오는 역할
		JacksonFactory jacksonFactory = new JacksonFactory();
		
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(transport, jacksonFactory)
			    // Specify the CLIENT_ID of the app that accesses the backend:
			    .setAudience(Collections.singletonList("1008960346250-33jebt3kge8r04ac3dh0fqoamfidshjs.apps.googleusercontent.com"))
			    // Or, if multiple clients access the backend:
			    //.setAudience(Arrays.asList(CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3))
			    .build();

			// (Receive idTokenString by HTTPS POST)

		 String idTokenString = httpServletRequest.getParameter("idtoken");
			GoogleIdToken idToken = verifier.verify(idTokenString);
			if (idToken != null) {
			  Payload payload = idToken.getPayload();

			  // Print user identifier
			  String userId = payload.getSubject();
			  System.out.println("User ID: " + userId);

			  // Get profile information from payload
			  String email = payload.getEmail();
			  boolean emailVerified = Boolean.valueOf(payload.getEmailVerified());
			  String name = (String) payload.get("name");
			  String pictureUrl = (String) payload.get("picture");
			  String locale = (String) payload.get("locale");
			  String familyName = (String) payload.get("family_name");
			  String givenName = (String) payload.get("given_name");

			  // Use or store profile information
			  // ...
			  
			  logger.debug(userId);
			  logger.debug(email);
			  logger.debug(name);
			  logger.debug(pictureUrl);
			  logger.debug(locale);
			  logger.debug(familyName);
			  logger.debug(givenName);
			 
			 google.setId(userId);
			 google.setEmail(email);
			 google.setName(name);
			 google.setPicture(pictureUrl);
			 
//			 int result = dao.getGoogle(userId);
			 
//			 if(result == 0) {
				 dao.insertGoogle(google);
//			 }
			 
			 httpsession.setAttribute("sessionId", userId);
			 httpsession.setAttribute("sessionName", name);
			 
			} else {
			  System.out.println("Invalid ID token.");
			}
		
		return "";
	}
	
	
	
	
}
