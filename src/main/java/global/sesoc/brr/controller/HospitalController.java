package global.sesoc.brr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
@RequestMapping(value = "api")
@Controller
public class HospitalController {

	@RequestMapping(value = "/hospital", method = RequestMethod.GET)
	public String apihospital() {
		return "api/hospital";
	}
}
