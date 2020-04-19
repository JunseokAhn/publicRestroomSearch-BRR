package global.sesoc.brr;

import java.util.Random;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.brr.dao.HospitalDAO;
import global.sesoc.brr.dao.ToiletDAO;



@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject    //서비스를 호출하기 위해서 의존성을 주입
    JavaMailSender mailSender;     //메일 서비스를 사용하기 위해 의존성을 주입함.    
	
	@Autowired
	private ToiletDAO toiletDAO;
	
	@Autowired
	private HospitalDAO hospitalDAO;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		logger.info("메인 화면으로 이동");
		return "/maps/mapsMain";
	}
	
	@RequestMapping(value = "/openFeedBackPopUp", method = RequestMethod.GET)
	public String openPopup() {
		return "/email/sendfeedback";
	}
	
	@ResponseBody
	@RequestMapping(value = "/checkRecv", method = RequestMethod.GET)
	public String CheckRecv() {
		logger.debug("이동하였다.");
		if(toiletDAO.countToiletInfo()>32000&&hospitalDAO.countHospitalInfo()>18600)
		{
			logger.debug("필요하지 않다.");
			return "do_not_need";
		}
		else
		{
			logger.debug("필요하다.");
			return "need";
		}		
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/checkAvailSend", method = RequestMethod.GET)
	public String SendFeedBack(HttpSession session) 
	{
		try
		{
			if(((String)session.getAttribute("sessionEmail")).equals(null))
			{
				logger.debug("실행상 불가능한 로직");
			}		
		}
		catch(Exception e)
		{
			return "error";
		}
		
		return "success";
	}
	
	@ResponseBody
	@RequestMapping(value = "/sendFeedBack", method = RequestMethod.POST)
	public String SendFeedBack(HttpSession session, String contentFromUser) 
	{
		String userEmail=(String)session.getAttribute("sessionEmail");		
		
        
        String setfrom = "ayo97080@gamil.com";
        String tomail = userEmail; // 받는 사람 이메일
        String title = userEmail+"님이 보내신 피드백입니다."; // 제목
        String content =
        		System.getProperty("line.separator")+ //한줄씩 줄간격을 두기위해 작성
                
                System.getProperty("line.separator")+
                        
                contentFromUser
                
                +System.getProperty("line.separator")+
                
                System.getProperty("line.separator");               
                
        
        try 
        {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message,
                    true, "UTF-8");

            messageHelper.setFrom(setfrom); // 보내는사람 생략하면 정상작동을 안함
            messageHelper.setTo(tomail); // 받는사람 이메일
            messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
            messageHelper.setText(content); // 메일 내용
            
            mailSender.send(message);            
        } 
        catch (Exception e) 
        {
            System.out.println(e);
        }        
		return "success";
	}
	
}
