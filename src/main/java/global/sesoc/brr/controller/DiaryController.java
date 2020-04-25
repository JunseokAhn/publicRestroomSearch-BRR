package global.sesoc.brr.controller;

import java.util.ArrayList;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@ResponseBody
	@RequestMapping (value="/insert", method=RequestMethod.POST)
	public String insert(resVO resVO, HttpSession session) 
	{
		
		resVO.setId((String)session.getAttribute("sessionId"));
		System.out.println(resVO.toString());
		
		if(dao.insert(resVO))
		{			
			if(resVO.getStatus()==1)
			{
				System.out.println("위험상황입니다.\n알려줘야합니다.");				
				return "warning";
			}
			else
			{
				System.out.println("삽입성공");
				return "success";
			}			
		}
		
		System.out.println("삽입실패");
		return "error";
	}


	@RequestMapping(value = "/rcd", method = RequestMethod.GET)
	public String record2() {
		return "diary/rcd";
	}	
} 
