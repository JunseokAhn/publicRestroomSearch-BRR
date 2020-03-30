package global.sesoc.brr.controller;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping(value = "api")

@Controller
public class ApiController {
	
	
	@RequestMapping(value = "/apimap", method = RequestMethod.GET)
	public String apimap() {
		return "api/apimap";
	}
	
}

