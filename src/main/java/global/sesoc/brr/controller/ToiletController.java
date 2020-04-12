package global.sesoc.brr.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.brr.dao.ToiletDAO;

import global.sesoc.brr.vo.ToiletVO;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("toilet")
public class ToiletController {

	private static final Logger logger = LoggerFactory.getLogger(ToiletController.class);
	
	@Autowired
	private ToiletDAO toiletDAO;
	
	@RequestMapping(value = "/toiletRecv", method = RequestMethod.GET)
	public String toiletRecv() throws IOException 
	{		

		return "toilet/toiletRecv";
	}
	
	@ResponseBody
	@RequestMapping(value = "/receive", method = RequestMethod.GET)
	public String ReceiveToiletInfo(Model model) throws IOException 
	{		
		int apiSize = 0;
		int tableSize = toiletDAO.countToiletInfo();
		int readSize =100;//한번에 읽는 크기
		
		if(tableSize>32000)
		{
			logger.debug("데이터가 최신화 되어있습니다.");
			return "success";
		}

		try
		{
			String strUrl = "http://api.data.go.kr/openapi/pblic-toilet-std";
			strUrl += "?serviceKey=WxmY00Tj2kX1M75S9K3bJ6T83gRglX6tD1NR1RFQaYq8C9FWrOA2%2FloB0ciJYKIuP5%2BQ8fQw8VIi5UiIK0rIEA%3D%3D";
			strUrl += "&type=json";
			strUrl += "&numOfRows=1";
			strUrl += "&pageNo=1";	
			URL url = new URL(strUrl);
			URLConnection urlConnection = url.openConnection();
			HttpURLConnection connection = null;
			if(urlConnection instanceof HttpURLConnection)
			{
				connection = (HttpURLConnection) urlConnection;
			}
			else
			{
				System.out.println("error");
				return null;
			}
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));

			String urlString = "";
			String current;			


			while((current = in.readLine()) != null)
			{
				urlString =urlString.concat(current);			   
			}

			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(urlString);

			// Top레벨 단계인 response 키를 가지고 데이터를 파싱합니다. 
			JSONObject parse_response = (JSONObject) obj.get("response"); 
			// response 로 부터 body 찾아옵니다. 
			JSONObject parse_body = (JSONObject) parse_response.get("body");

