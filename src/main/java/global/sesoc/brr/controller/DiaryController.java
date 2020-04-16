package global.sesoc.brr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import global.sesoc.brr.dao.DiaryDAO;
import global.sesoc.brr.vo.resVO;


@RequestMapping(value="diary")
@Controller
public class DiaryController {
	@Autowired
	DiaryDAO dao;

	
	@RequestMapping(value = "/diaryMain", method = RequestMethod.GET)
	public String apidairy2() {
		return "diary/diaryMain";
	}
	//type1	
	@RequestMapping(value = "/type1brown", method = RequestMethod.GET)
	public String type1brown() {
		return "diary/type1brown";
	}
	@RequestMapping(value = "/type1red", method = RequestMethod.GET)
	public String type1red() {
		return "diary/type1red";
	}
	@RequestMapping(value = "/type1yellow", method = RequestMethod.GET)
	public String type1yellow() {
		return "diary/type1yellow";
	}
	@RequestMapping(value = "/type1gray", method = RequestMethod.GET)
	public String type1gray() {
		return "diary/type1gray";
	}
//type2
	@RequestMapping(value = "/type2brown", method = RequestMethod.GET)
	public String type2brown() {
		return "diary/type2brown";
	}
	@RequestMapping(value = "/type2red", method = RequestMethod.GET)
	public String type2red() {
		return "diary/type2red";
	}
	@RequestMapping(value = "/type2yellow", method = RequestMethod.GET)
	public String type2yellow() {
		return "diary/type2yellow";
	}
	@RequestMapping(value = "/type2gray", method = RequestMethod.GET)
	public String type2gray() {
		return "diary/type2gray";
	}
	
//type3
	@RequestMapping(value = "/type3brown", method = RequestMethod.GET)
	public String type3brown() {
		return "diary/type3brown";
	}
	@RequestMapping(value = "/type3red", method = RequestMethod.GET)
	public String type3red() {
		return "diary/type3red";
	}
	@RequestMapping(value = "/type3yellow", method = RequestMethod.GET)
	public String type3yellow() {
		return "diary/type3yellow";
	}
	@RequestMapping(value = "/type3gray", method = RequestMethod.GET)
	public String type3gray() {
		return "diary/type3gray";
	}
	//type4
	@RequestMapping(value = "/type4brown", method = RequestMethod.GET)
	public String type4brown() {
		return "diary/type4brown";
	}
	@RequestMapping(value = "/type4red", method = RequestMethod.GET)
	public String type4red() {
		return "diary/type4red";
	}
	@RequestMapping(value = "/type4yellow", method = RequestMethod.GET)
	public String type4yellow() {
		return "diary/type4yellow";
	}
	@RequestMapping(value = "/type4gray", method = RequestMethod.GET)
	public String type4gray() {
		return "diary/type4gray";
	}
	
	//insert
	
	
	@ResponseBody
	@RequestMapping (value="insert", method=RequestMethod.POST)
	public void insert(resVO res) {
		System.out.println(res);
		dao.insert(res);
	}

	
	@RequestMapping(value = "/diaryRecord", method = RequestMethod.GET)
	public String record() {
		return "diary/diaryRecord";
	}
	
	
} 
