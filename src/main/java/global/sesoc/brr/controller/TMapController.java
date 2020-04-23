package global.sesoc.brr.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.brr.dao.GoogleMapsDAO;
import global.sesoc.brr.vo.LocationVO;
import global.sesoc.brr.vo.NearbyToiletVO;
import global.sesoc.brr.vo.ToiletVO;

@Controller
@RequestMapping(value = "maps")
public class TMapController {

	@Autowired
	GoogleMapsDAO dao;
	LocationVO lo = new LocationVO();

	@GetMapping(value = "mapsMain")
	public String MapsMain(Model model) {

		/*
		 * 데이터파싱연습 RestTemplate restTemplate = new RestTemplate(); URI uri =
		 * UriComponentsBuilder.fromHttpUrl(//길찾기경로 origin=출발지
		 * destination=도착지인것같다.
		 * "https://maps.googleapis.com/maps/api/directions/json?origin=41.43206,-81.38992&destination=41.43206,-81.38992&key=AIzaSyDkQ00U2AUBQSS1CJF5YveL-1YWsTjaRGA")
		 * .queryParam("key", "value").build().toUri(); // String response =
		 * restTemplate.getForObject(uri, String.class); 또는
		 * ResponseEntity<String> responseEntity =
		 * restTemplate.getForEntity(uri, String.class);
		 * System.out.println(responseEntity); model.addAttribute("directions",
		 * responseEntity);
		 */
		return "maps/mapsMain";
	}

	@ResponseBody
	@PostMapping(value = "getLocation")
	public ArrayList<NearbyToiletVO> getLocation(String lat, String lng) {
		lo = new LocationVO(lat, lng);
		ArrayList<NearbyToiletVO> list = dao.getNearbyToilet(lo);
		
		return list;
	}
	
	@ResponseBody
	@PostMapping(value = "searchRating", produces = "application/text; charset=utf8")
	public String searchRating(String lat, String lng){
		lo = new LocationVO(lat, lng);
		String toiletNm = dao.searchRating(lo);
		System.out.println(toiletNm);
		return toiletNm;
	}

}