			apiSize = Integer.parseInt((String)parse_body.get("totalCount"));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		//테이블 사이즈와 api 정보 사이즈가 같을 경우
		if(tableSize>32000)
		{
			logger.debug("데이터가 최신화 되어있습니다.");
		}
		else//다를 경우 갱신
		{
			toiletDAO.deleteAllToiletInfo();
			ToiletVO temp = new ToiletVO();		
			
			//반복해야 할 횟수 구하기
			int repeatNumber = apiSize/readSize;
			//나머지가 남을 경우 1을 더 해준다.			
			if((apiSize%readSize)!=0)
			{
				repeatNumber++;
			}
			model.addAttribute("total", repeatNumber);
			try
			{			
				String strUrl = "http://api.data.go.kr/openapi/pblic-toilet-std";
				strUrl += "?serviceKey=WxmY00Tj2kX1M75S9K3bJ6T83gRglX6tD1NR1RFQaYq8C9FWrOA2%2FloB0ciJYKIuP5%2BQ8fQw8VIi5UiIK0rIEA%3D%3D";
				strUrl += "&type=json";
				strUrl += "&numOfRows="+readSize;
				strUrl += "&pageNo=";			
				
				String urlTemp=null;
				URL url = null;
				URLConnection urlConnection = null;
				HttpURLConnection connection = null;
				BufferedReader in=null;
				for(int i = 1;i<=repeatNumber;i++)
				{
					model.addAttribute("present", i);
					urlTemp=strUrl+i;
					
					url = new URL(urlTemp);
					urlConnection = url.openConnection();
					
					if(urlConnection instanceof HttpURLConnection)
					{
						connection = (HttpURLConnection) urlConnection;
					}
					else
					{
					    System.out.println("error");
					    return null;
					}
					in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			
					String urlString = "";
					String current;			
				
					while((current = in.readLine()) != null)
					{
						urlString =urlString.concat(current);			   
					}
					
					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(urlString);
					
					// Top레벨 단계인 response 키를 가지고 데이터를 파싱합니다. 
					JSONObject parse_response = (JSONObject) obj.get("response"); 
					// response 로 부터 body 찾아옵니다. 
					JSONObject parse_body = (JSONObject) parse_response.get("body");
					
					// body 로 부터 items 받아옵니다. 
					JSONArray parse_items = (JSONArray) parse_body.get("items");					
					
					JSONObject toiletInfo; 			
					
					// 필요한 데이터만 가져오려고합니다. 
					for(int j = 0 ; j < parse_items.size(); j++) 
					{ 				
						toiletInfo = (JSONObject) parse_items.get(j); 
						
						logger.debug((String)toiletInfo.get("toiletNm"));
						
						temp.setToiletType((String)toiletInfo.get("toiletType"));				
						temp.setToiletNm((String)toiletInfo.get("toiletNm"));
						temp.setLnmadr((String)toiletInfo.get("lnmadr"));
						temp.setUnisexToiletYn((String)toiletInfo.get("unisexToiletYn"));
						temp.setMenToiletBowlNumber(Integer.parseInt((String)toiletInfo.get("menToiletBowlNumber")));
						temp.setMenUrineNumber(Integer.parseInt((String)toiletInfo.get("menUrineNumber")));
						temp.setMenHandicapToiletBowlNumber(Integer.parseInt((String)toiletInfo.get("menHandicapToiletBowlNumber")));
						temp.setMenChildrenUrinalNumber(Integer.parseInt((String)toiletInfo.get("menHandicapUrinalNumber")));
						
						if(((String)toiletInfo.get("menChildrenToiletBowlNumber")).equals("."))
						{
							temp.setMenChildrenToiletBowlNumber(0);
						}
						else
						{
							temp.setMenChildrenToiletBowlNumber(Integer.parseInt((String)toiletInfo.get("menChildrenToiletBowlNumber")));
						}
						
						if(((String)toiletInfo.get("menChildrenUrinalNumber")).equals("."))
						{
							temp.setMenChildrenToiletBowlNumber(0);
						}
						else
						{
							temp.setMenChildrenUrinalNumber(Integer.parseInt((String)toiletInfo.get("menChildrenUrinalNumber")));
						}						
						
						temp.setLadiesToiletBowlNumber(Integer.parseInt((String)toiletInfo.get("ladiesToiletBowlNumber")));
						temp.setLadiesHandicapToiletBowlNumber(Integer.parseInt((String)toiletInfo.get("ladiesHandicapToiletBowlNumber")));
						temp.setLadiesChildrenToiletBowlNumber(Integer.parseInt((String)toiletInfo.get("ladiesChildrenToiletBowlNumber")));
						temp.setInstitutionNm((String)toiletInfo.get("institutionNm"));
						temp.setPhoneNumber((String)toiletInfo.get("phoneNumber"));
						temp.setOpenTime((String)toiletInfo.get("openTime"));

						logger.debug((String)toiletInfo.get("latitude"));
						logger.debug((String)toiletInfo.get("hardness"));
						if(((String)toiletInfo.get("latitude")).length()!=4&&((String)toiletInfo.get("hardness")).length()!=4)
						{							
							temp.setLat(Double.parseDouble((String)toiletInfo.get("latitude")));
							temp.setLng(Double.parseDouble((String)toiletInfo.get("hardness")));							
						}
						else
						{
							temp.setLat(-9999);
							temp.setLng(-9999);		
						}
						
						//logger.debug(temp.toString());
						
						if(toiletDAO.insertToiletInfo(temp)) logger.debug("삽입성공");
						else
						{
							logger.debug("삽입실패");
							return "error";
						}
					}			
		
					urlTemp="";
				}
				in.close();
			} 
			catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		}				
		return "success";
	}
}
