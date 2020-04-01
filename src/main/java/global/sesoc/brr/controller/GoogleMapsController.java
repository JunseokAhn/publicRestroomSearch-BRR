package global.sesoc.brr.controller;

import java.net.URI;
import java.util.ArrayList;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import global.sesoc.brr.dao.GoogleMapsDAO;
import global.sesoc.brr.vo.LocationVO;
import global.sesoc.brr.vo.NearbyToiletVO;

@Controller
@RequestMapping(value = "maps")
public class GoogleMapsController {

	GoogleMapsDAO dao = new GoogleMapsDAO();
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
	public String getLocation(String lat, String lng) {
		lo = new LocationVO(lat, lng);
		ArrayList<NearbyToiletVO> list = dao.getToilet(lo);

		return lat;
	}

}
