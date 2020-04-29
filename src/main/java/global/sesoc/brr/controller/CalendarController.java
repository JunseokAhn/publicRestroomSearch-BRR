package global.sesoc.brr.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.brr.dao.DiaryDAO;
import global.sesoc.brr.vo.DateData;
import global.sesoc.brr.vo.TestDataVO;
import global.sesoc.brr.vo.resVO;

@Controller
@RequestMapping(value = "calendar")
public class CalendarController 
{

	@Autowired
	DiaryDAO dao;

	@ResponseBody
	@RequestMapping(value = "/diaryRecord", method = RequestMethod.POST)
	public Map<String, Integer> showDate(HttpServletRequest request, DateData dateData) 
	{
		System.out.println("들어왔다");
		Calendar cal = Calendar.getInstance();
		DateData calendarData;
		
		//검색 날짜
		if(dateData.getDate().equals("")&&dateData.getMonth().equals(""))
		{
			dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null,null);
		}	
		
		//검색날짜end
		Map<String, Integer> today_info =  dateData.today_info(dateData);
		List<DateData> dateList = new ArrayList<DateData>();			
		
		

		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		for(int i=1; i<today_info.get("start"); i++)
		{
			calendarData= new DateData(null, null, null, null);
			dateList.add(calendarData);
		}
		
		//날짜 삽입
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) 
		{
			
			resVO[] schedule_data_arr3 = new resVO[4];
			//schedule_data_arr3 = schedule_data_arr[i];
			
			if(i==today_info.get("today"))
			{
				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today", schedule_data_arr3);
			}
			else
			{
				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date", schedule_data_arr3);
			}
			dateList.add(calendarData);
		}

		//달력 빈곳 빈 데이터로 삽입
		int index = 7-dateList.size()%7;
		
		if(dateList.size()%7!=0)
		{			
			for (int i = 0; i < index; i++) 
			{
				calendarData= new DateData(null, null, null, null);
				dateList.add(calendarData);
			}
		}
		
		//ArrayList<resVO> list =  dao.list(dateData);		
		
		System.out.println(dateList);
		System.out.println("내가 필요한 거 : " +today_info);		
		
		return today_info;		
	}
	
	@ResponseBody
	@RequestMapping(value = "/diaryGetDate", method = RequestMethod.POST)
	public ArrayList<DateData> getDate(HttpServletRequest request, DateData dateData) 
	{
		System.out.println("들어왔다");
		Calendar cal = Calendar.getInstance();
		DateData calendarData;
		
		//검색 날짜
		if(dateData.getDate().equals("")&&dateData.getMonth().equals(""))
		{
			dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null,null);
		}	
		
		//검색날짜end
		Map<String, Integer> today_info =  dateData.today_info(dateData);
		ArrayList<DateData> dateList = new ArrayList<DateData>();			
		
		System.out.println("여기까지 왔다.");
		
		System.out.println("이건무너배열:"+dateData);		

		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		for(int i=1; i<today_info.get("start"); i++)
		{
			calendarData= new DateData(null, null, null, null);
			dateList.add(calendarData);
		}
		
		//날짜 삽입
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) 
		{
			
			resVO[] schedule_data_arr3 = new resVO[4];
			//schedule_data_arr3 = schedule_data_arr[i];
			
			if(i==today_info.get("today"))
			{
				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today", schedule_data_arr3);
			}
			else
			{
				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date", schedule_data_arr3);
			}
			dateList.add(calendarData);
		}

		//달력 빈곳 빈 데이터로 삽입
		int index = 7-dateList.size()%7;
		
		if(dateList.size()%7!=0)
		{			
			for (int i = 0; i < index; i++) 
			{
				calendarData= new DateData(null, null, null, null);
				dateList.add(calendarData);
			}
		}
		
		//ArrayList<resVO> list =  dao.list(dateData);		
		
		System.out.println("내가 필요한 거 : " + dateList);		
		
		return dateList;		
	}
	
	@ResponseBody
	@RequestMapping(value = "/diaryGetResultData", method = RequestMethod.POST)
	public ArrayList<TestDataVO> getResultData(DateData input, String id)
	{
		System.out.println(id);
		System.out.println(input.toString());
		HashMap<String,Object> temp = new HashMap<>();		
		temp.put("year", input.getYear());
		temp.put("month",input.getMonth());
		temp.put("id", id);
		ArrayList<TestDataVO> result = dao.GetTestResult(temp);
		
		System.out.println(result.size());
		
		return result;
	}	
}