package global.sesoc.brr.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.brr.vo.ToiletVO;

@Controller
@CrossOrigin(origins = "*")
@RequestMapping("test")
public class TestController 
{	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test() throws IOException 
	{		
		String strUrl = "http://api.data.go.kr/openapi/pblic-toilet-std";
		strUrl += "?serviceKey=WxmY00Tj2kX1M75S9K3bJ6T83gRglX6tD1NR1RFQaYq8C9FWrOA2%2FloB0ciJYKIuP5%2BQ8fQw8VIi5UiIK0rIEA%3D%3D";
		strUrl += "&type=xml";
		strUrl += "&pageNo=1";
		strUrl += "&numOfRows=1";
		
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
		ArrayList<ToiletVO> list = new ArrayList<>();
		while((current = in.readLine()) != null)
		{
			//list.add((ToiletVO)current);
		    urlString += current+"\n";
		}
		System.out.println(urlString);
		
		return "sample";
	}
	
	
}
