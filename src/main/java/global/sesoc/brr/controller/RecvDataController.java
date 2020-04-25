package global.sesoc.brr.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

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
import org.xml.sax.InputSource;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import global.sesoc.brr.dao.HospitalDAO;
import global.sesoc.brr.dao.ToiletDAO;
import global.sesoc.brr.vo.HospitalVO;
import global.sesoc.brr.vo.ToiletVO;



@Controller
@CrossOrigin(origins = "*")
@RequestMapping("toilet")
public class RecvDataController {

	private static final Logger logger = LoggerFactory.getLogger(RecvDataController.class);
	
	@Autowired
	private ToiletDAO toiletDAO;
	@Autowired
	private HospitalDAO hospitalDAO;
	
	@RequestMapping(value = "/toiletRecv", method = RequestMethod.GET)
	public String toiletRecv() throws IOException 
	{		

		return "toilet/toiletRecv";
	}
	
	@ResponseBody
	@RequestMapping(value = "/receive", method = RequestMethod.GET)
	public String ReceiveData(Model model) throws IOException, ParserConfigurationException 
	{	
		//api 사이즈
		int toiletApiSize = 0;
		int hospitalApiSize=0;
		//테이블 현황확인
		boolean toiletFlag = false;
		boolean hospitalFlag = false;
		
		//테이블 사이즈
		int toiletTableSize = toiletDAO.countToiletInfo();
		int hospitalTableSize=hospitalDAO.countHospitalInfo();
		
		int readSize =100;//한번에 읽는 크기
		
		if(toiletTableSize<32000)
		{
			logger.debug("화장실 데이터 필요");
			toiletFlag=true;
			
		}
		if(hospitalTableSize<18600)
		{
			logger.debug("병원 데이터 필요");
			hospitalFlag=true;
		}
		
		if((!toiletFlag)&&(!hospitalFlag))
		{
			logger.debug("모든 데이터가 최신데이터");
			return "success";
		}
			
		//화장실 데이터 받기
		if(toiletFlag)
		{
			//화장실 api 데이터 사이즈 체크
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

				toiletApiSize = Integer.parseInt((String)parse_body.get("totalCount"));
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			//화장실 데이터 받기
			toiletDAO.deleteAllToiletInfo();
			ToiletVO temp = new ToiletVO();		
			
			//반복해야 할 횟수 구하기
			int repeatNumber = toiletApiSize/readSize;
			//나머지가 남을 경우 1을 더 해준다.			
			if((toiletApiSize%readSize)!=0)
			{
				repeatNumber++;
			}
			
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
		
		//병원 데이터 받기
		if(hospitalFlag)
		{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			factory.setNamespaceAware(true);
			
			DocumentBuilder builder = factory.newDocumentBuilder();	       
	        
	        Document doc = null;
	
			//병원 api 데이터 사이즈 체크
			try
			{
				String strUrl = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncFullDown";
				strUrl += "?serviceKey=WxmY00Tj2kX1M75S9K3bJ6T83gRglX6tD1NR1RFQaYq8C9FWrOA2%2FloB0ciJYKIuP5%2BQ8fQw8VIi5UiIK0rIEA%3D%3D";
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

				 InputSource is = new InputSource(new StringReader(urlString));		  
				
				 doc = builder.parse(is);
		         XPathFactory xpathFactory = XPathFactory.newInstance();
		         XPath xpath = xpathFactory.newXPath();		
		         XPathExpression expr = xpath.compile("//totalCount");
		         NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
		         NodeList child = nodeList.item(0).getChildNodes();
		         Node node = child.item(0);
		         hospitalApiSize =Integer.parseInt(node.getTextContent());
		         logger.debug(""+hospitalApiSize);		         
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			//화장실 데이터 받기
			hospitalDAO.deleteAllHospitalInfo();
			HospitalVO temp = new HospitalVO();		
			
			//반복해야 할 횟수 구하기
			int repeatNumber = hospitalApiSize/readSize;
			//나머지가 남을 경우 1을 더 해준다.			
			if((hospitalApiSize%readSize)!=0)
			{
				repeatNumber++;
			}
			
			//병원 데이터 받기			
			try
			{		
				String strUrl = "http://apis.data.go.kr/B552657/HsptlAsembySearchService/getHsptlMdcncFullDown";
				strUrl += "?serviceKey=WxmY00Tj2kX1M75S9K3bJ6T83gRglX6tD1NR1RFQaYq8C9FWrOA2%2FloB0ciJYKIuP5%2BQ8fQw8VIi5UiIK0rIEA%3D%3D";
				strUrl += "&numOfRows="+readSize;
				strUrl += "&pageNo=";					
				
				
				String urlTemp=null;
				URL url = null;
				URLConnection urlConnection = null;
				HttpURLConnection connection = null;
				BufferedReader in=null;
				
				for(int i = 1;i<=repeatNumber;i++)
				{					
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
					
					InputSource is = new InputSource(new StringReader(urlString));		  
					
					 doc = builder.parse(is);
//			         XPathFactory xpathFactory = XPathFactory.newInstance();
//			         XPath xpath = xpathFactory.newXPath();		
//			         XPathExpression expr = xpath.compile("//items");
			         NodeList nodeList = doc.getElementsByTagName("item");
			         
			         
			         
			         logger.debug("노드배열의 총 사이즈 : "+nodeList.getLength());
			         
			         boolean flag = false;
			         String dutyDivNam ="";
			         String dutyName = "";
			         String dutyTel1="";
			         String dutyAddr="";
			         String dutyTimeS="";
			         String dutyTimeC="";
			         String dutyTimeSatS="";
			         String dutyTimeSatC="";
			         String dutyTimeSunS="";
			         String dutyTimeSunC="";
			         double lat=0;
			         double lng=0;    
			         HospitalVO voTemp = new HospitalVO();
			         
			         
			         for (int j = 0; j < nodeList.getLength(); j++) 
			         {
			                Node item = nodeList.item(j);
			                NodeList hospitalInfoTemp = item.getChildNodes();
			                
			                
			                for(int k = 0; k<hospitalInfoTemp.getLength();k++)
			                {
			                	Node infoTemp = hospitalInfoTemp.item(k);
			                	
			                	String nodeName = infoTemp.getNodeName();
			                	
			                	if(!flag)
			                	{
			                		if(nodeName.equals("dutyDivNam"))
				                	{
				                		if(!(infoTemp.getTextContent().equals("의원")||infoTemp.getTextContent().equals("한의원")))
				                		{				                			
				                			break;
				                		}
				                		else
				                		{
				                			dutyDivNam = infoTemp.getTextContent();
				                			flag = true;
				                		}
				                	}
			                	}
			                	
			                	
			                	if(nodeName.equals("dutyName"))
			                	{
			                		dutyName = infoTemp.getTextContent();
			                	}
			                	else if(nodeName.equals("dutyTel1"))
			                	{
			                		dutyTel1 = infoTemp.getTextContent();
			                	}
			                	else if(nodeName.equals("dutyAddr"))
			                	{
			                		dutyAddr = infoTemp.getTextContent();
			                	}
			                	else if(nodeName.equals("dutyTime1s"))
			                	{
			                		dutyTimeS = infoTemp.getTextContent();
			                	}
			                	else if(nodeName.equals("dutyTime1c"))
			                	{
			                		dutyTimeC = infoTemp.getTextContent();
			                	}
			                	else if(nodeName.equals("dutyTime6s"))
			                	{
			                		dutyTimeSatS = infoTemp.getTextContent();
			                	}
			                	else if(nodeName.equals("dutyTime6c"))
			                	{
			                		dutyTimeSatC = infoTemp.getTextContent();
			                	}
			                	else if(nodeName.equals("dutyTime7s"))
			                	{
			                		dutyTimeSunS = infoTemp.getTextContent();
			                	}
			                	else if(nodeName.equals("dutyTime7c"))
			                	{
			                		dutyTimeSunC = infoTemp.getTextContent();
			                	}
			                	else if(nodeName.equals("wgs84Lat"))
			                	{
			                		lat = Double.parseDouble(infoTemp.getTextContent());
			                	}
			                	else if(nodeName.equals("wgs84Lon"))
			                	{
			                		lng = Double.parseDouble(infoTemp.getTextContent());
			                	}			                	
			                }
			                
			                if(flag)
			                {
			                	//판단 후 삽입
				                if(dutyDivNam.equals("의원"))
				                {			                		
				                	if(dutyName.contains("내과"))
				                	{
				                		voTemp.setDutyName(dutyName);
				                		voTemp.setDutyAddr(dutyAddr);
				                		voTemp.setDutyTel1(dutyTel1);
				                		voTemp.setDutyTimeS(dutyTimeS);
				                		voTemp.setDutyTimeC(dutyTimeC);
				                		
				                		voTemp.setDutyTimeSatS(dutyTimeSatS);
				                		voTemp.setDutyTimeSatC(dutyTimeSatC);
				                		voTemp.setDutyTimeSunS(dutyTimeSunS);
				                		voTemp.setDutyTimeSunC(dutyTimeSunC);
				                		
				                		voTemp.setLat(lat);
				                		voTemp.setLng(lng);	
				                		logger.debug(voTemp.toString());
				                		
				                		if(hospitalDAO.insertHospitalInfo(voTemp))
						                {
						                	logger.debug("삽입성공");						                	
						                }
						                else
						                {
						                	logger.debug("삽입실패");
											return "error";
						                }
				                	}
				                }
				                else
				                {
				                	voTemp.setDutyName(dutyName);
			                		voTemp.setDutyAddr(dutyAddr);
			                		voTemp.setDutyTel1(dutyTel1);
			                		voTemp.setDutyTimeS(dutyTimeS);
			                		voTemp.setDutyTimeC(dutyTimeC);
			                		voTemp.setDutyTimeSatS(dutyTimeSatS);
			                		voTemp.setDutyTimeSatC(dutyTimeSatC);
			                		voTemp.setDutyTimeSunS(dutyTimeSunS);
			                		voTemp.setDutyTimeSunC(dutyTimeSunC);
			                		voTemp.setLat(lat);
			                		voTemp.setLng(lng);	
			                		logger.debug(voTemp.toString());
			                		
			                		if(hospitalDAO.insertHospitalInfo(voTemp))
					                {
					                	logger.debug("삽입성공");					                	
					                }
					                else
					                {
					                	logger.debug("삽입실패");
										return "error";
					                }
				                }				                
				                flag = false;
			                }	
			                
			                dutyDivNam ="";
					        dutyName ="";
					        dutyTel1="";
					        dutyAddr="";
					        dutyTimeS="";
					        dutyTimeC="";
					        dutyTimeSatS="";
					        dutyTimeSatC="";
					        dutyTimeSunS="";
					        dutyTimeSunC="";
					        lat=0;
					        lng=0;    
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
	
	@ResponseBody
	@RequestMapping(value = "/receive_near_hospital", method = RequestMethod.POST)
	public ArrayList<HospitalVO> GetNearHospitalList(double lat, double lng) 
	{			
		logger.debug("위도"+lat);
		logger.debug("경도"+lng);
		ArrayList<HospitalVO> temp = hospitalDAO.GetNearHospitalList(lat, lng);
		
		return temp;
	}	
}












