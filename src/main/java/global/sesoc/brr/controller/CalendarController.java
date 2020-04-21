package global.sesoc.brr.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.brr.dao.DiaryDAO;
import global.sesoc.brr.vo.DateData;
import global.sesoc.brr.vo.resVO;

@Controller
@RequestMapping(value = "diary")
public class CalendarController {

	@Autowired
	DiaryDAO dao;

	
	@RequestMapping(value = "/diaryRecord", method = RequestMethod.GET)
	public String record(Model model, HttpServletRequest request, DateData dateData) {
		Calendar cal = Calendar.getInstance();
		DateData calendarData;
		
		//검색 날짜
		if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
			dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null,null);
			}
		
		
		//검색날짜end
		Map<String, Integer> today_info =  dateData.today_info(dateData);
		List<DateData> dateList = new ArrayList<DateData>();
		
		

		
		ArrayList<resVO> list =  dao.list(dateData);
		

		System.out.println("list:"+list);
		
		System.out.println("이건무너배열:"+dateData);
		
		//달력데이터에 넣기 위한 배열 추가
		resVO[][] schedule_data_arr = new resVO[32][4];
		if(list.isEmpty()!=true){
		int j = 0;
		for(int i=0; i<list.size(); i++){
		int date = Integer.parseInt(String.valueOf(list.get(i).getInputdate()).substring(String.valueOf(list.get(i).getInputdate()).length()-2,String.valueOf(list.get(i).getInputdate()).length()));
		System.out.println("date:?"+date);
		if(i>0){
		int date_before = Integer.parseInt(String.valueOf(list.get(i-1).getInputdate()).substring(String.valueOf(list.get(i-1).getInputdate()).length()-2,String.valueOf(list.get(i-1).getInputdate()).length()));
		System.out.println("date_before:?"+date_before);
		if(date_before==date){
		j=j+1;
		schedule_data_arr[date][j] = list.get(i);
		}else{
		j=0;
		schedule_data_arr[date][j] =list.get(i);
		}
		}else{
		schedule_data_arr[date][j] = list.get(i);
		}
		}
		}
		


		
		
		

		//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
		//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
		for(int i=1; i<today_info.get("start"); i++){
			calendarData= new DateData(null, null, null, null);
			dateList.add(calendarData);
		}
		
		//날짜 삽입
		for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
			
			resVO[] schedule_data_arr3 = new resVO[4];
			schedule_data_arr3 = schedule_data_arr[i];
			


			
			if(i==today_info.get("today")){
				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today", schedule_data_arr3);
			}else{
				calendarData= new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date", schedule_data_arr3);
			}
			dateList.add(calendarData);
		}

		//달력 빈곳 빈 데이터로 삽입
		int index = 7-dateList.size()%7;
		
		if(dateList.size()%7!=0){
			
			for (int i = 0; i < index; i++) {
				calendarData= new DateData(null, null, null, null);
				dateList.add(calendarData);
			}
		}
		
		//ArrayList<resVO> list =  dao.list(dateData);
		


		
		 
		
		
		
		
		
		System.out.println(dateList);
		System.out.println(today_info);
	
		//배열에 담음
		model.addAttribute("dateList", dateList);		//날짜 데이터 배열
		model.addAttribute("today_info", today_info);
		model.addAttribute("list",list);
		return "diary/diaryRecord";
		
	}
	
	
	//
	
}