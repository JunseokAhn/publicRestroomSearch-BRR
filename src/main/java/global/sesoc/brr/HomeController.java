package global.sesoc.brr;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.brr.dao.HospitalDAO;
import global.sesoc.brr.dao.ToiletDAO;



@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private ToiletDAO toiletDAO;
	
	@Autowired
	private HospitalDAO hospitalDAO;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		logger.info("메인 화면으로 이동");
		return "/maps/mapsMain";
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
	
}
