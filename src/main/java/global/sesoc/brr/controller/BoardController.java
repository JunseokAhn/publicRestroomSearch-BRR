package global.sesoc.brr.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "board")
public class BoardController {

	@GetMapping(value = "boardMain")
	public String boardMain() {
		return "board/boardMain";
	}
}