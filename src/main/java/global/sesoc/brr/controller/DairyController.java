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
	//type1	
	@RequestMapping(value = "/type1brown", method = RequestMethod.GET)
	public String type1brown() {
		return "api/type1brown";
	}
	@RequestMapping(value = "/type1red", method = RequestMethod.GET)
	public String type1red() {
		return "api/type1red";
	}
	@RequestMapping(value = "/type1yellow", method = RequestMethod.GET)
	public String type1yellow() {
		return "api/type1yellow";
	}
	@RequestMapping(value = "/type1gray", method = RequestMethod.GET)
	public String type1gray() {
		return "api/type1gray";
	}
//type2
	@RequestMapping(value = "/type2brown", method = RequestMethod.GET)
	public String type2brown() {
		return "api/type2brown";
	}
	@RequestMapping(value = "/type2red", method = RequestMethod.GET)
	public String type2red() {
		return "api/type2red";
	}
	@RequestMapping(value = "/type2yellow", method = RequestMethod.GET)
	public String type2yellow() {
		return "api/type2yellow";
	}
	@RequestMapping(value = "/type2gray", method = RequestMethod.GET)
	public String type2gray() {
		return "api/type2gray";
	}
	
//type3
	@RequestMapping(value = "/type3brown", method = RequestMethod.GET)
	public String type3brown() {
		return "api/type3brown";
	}
	@RequestMapping(value = "/type3red", method = RequestMethod.GET)
	public String type3red() {
		return "api/type3red";
	}
	@RequestMapping(value = "/type3yellow", method = RequestMethod.GET)
	public String type3yellow() {
		return "api/type3yellow";
	}
	@RequestMapping(value = "/type3gray", method = RequestMethod.GET)
	public String type3gray() {
		return "api/type3gray";
	}
	//type4
	@RequestMapping(value = "/type4brown", method = RequestMethod.GET)
	public String type4brown() {
		return "api/type4brown";
	}
	@RequestMapping(value = "/type4red", method = RequestMethod.GET)
	public String type4red() {
		return "api/type4red";
	}
	@RequestMapping(value = "/type4yellow", method = RequestMethod.GET)
	public String type4yellow() {
		return "api/type4yellow";
	}
	@RequestMapping(value = "/type4gray", method = RequestMethod.GET)
	public String type4gray() {
		return "api/type4gray";
	}
} 
