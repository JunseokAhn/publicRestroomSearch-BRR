package global.sesoc.brr.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.brr.dao.DiaryDAO;
import global.sesoc.brr.vo.resVO;


@RequestMapping(value = "api")
@Controller
public class HospitalController {
	 @Autowired
	 private DiaryDAO dao;
	
	 @RequestMapping(value = "/hospital", method = RequestMethod.GET)
	public String apihospital(Model model) {
		
		ArrayList<resVO> list = dao.list();
		
		model.addAttribute("list",list);
		return "api/hospital";
	}
}
