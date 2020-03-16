package global.sesoc.brr.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.brr.dao.DAO;

@Controller
@RequestMapping("examples")
public class SampleController {

	private static final Logger logger = LoggerFactory.getLogger(Controller.class);

	@Autowired
	private DAO dao;

	@GetMapping(value = "documentation")
	public String documentation() {
		return "examples/documentation";
	}

	@GetMapping(value = "icons")
	public String icons() {
		return "examples/icons";
	}

	@GetMapping(value = "login")
	public String login() {
		return "examples/login";
	}

	@GetMapping(value = "map")
	public String map() {
		return "examples/map";
	}

	@GetMapping(value = "maps")
	public String maps() {
		return "examples/maps";
	}

	@GetMapping(value = "profile")
	public String profile() {
		return "examples/profile";
	}

	@GetMapping(value = "register")
	public String register() {
		return "examples/register";
	}

	@GetMapping(value = "tables")
	public String tables() {
		return "examples/tables";
	}

	@GetMapping(value = "upgrade")
	public String upgrade() {
		return "examples/upgrade";
	}
}
