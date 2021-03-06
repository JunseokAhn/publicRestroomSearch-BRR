package global.sesoc.brr.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class ExamplesController {

	private static final Logger logger = LoggerFactory.getLogger(Controller.class);

//	@Autowired
//	private DAO dao;

	@GetMapping(value = "documentation")
	public String documentation() {
		return "examples/documentation";
	}

	@GetMapping(value = "icons")
	public String icons() {
		return "examples/icons";
	}

	@GetMapping(value = "member/login")
	public String login() {
		return "member/login";
	}

	@GetMapping(value = "map")
	public String map() {
		return "examples/map";
	}

	@GetMapping(value = "maps")
	public String maps() {
		return "examples/maps";
	}

	@GetMapping(value = "member/profile")
	public String profile() {
		return "member/profile";
	}

//	@GetMapping(value = "signup")
//	public String signup() {
//		return "examples/signup";
//	}

	@GetMapping(value = "tables")
	public String tables() {
		return "examples/tables";
	}
	
	@GetMapping(value = "upgrade")
	public String upgrade() {
		return "examples/upgrade";
	}

	@GetMapping(value = "index")
	public String index() {
		return "examples/index";
	}
}
