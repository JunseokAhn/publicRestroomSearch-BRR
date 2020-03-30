package global.sesoc.brr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping(value="api")
@Controller
public class DairyController {

	@RequestMapping(value = "/dairy", method = RequestMethod.GET)
	public String apidairy() {
		return "api/dairy";
	}
	
	
	@RequestMapping(value = "/dairy2", method = RequestMethod.GET)
	public String apidairy2() {
		return "api/dairy2";
	}
	
	
}
